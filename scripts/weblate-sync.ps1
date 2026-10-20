#Requires -Version 7.0
<#
.SYNOPSIS
    Sincronização e auditoria de projetos Weblate (API v1) do hub ptbr-translations.

.DESCRIPTION
    Ferramenta única para o ciclo de trabalho em projetos hospedados no Weblate.
    A entrega de um projeto de plataforma termina quando o componente está 100%
    traduzido no Weblate; nada aqui publica no GitHub.

    Ações:
      Status  Estatísticas de tradução por componente (e checagens falhando).
      Export  Exporta unidades (pendentes ou todas) para TSV (id, contexto, fonte, destino).
      Push    Envia um TSV (id<TAB>texto) via PATCH /units/{id}/.
      Check   Audita placeholders, ICU e balanceamento de chaves.
      Backup  Baixa o arquivo traduzido do componente.

.PARAMETER Token
    Token pessoal da API do Weblate. Padrão: variável de ambiente WEBLATE_TOKEN.
    Nunca versione o token.

.PARAMETER Project
    Slug do projeto no Weblate (ex.: elowry).

.PARAMETER Component
    Slug do componente (ex.: dnstoggle-strings). Obrigatório em Export, Check e Backup.
    Em Status, se omitido, lista todos os componentes do projeto.

.PARAMETER Language
    Código do idioma no Weblate (padrão: pt_BR).

.PARAMETER Tsv
    Caminho do TSV de entrada (Push) ou de saída (Status/Export/Check).

.PARAMETER OutFile
    Caminho do arquivo de saída (Backup).

.PARAMETER All
    Em Export, inclui também as unidades já traduzidas.

.EXAMPLE
    $env:WEBLATE_TOKEN = 'seu-token'
    ./scripts/weblate-sync.ps1 -Action Status -Project elowry

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Export -Project elowry -Component dnstoggle-strings -Tsv strings.tsv

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Push -Project elowry -Component dnstoggle-strings -Tsv lote.tsv

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Backup -Project elowry -Component dnstoggle-strings -OutFile DNSToggle/dnstoggle_strings_pt_BR.xml
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][ValidateSet('Status', 'Export', 'Push', 'Check', 'Backup')][string]$Action,
    [Parameter(Mandatory = $true)][string]$Project,
    [string]$Component,
    [string]$Language = 'pt_BR',
    [string]$Token = $env:WEBLATE_TOKEN,
    [string]$Tsv,
    [string]$OutFile,
    [switch]$All,
    [int]$DelayMs = 150,
    [string]$BaseUrl = 'https://hosted.weblate.org/api'
)

$ErrorActionPreference = 'Stop'
$utf8 = [System.Text.UTF8Encoding]::new($false)

if ([string]::IsNullOrWhiteSpace($Token)) {
    throw 'Token ausente. Defina $env:WEBLATE_TOKEN ou use -Token.'
}

# O Weblate pode estar atrás do Anubis; um UA de navegador evita o desafio.
$headers = @{
    Authorization = "Token $Token"
    Accept        = 'application/json'
    'User-Agent'  = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
}

function Assert-Json($Response, [string]$Url) {
    if ($Response -is [string] -and $Response.TrimStart().StartsWith('<')) {
        throw "A API retornou HTML (provável desafio do Anubis) em $Url. Verifique o token e o User-Agent."
    }
}

function Get-All([string]$Url) {
    $all = [System.Collections.Generic.List[object]]::new()
    $next = $Url
    while ($next) {
        $r = Invoke-RestMethod -Uri $next -Headers $headers
        Assert-Json $r $next
        foreach ($d in $r.results) { $all.Add($d) }
        $next = $r.next
    }
    return $all
}

function Get-ComponentList {
    if ($Component) {
        $c = Invoke-RestMethod -Uri "$BaseUrl/components/$Project/$Component/" -Headers $headers
        Assert-Json $c "$BaseUrl/components/$Project/$Component/"
        return @($c)
    }
    $list = Get-All "$BaseUrl/projects/$Project/components/?page_size=100"
    return @($list | Where-Object { $_.slug -ne 'glossary' })
}

function Get-Units([string]$Comp) {
    return @(Get-All "$BaseUrl/translations/$Project/$Comp/$Language/units/?page_size=100")
}

function Get-Translation([string]$Comp) {
    $t = Invoke-RestMethod -Uri "$BaseUrl/translations/$Project/$Comp/$Language/" -Headers $headers
    Assert-Json $t "$BaseUrl/translations/$Project/$Comp/$Language/"
    return $t
}

function Write-Utf8([string]$Path, [string[]]$Lines) {
    [System.IO.File]::WriteAllLines($Path, $Lines, $utf8)
}

# Remove blocos ICU e devolve os argumentos usados (nome:tipo).
function Analyze-Icu([string]$Text) {
    $clean = [System.Text.StringBuilder]::new()
    $args = [System.Collections.Generic.List[string]]::new()
    $i = 0
    while ($i -lt $Text.Length) {
        $ch = $Text[$i]
        if ($ch -ne '{') { [void]$clean.Append($ch); $i++; continue }
        $depth = 0; $j = $i; $inApostrophe = $false
        while ($j -lt $Text.Length) {
            $c = $Text[$j]
            if ($inApostrophe) { if ($c -eq "'") { $inApostrophe = $false } }
            elseif ($c -eq "'") { $inApostrophe = $true }
            elseif ($c -eq '{') { $depth++ }
            elseif ($c -eq '}') { $depth--; if ($depth -eq 0) { break } }
            $j++
        }
        if ($j -ge $Text.Length) { [void]$clean.Append($ch); $i++; continue }
        $inner = $Text.Substring($i + 1, $j - $i - 1)
        if ($inner -match '^\s*([A-Za-z_][A-Za-z0-9_.]*)\s*,\s*(plural|select|selectordinal)\s*,') {
            $args.Add("$($Matches[1]):$($Matches[2])")
            [void]$clean.Append(' ')
        } else {
            [void]$clean.Append($Text.Substring($i, $j - $i + 1))
        }
        $i = $j + 1
    }
    return @{ Clean = $clean.ToString(); Args = (($args | Sort-Object) -join ',') }
}

function Get-Tokens([string]$Text) {
    $set = [System.Collections.Generic.List[string]]::new()
    foreach ($m in [regex]::Matches($Text, '(\{\{[^{}]*\}\})')) { $set.Add($m.Value) }
    foreach ($m in [regex]::Matches($Text, '(%(?:\d+\$)?[-+0#]*[\d.]*[bcdeEfFgGosuxX@])')) { $set.Add($m.Value) }
    foreach ($m in [regex]::Matches($Text, '(</?[A-Za-z][A-Za-z0-9]*)')) { $set.Add($m.Value) }
    foreach ($m in [regex]::Matches($Text, '(?<![\w{<])\{([A-Za-z_][A-Za-z0-9_.]*(?:\[[^\]]*\])?)\}')) { $set.Add($m.Value) }
    foreach ($m in [regex]::Matches($Text, '(\$\{[^}]+\})')) { $set.Add($m.Value) }
    foreach ($m in [regex]::Matches($Text, '(@string/[A-Za-z0-9_.]+)')) { $set.Add($m.Value) }
    foreach ($m in [regex]::Matches($Text, '(?<![\w]):[A-Za-z_][A-Za-z0-9_]*')) { $set.Add($m.Value) }
    return (($set | Sort-Object -Unique) -join ' ')
}

switch ($Action) {
    'Status' {
        $components = Get-ComponentList
        $lines = [System.Collections.Generic.List[string]]::new()
        $lines.Add("componente`ttraduzidas`ttotal`tpendentes`tchecks`tultima_alteracao")
        Write-Host "Projeto $Project | idioma $Language" -ForegroundColor Cyan
        foreach ($c in $components) {
            try {
                $t = Get-Translation $c.slug
                $pending = [int]$t.total - [int]$t.translated
                $line = "{0}`t{1}`t{2}`t{3}`t{4}`t{5}" -f $c.slug, $t.translated, $t.total, $pending, $t.failing_checks, $t.last_change
                $lines.Add($line)
                Write-Host ("  {0,-30} {1,5}/{2,-5} pendentes={3,-4} checks={4}" -f $c.slug, $t.translated, $t.total, $pending, $t.failing_checks)
            } catch {
                Write-Host ("  {0,-30} ERRO: {1}" -f $c.slug, $_.Exception.Message) -ForegroundColor Yellow
            }
        }
        if ($Tsv) { Write-Utf8 $Tsv $lines; Write-Host "relatório -> $Tsv" }
    }

    'Export' {
        if (-not $Component) { throw 'Informe -Component para Export.' }
        $units = Get-Units $Component
        $selected = if ($All) { $units } else { @($units | Where-Object { -not $_.translated -or [string]::IsNullOrWhiteSpace(($_.target -join '')) }) }
        $lines = [System.Collections.Generic.List[string]]::new()
        foreach ($u in $selected) {
            $ctx = ('' + $u.context) -replace "`r?`n", ' | ' -replace "`t", ' '
            $src = (($u.source -join '') -replace "`r?`n", '\n') -replace "`t", ' '
            $dst = (($u.target -join '') -replace "`r?`n", '\n') -replace "`t", ' '
            $lines.Add("$($u.id)`t$ctx`t$src`t$dst")
        }
        if ($Tsv) { Write-Utf8 $Tsv $lines }
        Write-Host "componente $Component : $($selected.Count) unidades exportadas de $($units.Count)" -ForegroundColor Cyan
    }

    'Push' {
        if (-not $Tsv -or -not (Test-Path -LiteralPath $Tsv)) { throw 'Informe -Tsv válido para Push.' }
        $lines = [System.IO.File]::ReadAllLines($Tsv, [System.Text.Encoding]::UTF8)
        $ok = 0; $fail = 0; $errors = [System.Collections.Generic.List[string]]::new()
        foreach ($line in $lines) {
            if ([string]::IsNullOrWhiteSpace($line)) { continue }
            $parts = $line -split "`t", 2
            if ($parts.Count -lt 2) { $errors.Add("linha inválida: $line"); $fail++; continue }
            $id = [int]$parts[0]
            $text = $parts[1] -replace '\\n', "`n"
            $body = @{ target = @($text); state = 20 } | ConvertTo-Json -Compress
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($body)
            $done = $false
            for ($attempt = 1; $attempt -le 3 -and -not $done; $attempt++) {
                try {
                    Invoke-RestMethod -Uri "$BaseUrl/units/$id/" -Method Patch -Headers $headers `
                        -ContentType 'application/json; charset=utf-8' -Body $bytes | Out-Null
                    $done = $true; $ok++
                } catch {
                    $msg = $_.Exception.Message
                    $detail = '' + $_.ErrorDetails.Message
                    if ($msg -match '50[0-9]' -or $detail -match '50[0-9]') {
                        if ($attempt -eq 3) { $fail++; $errors.Add("$id => $msg $detail") }
                        else { Start-Sleep -Milliseconds 500 }
                    } else {
                        $fail++; $errors.Add("$id => $msg $detail"); break
                    }
                }
            }
            if ($DelayMs -gt 0) { Start-Sleep -Milliseconds $DelayMs }
        }
        Write-Host "OK=$ok FALHAS=$fail" -ForegroundColor $(if ($fail) { 'Yellow' } else { 'Green' })
        if ($errors.Count) { $errors | ForEach-Object { Write-Host "  $_" } }
    }

    'Check' {
        if (-not $Component) { throw 'Informe -Component para Check.' }
        $units = Get-Units $Component
        $bad = [System.Collections.Generic.List[string]]::new()
        $checked = 0
        foreach ($u in $units) {
            if (-not $u.translated) { continue }
            $src = $u.source -join ''
            $dst = $u.target -join ''
            $checked++
            $a = Analyze-Icu $src
            $b = Analyze-Icu $dst
            $problems = [System.Collections.Generic.List[string]]::new()
            if ((Get-Tokens $a.Clean) -ne (Get-Tokens $b.Clean)) { $problems.Add('placeholders') }
            if ($a.Args -ne $b.Args) { $problems.Add('icu') }
            if (([regex]::Matches($dst, '\{')).Count -ne ([regex]::Matches($dst, '\}')).Count) { $problems.Add('chaves') }
            if ($problems.Count -gt 0) {
                $s = ($src -replace "`r?`n", ' | ') -replace "`t", ' '
                $d = ($dst -replace "`r?`n", ' | ') -replace "`t", ' '
                $bad.Add("$($problems -join '+')`t$($u.id)`t$($u.context)`t$s`t$d")
            }
        }
        Write-Host "verificadas: $checked | divergências: $($bad.Count)" -ForegroundColor $(if ($bad.Count) { 'Yellow' } else { 'Green' })
        if ($Tsv) { Write-Utf8 $Tsv $bad; Write-Host "relatório -> $Tsv" }
    }

    'Backup' {
        if (-not $Component) { throw 'Informe -Component para Backup.' }
        if (-not $OutFile) { throw 'Informe -OutFile para Backup.' }
        $r = Invoke-WebRequest -Uri "$BaseUrl/translations/$Project/$Component/$Language/file/" -Headers $headers
        Assert-Json $r "$BaseUrl/translations/$Project/$Component/$Language/file/"
        [System.IO.File]::WriteAllText($OutFile, $r.Content, $utf8)
        Write-Host "backup -> $OutFile ($($r.RawContentLength) bytes)" -ForegroundColor Green
    }
}
