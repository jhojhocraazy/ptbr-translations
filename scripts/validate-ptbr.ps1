#Requires -Version 7.0
<#
.SYNOPSIS
    Validador de traduções pt-BR do hub ptbr-translations.

.DESCRIPTION
    Compara um arquivo de tradução com sua fonte original (EN) e verifica:
      - strings vazias
      - placeholders ausentes/divergentes (%1$s, {var}, {{var}}, $VAR$)
      - placeholders desconhecidos (não existem na fonte)
      - escapes obrigatórios no Android (apóstrofo e aspas) no perfil "android"
      - chaves duplicadas em XML
      - BOM / encoding

.EXAMPLE
    ./scripts/validate-ptbr.ps1 -Path BetterLyrics/better_lyrics_messages_pt_BR.json -Source BetterLyrics/better_lyrics_messages_en.json -Format chrome

.EXAMPLE
    ./scripts/validate-ptbr.ps1 -Path NuvioMobile/NuvioMobile_strings_pt_BR.xml -Source NuvioMobile/repo/app/src/main/res/values/strings.xml -Escape cmp
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)][string]$Path,
    [string]$Source,
    [ValidateSet('auto', 'chrome', 'nested', 'crowdin', 'xml')][string]$Format = 'auto',
    [ValidateSet('none', 'android', 'cmp')][string]$Escape = 'none',
    [switch]$AllowEnglish,
    [switch]$StrictEnglish
)

$ErrorActionPreference = 'Stop'
$findings = [System.Collections.Generic.List[object]]::new()

function Add-Finding([string]$key, [string]$rule, [string]$detail) {
    $findings.Add([pscustomobject]@{ Key = $key; Rule = $rule; Detail = $detail })
}

function Get-DetectedFormat([string]$file) {
    if ($file -match '\.xml$') { return 'xml' }
    $raw = Get-Content -LiteralPath $file -Raw
    if ($raw -match '"translations"\s*:\s*\{\s*"\d+"') { return 'crowdin' }
    if ($raw -match '"message"\s*:\s*"') { return 'chrome' }
    return 'nested'
}

function Get-Bundle([string]$file, [string]$fmt) {
    $map = [ordered]@{}
    switch ($fmt) {
        'chrome' {
            $obj = Get-Content -LiteralPath $file -Raw | ConvertFrom-Json
            foreach ($p in $obj.PSObject.Properties) {
                if ($p.Value -is [string]) { $map[$p.Name] = $p.Value }
                elseif ($null -ne $p.Value.message) { $map[$p.Name] = $p.Value.message }
            }
        }
        'crowdin' {
            $obj = Get-Content -LiteralPath $file -Raw | ConvertFrom-Json
            foreach ($p in $obj.translations.PSObject.Properties) {
                $map[$p.Name] = $p.Value.target
            }
        }
        'nested' {
            $obj = Get-Content -LiteralPath $file -Raw | ConvertFrom-Json
            function Walk($node, [string]$prefix, [int]$depth) {
                if ($null -eq $node -or $depth -gt 25) { return }
                if ($node -is [string]) {
                    if ($prefix) { $script:map[$prefix] = $node }
                    return
                }
                if ($node -is [System.Management.Automation.PSCustomObject]) {
                    foreach ($p in $node.PSObject.Properties) {
                        $k = if ($prefix) { "$prefix.$($p.Name)" } else { $p.Name }
                        Walk $p.Value $k ($depth + 1)
                    }
                    return
                }
                if ($node -is [System.Collections.IEnumerable]) {
                    $i = 0
                    foreach ($item in $node) { Walk $item "$prefix[$i]" ($depth + 1); $i++ }
                }
            }
            $script:map = $map
            Walk $obj '' 0
            $map = $script:map
        }
        'xml' {
            [xml]$doc = Get-Content -LiteralPath $file -Raw
            foreach ($node in $doc.DocumentElement.ChildNodes) {
                if ($node.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
                $nm = $node.GetAttribute('name')
                if ($node.LocalName -eq 'string') {
                    $map[$nm] = $node.InnerText
                }
                elseif ($node.LocalName -eq 'plurals') {
                    foreach ($item in $node.ChildNodes) {
                        if ($item.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
                        $map["$nm[$($item.GetAttribute('quantity'))]"] = $item.InnerText
                    }
                }
            }
        }
    }
    return $map
}

function Get-Placeholders([string]$text) {
    $set = [System.Collections.Generic.HashSet[string]]::new()
    if (-not $text) { return $set }
    foreach ($m in [regex]::Matches($text, '%\d+\$[a-zA-Z]')) { [void]$set.Add($m.Value) }
    foreach ($m in [regex]::Matches($text, '%[a-zA-Z]')) { [void]$set.Add($m.Value) }
    foreach ($m in [regex]::Matches($text, '\{\{[A-Za-z0-9_]+\}\}')) { [void]$set.Add($m.Value) }
    foreach ($m in [regex]::Matches($text, '\{[A-Za-z0-9_]+\}')) { [void]$set.Add($m.Value) }
    foreach ($m in [regex]::Matches($text, '\$[A-Za-z0-9_]+\$')) { [void]$set.Add($m.Value) }
    # remove over-capture: {VAR} capturado dentro de {{VAR}}
    foreach ($m in [regex]::Matches($text, '\{([A-Za-z0-9_]+)\}')) {
        if ($text.Contains("{{$($m.Groups[1].Value)}}")) { [void]$set.Remove($m.Value) }
    }
    return $set
}

# ---------- checks de arquivo ----------
$bytes = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $Path).Path)
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Add-Finding '(arquivo)' 'encoding' 'possui BOM UTF-8 (padrão do hub: sem BOM)'
}

if ($Format -eq 'auto') { $Format = Get-DetectedFormat $Path }

$target = Get-Bundle $Path $Format
$srcMap = $null
if ($Format -eq 'crowdin' -and -not $Source) {
    $obj = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
    $srcMap = [ordered]@{}
    foreach ($p in $obj.translations.PSObject.Properties) { $srcMap[$p.Name] = [string]$p.Value.source }
}
if ($Source) {
    if (-not (Test-Path -LiteralPath $Source)) { throw "Fonte não encontrada: $Source" }
    $srcFmt = Get-DetectedFormat $Source
    if ($srcFmt -eq 'crowdin') { $srcFmt = $Format }
    if ($Format -eq 'crowdin') { $srcFmt = 'crowdin' }
    $srcMap = Get-Bundle $Source $srcFmt
}
if ($target.Count -eq 0) { throw "Nenhuma string lida de $Path — formato '$Format' não corresponde ao arquivo." }

# duplicatas em XML
if ($Format -eq 'xml') {
    $names = [regex]::Matches((Get-Content -LiteralPath $Path -Raw), '<(string|plurals)\s+name="([^"]+)"') |
        ForEach-Object { $_.Groups[2].Value }
    $dups = $names | Group-Object -CaseSensitive | Where-Object Count -gt 1
    foreach ($d in $dups) { Add-Finding $d.Name 'duplicata' "$($d.Count) ocorrências no XML" }
}

# ---------- comparação ----------
foreach ($key in $target.Keys) {
    $value = [string]$target[$key]
    $srcValue = if ($srcMap -and $srcMap.Contains($key)) { [string]$srcMap[$key] } else { $null }

    if ([string]::IsNullOrWhiteSpace($value)) {
        Add-Finding $key 'vazio' 'tradução vazia'
        continue
    }

    if ($srcMap) {
        if ($null -eq $srcValue) {
            $pluralBase = $null
            if ($key -match '^(.+)\[[^\]]+\]$') { $pluralBase = $Matches[1] }
            $baseKnown = $pluralBase -and ($srcMap.Keys | Where-Object { $_.StartsWith("$pluralBase[") -or $_ -eq $pluralBase })
            if (-not $baseKnown) { Add-Finding $key 'orfao' 'chave não existe na fonte' }
            continue
        }
        $sp = Get-Placeholders $srcValue
        $tp = Get-Placeholders $value
        foreach ($p in $sp) { if (-not $tp.Contains($p)) { Add-Finding $key 'placeholder' "faltando $p" } }
        foreach ($p in $tp) { if (-not $sp.Contains($p)) { Add-Finding $key 'placeholder' "desconhecido $p" } }
        if (-not $AllowEnglish -and $value -eq $srcValue -and $srcValue -match '[a-z]{4,}') {
            Add-Finding $key 'ingles' "idêntico à fonte (nome próprio, marca ou não traduzido): $srcValue"
        }
    }

    if ($Escape -eq 'android' -and $value -match "(?<!\\)'") {
        Add-Finding $key 'escape' "apóstrofo não escapado (use \'): $value"
    }
    if ($Escape -eq 'android' -and $value -match '(?<!\\)"') {
        Add-Finding $key 'escape' ('aspas duplas não escapadas (use \"): ' + $value)
    }
}

# chaves ausentes na tradução
if ($srcMap) {
    $notTranslatable = @{}
    if ($Format -eq 'xml' -and $Source -and (Test-Path -LiteralPath $Source)) {
        foreach ($m in [regex]::Matches((Get-Content -LiteralPath $Source -Raw), '<string\s+name="([^"]+)"[^>]*translatable="false"')) {
            $notTranslatable[$m.Groups[1].Value] = $true
        }
    }
    foreach ($key in $srcMap.Keys) {
        if ($notTranslatable.ContainsKey($key)) { continue }
        if (-not $target.Contains($key)) { Add-Finding $key 'ausente' 'existe na fonte, não na tradução' }
    }
}

# ---------- relatório ----------
$label = Split-Path -Leaf $Path
$errors = @($findings | Where-Object { $_.Rule -ne 'ingles' -or $StrictEnglish })
$warnings = @($findings | Where-Object { $_.Rule -eq 'ingles' -and -not $StrictEnglish })

if ($errors.Count -eq 0) {
    Write-Host "OK   $label  ($($target.Count) strings, perfil=$Format, escape=$Escape)" -ForegroundColor Green
    if ($warnings.Count -gt 0) {
        Write-Host "     avisos: $($warnings.Count) string(s) idêntica(s) à fonte (nomes próprios/termos mantidos)" -ForegroundColor Yellow
    }
    exit 0
}

$byRule = $errors | Group-Object Rule | Sort-Object Count -Descending
Write-Host "FALHA $label  ($($target.Count) strings) — $($errors.Count) erro(s)" -ForegroundColor Red
foreach ($g in $byRule) { Write-Host ("   {0,-12} {1}" -f $g.Name, $g.Count) }
if ($warnings.Count -gt 0) { Write-Host "   (avisos 'ingles': $($warnings.Count))" -ForegroundColor Yellow }
Write-Host ''
$errors | Select-Object -First 40 | ForEach-Object {
    Write-Host ("  [{0}] {1}" -f $_.Rule, $_.Key)
    Write-Host ("        {0}" -f $_.Detail)
}
if ($errors.Count -gt 40) { Write-Host "  ... e mais $($errors.Count - 40)" }
exit 1
