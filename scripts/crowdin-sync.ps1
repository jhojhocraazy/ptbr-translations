#Requires -Version 7.0
<#
.SYNOPSIS
    Sincronização e auditoria de projetos Crowdin (API v2) do hub ptbr-translations.

.DESCRIPTION
    Ferramenta única para o ciclo de trabalho em projetos hospedados no Crowdin.
    Nada aqui publica no GitHub: a entrega de um projeto de plataforma termina
    quando o projeto está 100% traduzido no Crowdin.

    Ações:
      Status  Lista pendências por arquivo (e totais do projeto).
      Export  Exporta as strings pendentes de um arquivo para TSV (id, texto, contexto).
      Push    Envia um TSV (id<TAB>texto) para o projeto/idioma.
      Check   Audita placeholders, argumentos ICU, tags e balanceamento de chaves.
      Backup  Grava snapshot JSON (source/target) de um arquivo + metadados do projeto.

.PARAMETER Token
    Token pessoal da API do Crowdin. Padrão: variável de ambiente CROWDIN_TOKEN.
    Nunca versione o token.

.PARAMETER Action
    Status | Export | Push | Check | Backup

.PARAMETER ProjectId
    ID numérico do projeto (ex.: 31 = Crowdin, 863186 = Better Lyrics).

.PARAMETER LanguageId
    Idioma de destino (padrão: pt-BR).

.PARAMETER FileId
    ID do arquivo no Crowdin. Obrigatório em Export, Check (opcional) e Backup.

.PARAMETER Tsv
    Caminho do TSV de entrada (Push) ou de saída (Status/Export/Check).

.PARAMETER OutFile
    Caminho do JSON de saída (Backup).

.EXAMPLE
    $env:CROWDIN_TOKEN = 'seu-token'
    ./scripts/crowdin-sync.ps1 -Action Status -ProjectId 31

.EXAMPLE
    ./scripts/crowdin-sync.ps1 -Action Export -ProjectId 31 -FileId 31090 -Tsv backend.tsv

.EXAMPLE
    ./scripts/crowdin-sync.ps1 -Action Push -ProjectId 31 -Tsv lote.tsv
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][ValidateSet('Status', 'Export', 'Push', 'Check', 'Backup')][string]$Action,
    [Parameter(Mandatory = $true)][int]$ProjectId,
    [string]$LanguageId = 'pt-BR',
    [int]$FileId = 0,
    [string]$Tsv,
    [string]$OutFile,
    [string]$Token = $env:CROWDIN_TOKEN,
    [int]$DelayMs = 120
)

$ErrorActionPreference = 'Stop'
$API = 'https://api.crowdin.com/api/v2'
$utf8 = [System.Text.UTF8Encoding]::new($false)

if ([string]::IsNullOrWhiteSpace($Token)) {
    throw 'Token ausente. Defina $env:CROWDIN_TOKEN ou use -Token.'
}
$headers = @{ Authorization = "Bearer $Token"; Accept = 'application/json' }

function Get-All([string]$Url) {
    $all = [System.Collections.Generic.List[object]]::new()
    $offset = 0
    while ($true) {
        $sep = if ($Url.Contains('?')) { '&' } else { '?' }
        $r = Invoke-RestMethod -Uri ($Url + $sep + "limit=500&offset=$offset") -Headers $headers
        foreach ($d in $r.data) { $all.Add($d.data) }
        if ($r.data.Count -lt 500) { break }
        $offset += 500
    }
    return $all
}

function Get-Latest([object[]]$Translations) {
    $latest = @{}
    foreach ($t in $Translations) {
        $cur = $latest[$t.stringId]
        if (-not $cur -or $t.translationId -gt $cur.id) {
            $latest[$t.stringId] = @{ id = $t.translationId; text = ('' + $t.text) }
        }
    }
    return $latest
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
        $files = Get-All "$API/projects/$ProjectId/files"
        $names = @{}
        foreach ($f in $files) { $names["$($f.id)"] = $f.name }

        $strings = Get-All "$API/projects/$ProjectId/strings"
        $translations = Get-All "$API/projects/$ProjectId/languages/$LanguageId/translations"
        $latest = Get-Latest $translations

        $pending = @($strings | Where-Object {
                -not $_.isHidden -and
                (-not $latest[$_.id] -or [string]::IsNullOrWhiteSpace($latest[$_.id].text))
            })

        Write-Host "Projeto $ProjectId | $($strings.Count) strings | $($pending.Count) pendentes" -ForegroundColor Cyan
        $lines = [System.Collections.Generic.List[string]]::new()
        $lines.Add("fileId`tarquivo`tpendentes`ttotal")
        foreach ($g in ($pending | Group-Object fileId | Sort-Object Count -Descending)) {
            $fid = "$($g.Name)"
            $total = @($strings | Where-Object { "$($_.fileId)" -eq $fid }).Count
            $name = if ($names.ContainsKey($fid)) { $names[$fid] } else { '?' }
            $lines.Add("$fid`t$name`t$($g.Count)`t$total")
            Write-Host ("  {0,-8} {1,-45} {2,5}/{3}" -f $fid, $name, $g.Count, $total)
        }
        if ($Tsv) { Write-Utf8 $Tsv $lines; Write-Host "relatório -> $Tsv" }
    }

    'Export' {
        if ($FileId -le 0) { throw 'Informe -FileId para Export.' }
        $strings = Get-All "$API/projects/$ProjectId/strings?fileId=$FileId"
        $translations = Get-All "$API/projects/$ProjectId/languages/$LanguageId/translations?fileId=$FileId"
        $latest = Get-Latest $translations
        $pending = @($strings | Where-Object {
                -not $_.isHidden -and
                (-not $latest[$_.id] -or [string]::IsNullOrWhiteSpace($latest[$_.id].text))
            })
        $lines = [System.Collections.Generic.List[string]]::new()
        foreach ($s in $pending) {
            $text = ('' + $s.text) -replace "`r?`n", '\n' -replace "`t", ' '
            $ctx = ('' + $s.context) -replace "`r?`n", ' | ' -replace "`t", ' '
            if ($ctx.Length -gt 300) { $ctx = $ctx.Substring(0, 300) }
            $lines.Add("$($s.id)`t$text`t$ctx")
        }
        if ($Tsv) { Write-Utf8 $Tsv $lines }
        Write-Host "arquivo $FileId : $($pending.Count) pendentes de $($strings.Count) strings" -ForegroundColor Cyan
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
            $body = @{ stringId = $id; languageId = $LanguageId; text = $text } | ConvertTo-Json -Compress
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($body)
            $done = $false
            for ($attempt = 1; $attempt -le 3 -and -not $done; $attempt++) {
                try {
                    Invoke-RestMethod -Uri "$API/projects/$ProjectId/translations" -Method Post `
                        -Headers $headers -ContentType 'application/json; charset=utf-8' -Body $bytes | Out-Null
                    $done = $true; $ok++
                } catch {
                    $msg = $_.Exception.Message
                    $detail = '' + $_.ErrorDetails.Message
                    if ($msg -match 'Duplicate' -or $detail -match 'Duplicate') { $done = $true; $ok++; break }
                    if ($attempt -eq 3) { $fail++; $errors.Add("$id => $msg") }
                    else { Start-Sleep -Milliseconds 400 }
                }
            }
            if ($DelayMs -gt 0) { Start-Sleep -Milliseconds $DelayMs }
        }
        Write-Host "OK=$ok FALHAS=$fail" -ForegroundColor $(if ($fail) { 'Yellow' } else { 'Green' })
        if ($errors.Count) { $errors | ForEach-Object { Write-Host "  $_" } }
    }

    'Check' {
        $query = if ($FileId -gt 0) { "?fileId=$FileId" } else { '' }
        $files = Get-All "$API/projects/$ProjectId/files"
        $names = @{}
        foreach ($f in $files) { $names["$($f.id)"] = $f.name }
        $strings = Get-All "$API/projects/$ProjectId/strings$query"
        $translations = Get-All "$API/projects/$ProjectId/languages/$LanguageId/translations$query"
        $latest = Get-Latest $translations

        $bad = [System.Collections.Generic.List[string]]::new()
        $checked = 0
        foreach ($s in $strings) {
            if ($s.isHidden) { continue }
            $tr = $latest[$s.id]
            if (-not $tr) { continue }
            $checked++
            $a = Analyze-Icu ([string]$s.text)
            $b = Analyze-Icu ([string]$tr.text)
            $problems = [System.Collections.Generic.List[string]]::new()
            if ((Get-Tokens $a.Clean) -ne (Get-Tokens $b.Clean)) { $problems.Add('placeholders') }
            if ($a.Args -ne $b.Args) { $problems.Add('icu') }
            $open = ([regex]::Matches($tr.text, '\{')).Count
            $close = ([regex]::Matches($tr.text, '\}')).Count
            if ($open -ne $close) { $problems.Add('chaves') }
            if ($problems.Count -gt 0) {
                $src = (([string]$s.text) -replace "`r?`n", ' | ') -replace "`t", ' '
                $dst = (([string]$tr.text) -replace "`r?`n", ' | ') -replace "`t", ' '
                $name = if ($names.ContainsKey("$($s.fileId)")) { $names["$($s.fileId)"] } else { "$($s.fileId)" }
                $bad.Add("$($problems -join '+')`t$($s.id)`t$name`t$src`t$dst")
            }
        }
        Write-Host "verificadas: $checked | divergências: $($bad.Count)" -ForegroundColor $(if ($bad.Count) { 'Yellow' } else { 'Green' })
        if ($Tsv) { Write-Utf8 $Tsv $bad; Write-Host "relatório -> $Tsv" }
    }

    'Backup' {
        if ($FileId -le 0) { throw 'Informe -FileId para Backup.' }
        if (-not $OutFile) { throw 'Informe -OutFile para Backup.' }
        $project = (Invoke-RestMethod -Uri "$API/projects/$ProjectId" -Headers $headers).data
        $file = (Invoke-RestMethod -Uri "$API/projects/$ProjectId/files/$FileId" -Headers $headers).data
        $strings = Get-All "$API/projects/$ProjectId/strings?fileId=$FileId"
        $translations = Get-All "$API/projects/$ProjectId/languages/$LanguageId/translations?fileId=$FileId"
        $latest = Get-Latest $translations

        $entry = [ordered]@{}
        foreach ($s in $strings) {
            if ($s.isHidden) { continue }
            $tr = $latest[$s.id]
            $entry["$($s.id)"] = [ordered]@{
                source = [string]$s.text
                target = if ($tr) { [string]$tr.text } else { '' }
            }
        }
        $doc = [ordered]@{
            project_id        = $ProjectId
            project_name      = $project.name
            target_language   = $LanguageId
            file_id           = $FileId
            file_name         = $file.name
            total_submitted   = $entry.Count
            generated_at      = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
            translations      = $entry
        }
        [System.IO.File]::WriteAllText($OutFile, ($doc | ConvertTo-Json -Depth 8) + "`n", $utf8)
        Write-Host "backup -> $OutFile ($($entry.Count) strings)" -ForegroundColor Green
    }
}
