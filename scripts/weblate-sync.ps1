<#
.SYNOPSIS
    Sincronização e auditoria de projetos Weblate (API v1) do hub ptbr-translations.

.DESCRIPTION
    Ferramenta única para o ciclo de trabalho em projetos hospedados no Weblate.
    A entrega de um projeto de plataforma termina quando o componente está 100%
    traduzido no Weblate; nada aqui publica no GitHub.

    Ações:
      Status    Estatísticas de tradução por componente (e checagens falhando).
      Export    Exporta unidades (pendentes ou todas) para TSV (id, contexto, fonte,
                destino) ou JSON preservando source/target como arrays (plurais).
      Push      Envia um TSV (id<TAB>texto) via PATCH /units/{id}/. Recusa plurais.
      PushJson  Envia um lote JSON, com target string ou array de formas (plurais).
      Check     Audita placeholders, ICU e balanceamento de chaves.
      Checks    Lista as unidades com checagem nativa falhando (has:failing_check).
      Backup    Baixa o arquivo traduzido do componente.

.PARAMETER Token
    Token pessoal da API do Weblate. Padrão: variável de ambiente WEBLATE_TOKEN.
    Nunca versione o token.

.PARAMETER Project
    Slug do projeto no Weblate (ex.: elowry).

.PARAMETER Component
    Slug do componente (ex.: dnstoggle-strings). Obrigatório em Export, Push,
    PushJson, Check, Checks e Backup.
    Em Status, se omitido, lista todos os componentes do projeto.

.PARAMETER Language
    Código do idioma no Weblate (padrão: pt_BR).

.PARAMETER Tsv
    Caminho do TSV de entrada (Push) ou de saída (Status/Export/Check/Checks).

.PARAMETER OutFile
    Caminho do arquivo de saída (Backup e Export -Format json).

.PARAMETER Format
    Formato do Export: tsv (padrão) ou json. Em json, -OutFile é obrigatório e
    cada forma plural vira um item do array target, sem concatenação.

.PARAMETER Json
    Caminho do arquivo JSON do PushJson: array de unidades ou objeto com a
    propriedade "units". Cada item tem id (inteiro), context (opcional) e target
    (string ou array). JSON inline também é aceito, mas o arquivo é o formato
    recomendado para lotes grandes.

.PARAMETER All
    Em Export, inclui também as unidades já traduzidas.

.PARAMETER Force
    Em PushJson, aceita divergência entre a quantidade de formas do lote e a do
    target atual da unidade plural. Sem ele, as contagens devem coincidir.

.EXAMPLE
    $env:WEBLATE_TOKEN = 'seu-token'
    ./scripts/weblate-sync.ps1 -Action Status -Project elowry

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Export -Project elowry -Component dnstoggle-strings -Tsv strings.tsv

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Export -Project elowry -Component dnstoggle-strings -Format json -OutFile lote.json -All

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Push -Project elowry -Component dnstoggle-strings -Tsv lote.tsv

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action PushJson -Project elowry -Component dnstoggle-strings -Json lote.json

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Checks -Project elowry -Component dnstoggle-strings -Tsv checks.tsv

.EXAMPLE
    ./scripts/weblate-sync.ps1 -Action Backup -Project elowry -Component dnstoggle-strings -OutFile DNSToggle/dnstoggle_strings_pt_BR.xml
#>
#Requires -Version 7.0
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][ValidateSet('Status', 'Export', 'Push', 'PushJson', 'Check', 'Checks', 'Backup')][string]$Action,
    [Parameter(Mandatory = $true)][string]$Project,
    [string]$Component,
    [string]$Language = 'pt_BR',
    [string]$Token = $env:WEBLATE_TOKEN,
    [string]$Tsv,
    [string]$OutFile,
    [ValidateSet('tsv', 'json')][string]$Format = 'tsv',
    [string]$Json,
    [switch]$All,
    [switch]$Force,
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

function Get-UnitMap([string]$Comp) {
    $map = @{}
    foreach ($u in (Get-Units $Comp)) { $map[[string]$u.id] = $u }
    return $map
}

function Get-Unit([int]$Id) {
    $u = Invoke-RestMethod -Uri "$BaseUrl/units/$Id/" -Headers $headers
    Assert-Json $u "$BaseUrl/units/$Id/"
    return $u
}

function Get-FormCount($Unit) {
    return @($Unit.source).Count
}

# Normaliza o target de um item JSON para string[], recusando vazio e tipos inválidos.
function ConvertTo-Forms($Value) {
    if ($null -eq $Value) { throw 'target ausente' }
    if ($Value -is [string]) {
        $forms = @($Value)
    } elseif ($Value -is [System.Collections.IList]) {
        $forms = @()
        foreach ($v in $Value) {
            if ($v -isnot [string]) {
                $kind = if ($null -eq $v) { 'null' } else { $v.GetType().Name }
                throw "target contém forma de tipo inválido ($kind)"
            }
            $forms += $v
        }
    } else {
        throw "target deve ser string ou array de strings (recebido: $($Value.GetType().Name))"
    }
    if ($forms.Count -eq 0) { throw 'target vazio' }
    foreach ($f in $forms) {
        if ([string]::IsNullOrWhiteSpace($f)) { throw 'target contém forma vazia ou só espaços' }
    }
    return , $forms
}

function ConvertTo-UnitId($Value) {
    if ($null -eq $Value) { throw 'id ausente' }
    if ($Value -is [int] -or $Value -is [long]) { return [int]$Value }
    throw "id deve ser inteiro (recebido: $($Value.GetType().Name))"
}

function Get-UnitLabel([int]$Id, [string]$Context) {
    if ([string]::IsNullOrWhiteSpace($Context)) { return "$Id" }
    $c = (('' + $Context) -replace "`r?`n", ' ') -replace "`t", ' '
    return "$Id [$c]"
}

# Célula de relatório: preserva o texto, mas elimina quebras de linha e tabulações.
function ConvertTo-Cell([string]$Text) {
    return (('' + $Text) -replace "[\r\n\t]+", ' ')
}

# PATCH das formas com retry 3x apenas para 5xx; lança erro nos demais casos.
function Set-UnitForms([int]$Id, [string[]]$Forms) {
    $body = @{ target = @($Forms); state = 20 } | ConvertTo-Json -Compress
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($body)
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            Invoke-RestMethod -Uri "$BaseUrl/units/$Id/" -Method Patch -Headers $headers `
                -ContentType 'application/json; charset=utf-8' -Body $bytes | Out-Null
            return
        } catch {
            $msg = $_.Exception.Message
            $detail = '' + $_.ErrorDetails.Message
            if (($msg -match '50[0-9]' -or $detail -match '50[0-9]') -and $attempt -lt 3) {
                Start-Sleep -Milliseconds 500
                continue
            }
            throw "$msg $detail".Trim()
        }
    }
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
        if ($Format -eq 'json' -and -not $OutFile) { throw 'Informe -OutFile para Export -Format json.' }
        $units = Get-Units $Component
        $selected = if ($All) { $units } else { @($units | Where-Object { -not $_.translated -or [string]::IsNullOrWhiteSpace(($_.target -join '')) }) }
        $plural = @($selected | Where-Object { (Get-FormCount $_) -gt 1 })

        if ($Format -eq 'json') {
            $payload = [System.Collections.Generic.List[object]]::new()
            foreach ($u in $selected) {
                $payload.Add([ordered]@{
                        id                = [int]$u.id
                        context           = '' + $u.context
                        source            = @($u.source)
                        target            = @($u.target)
                        translated        = [bool]$u.translated
                        state             = [int]$u.state
                        has_failing_check = [bool]$u.has_failing_check
                        plural            = ((Get-FormCount $u) -gt 1)
                    })
            }
            $jsonText = ConvertTo-Json -InputObject $payload.ToArray() -Depth 10
            [System.IO.File]::WriteAllText($OutFile, $jsonText, $utf8)
            Write-Host "componente $Component : $($selected.Count) unidades exportadas de $($units.Count) (json) -> $OutFile" -ForegroundColor Cyan
            return
        }

        if ($plural.Count -gt 0) {
            Write-Host "aviso: $($plural.Count) unidade(s) plural(is) selecionada(s); o TSV junta as formas. Use -Format json para plurais." -ForegroundColor Yellow
        }
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
        if (-not $Component) { throw 'Informe -Component para Push.' }
        if (-not $Tsv -or -not (Test-Path -LiteralPath $Tsv)) { throw 'Informe -Tsv válido para Push.' }
        $unitMap = Get-UnitMap $Component
        $lines = [System.IO.File]::ReadAllLines($Tsv, [System.Text.Encoding]::UTF8)
        $ok = 0; $fail = 0; $errors = [System.Collections.Generic.List[string]]::new()
        foreach ($line in $lines) {
            if ([string]::IsNullOrWhiteSpace($line)) { continue }
            $parts = $line -split "`t", 2
            if ($parts.Count -lt 2) { $errors.Add("linha inválida: $line"); $fail++; continue }
            $id = [int]$parts[0]
            $unit = $unitMap[[string]$id]
            if (-not $unit) {
                $fail++
                $errors.Add("$id => unidade não encontrada em $Component")
            } elseif ((Get-FormCount $unit) -gt 1) {
                $fail++
                $errors.Add("$(Get-UnitLabel $id $unit.context) => unidade plural; use PushJson")
            } else {
                $text = $parts[1] -replace '\\n', "`n"
                try {
                    Set-UnitForms $id @($text)
                    $ok++
                } catch {
                    $fail++
                    $errors.Add("$id => $($_.Exception.Message)")
                }
            }
            if ($DelayMs -gt 0) { Start-Sleep -Milliseconds $DelayMs }
        }
        Write-Host "OK=$ok FALHAS=$fail" -ForegroundColor $(if ($fail) { 'Yellow' } else { 'Green' })
        if ($errors.Count) { $errors | ForEach-Object { Write-Host "  $_" } }
    }

    'PushJson' {
        if (-not $Component) { throw 'Informe -Component para PushJson.' }
        if ([string]::IsNullOrWhiteSpace($Json)) { throw 'Informe -Json com o caminho do lote (array JSON ou objeto com "units").' }
        $jsonText = $Json
        if (Test-Path -LiteralPath $Json -PathType Leaf) {
            $jsonText = Get-Content -LiteralPath $Json -Raw -Encoding UTF8
        } elseif ($Json.TrimStart() -notmatch '^[\[{]') {
            throw "Arquivo JSON não encontrado: $Json"
        }
        try {
            # ConvertFrom-Json do PowerShell é tolerante a alguns truncamentos;
            # JsonDocument faz a validação sintática estrita antes do parse.
            $doc = [System.Text.Json.JsonDocument]::Parse($jsonText)
            $doc.Dispose()
            $data = $jsonText | ConvertFrom-Json -NoEnumerate
        } catch {
            throw "JSON inválido: $($_.Exception.Message)"
        }
        $items = if ($null -eq $data) { @() }
        elseif ($data -is [array]) { @($data) }
        elseif ($data.PSObject.Properties.Name -contains 'units') { @($data.units) }
        else { throw 'JSON deve ser um array de unidades ou um objeto com a propriedade "units".' }
        if ($items.Count -eq 0) { throw 'JSON sem unidades.' }

        # Valida o lote inteiro antes de qualquer PATCH.
        $batch = [System.Collections.Generic.List[object]]::new()
        $invalid = [System.Collections.Generic.List[string]]::new()
        $index = 0
        foreach ($item in $items) {
            $index++
            try {
                $itemId = ConvertTo-UnitId $item.id
                $itemForms = ConvertTo-Forms $item.target
                $itemContext = if ($item.PSObject.Properties.Name -contains 'context') { '' + $item.context } else { '' }
                $batch.Add([pscustomobject]@{ Id = $itemId; Forms = $itemForms; Context = $itemContext })
            } catch {
                $invalid.Add("item $index => $($_.Exception.Message)")
            }
        }
        if ($invalid.Count -gt 0) {
            $invalid | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
            throw "JSON inválido: $($invalid.Count) item(ns) rejeitado(s)."
        }

        $unitMap = Get-UnitMap $Component
        $ok = 0; $fail = 0; $diverged = 0
        $errors = [System.Collections.Generic.List[string]]::new()
        $sep = [char]0x241E
        foreach ($b in $batch) {
            $unit = $unitMap[[string]$b.Id]
            if (-not $unit) {
                $fail++
                $errors.Add("$(Get-UnitLabel $b.Id $b.Context) => unidade não encontrada em $Component")
                continue
            }
            $label = Get-UnitLabel $b.Id $unit.context
            $srcCount = Get-FormCount $unit
            $curCount = @($unit.target).Count
            if ($srcCount -gt 1) {
                if ($b.Forms.Count -lt 2) {
                    $fail++
                    $errors.Add("$label => fonte plural ($srcCount formas); recebeu $($b.Forms.Count) forma(s)")
                    continue
                }
                if ($curCount -gt 0 -and $curCount -ne $b.Forms.Count -and -not $Force) {
                    $fail++
                    $errors.Add("$label => divergência de formas: unidade tem $curCount, lote tem $($b.Forms.Count) (use -Force)")
                    continue
                }
            } elseif ($b.Forms.Count -ne 1) {
                $fail++
                $errors.Add("$label => fonte simples; esperado exatamente 1 forma, recebido $($b.Forms.Count)")
                continue
            }

            try {
                Set-UnitForms $b.Id $b.Forms
                $ok++
            } catch {
                $fail++
                $errors.Add("$label => $($_.Exception.Message)")
                if ($DelayMs -gt 0) { Start-Sleep -Milliseconds $DelayMs }
                continue
            }

            try {
                $after = Get-Unit $b.Id
                $actual = @($after.target)
                if (($actual -join $sep) -cne ($b.Forms -join $sep)) {
                    $diverged++
                    $errors.Add("$label => divergência após PATCH: esperado '$($b.Forms -join $sep)', retornado '$($actual -join $sep)'")
                }
            } catch {
                $diverged++
                $errors.Add("$label => falha ao conferir target: $($_.Exception.Message)")
            }
            if ($DelayMs -gt 0) { Start-Sleep -Milliseconds $DelayMs }
        }
        Write-Host "OK=$ok FALHAS=$fail DIVERGÊNCIAS=$diverged" -ForegroundColor $(if ($fail -or $diverged) { 'Yellow' } else { 'Green' })
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

    'Checks' {
        if (-not $Component) { throw 'Informe -Component para Checks.' }
        $url = "$BaseUrl/translations/$Project/$Component/$Language/units/?q=has:failing_check&page_size=100"
        $units = @(Get-All $url)
        $lines = [System.Collections.Generic.List[string]]::new()
        $lines.Add("id`tcontext`tsource`ttarget`tstate`thas_failing_check")
        Write-Host "componente $Component | checks falhando: $($units.Count)" -ForegroundColor Cyan
        foreach ($u in $units) {
            $ctx = ConvertTo-Cell ('' + $u.context)
            $src = ConvertTo-Cell ((@($u.source) -join ' || '))
            $dst = ConvertTo-Cell ((@($u.target) -join ' || '))
            $lines.Add("$($u.id)`t$ctx`t$src`t$dst`t$($u.state)`t$($u.has_failing_check)")
            $shown = if ($ctx) { $ctx } else { $src }
            Write-Host ("  {0,-8} state={1,-4} {2}" -f $u.id, $u.state, $shown)
        }
        Write-Host "unidades com checks falhando: $($units.Count)" -ForegroundColor $(if ($units.Count) { 'Yellow' } else { 'Green' })
        if ($Tsv) { Write-Utf8 $Tsv $lines; Write-Host "relatório -> $Tsv" }
    }

    'Backup' {
        if (-not $Component) { throw 'Informe -Component para Backup.' }
        if (-not $OutFile) { throw 'Informe -OutFile para Backup.' }
        $r = Invoke-WebRequest -Uri "$BaseUrl/translations/$Project/$Component/$Language/file/" -Headers $headers
        Assert-Json $r "$BaseUrl/translations/$Project/$Component/$Language/file/"
        [System.IO.File]::WriteAllText($OutFile, $r.Content, $utf8)
        Write-Host "backup -> $OutFile ($($r.RawContentLength) bytes)" -ForegroundColor Green
        Write-Host 'aviso: unidades read-only (state=100) podem ser omitidas do export; confira a contagem de contextos contra o Status e escaneie o arquivo para escapes duplicados (\\'' e \\").' -ForegroundColor Yellow
    }
}
