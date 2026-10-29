#Requires -Version 7.0
<#
.SYNOPSIS
    Consulta atualizações de strings nos projetos do hub e mostra um changelog no console.

.DESCRIPTION
    Rotina somente leitura. Consulta Crowdin, Weblate e projetos mantidos apenas no GitHub,
    compara com a execução anterior e mostra o texto das strings novas, removidas, alteradas,
    ainda sem tradução e órfãs. Nenhuma chave, contexto ou ID é impresso no console.

    O estado local fica em scripts/.state/check-updates.json (ignorado pelo Git).
    A primeira execução cria a linha de base; as seguintes mostram apenas as diferenças.

.PARAMETER StateFile
    Caminho alternativo para o arquivo de estado local.

.PARAMETER Project
    Filtra por parte do nome ou da chave interna do projeto (ex.: Nuvio, YTDLnis, Crowdin).

.PARAMETER NoFetch
    Não executa git fetch nos clones locais; usa a última referência upstream disponível.

.PARAMETER ResetState
    Apaga o estado antes da consulta e cria uma nova linha de base.

.PARAMETER NoSave
    Não grava o estado ao final (útil para testes).

.PARAMETER Quiet
    Mostra apenas projetos com novidades ou erros.

.PARAMETER AllDetails
    Mostra todas as strings de cada lista, sem limitar a MaxItems.

.PARAMETER MaxItems
    Limite de strings por lista quando AllDetails não é usado. Padrão: 20.

.NOTES
    Autor: Joseph Alves <jhojhocraazy@gmail.com>
    Códigos de saída: 0 = sem novidades; 2 = novidades encontradas; 1 = erro.
#>
[CmdletBinding()]
param(
    [string]$StateFile = '',
    [string]$Project = '',
    [switch]$NoFetch,
    [switch]$ResetState,
    [switch]$NoSave,
    [switch]$Quiet,
    [switch]$AllDetails,
    [int]$MaxItems = 20
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding = $Utf8NoBom
$OutputEncoding = $Utf8NoBom

# Carrega os tokens locais sem imprimir nada. O arquivo é ignorado pelo Git.
$TokenFile = Join-Path $PSScriptRoot 'tokens.ps1'
if (Test-Path -LiteralPath $TokenFile) {
    try {
        . $TokenFile
    }
    catch {
        Write-Host "Aviso: não foi possível carregar scripts/tokens.ps1: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

$CrowdinToken = [string]$env:CROWDIN_TOKEN
$WeblateToken = [string]$env:WEBLATE_TOKEN
$CrowdinHeaders = @{
    Authorization = "Bearer $CrowdinToken"
    Accept        = 'application/json'
    'User-Agent'  = 'ptbr-translations-check-updates/1.0'
}
$WeblateHeaders = @{
    Authorization = "Token $WeblateToken"
    Accept        = 'application/json'
    'User-Agent'  = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
}

$GitHubProjects = @(
    @{
        Key    = 'github:nuvio'
        Label  = 'Nuvio Mobile'
        Repo   = 'NuvioMobile\repo'
        Branch = 'cmp-rewrite'
        Files  = @(
            @{ Module = 'principal'; Source = 'composeApp/src/commonMain/composeResources/values/strings.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/strings.xml' }
            @{ Module = 'pip'; Source = 'composeApp/src/commonMain/composeResources/values/strings_pip.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/strings_pip.xml' }
            @{ Module = 'party'; Source = 'composeApp/src/commonMain/composeResources/values/strings_party.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/strings_party.xml' }
            @{ Module = 'servers'; Source = 'composeApp/src/commonMain/composeResources/values/strings_servers.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/strings_servers.xml' }
            @{ Module = 'mdblist'; Source = 'composeApp/src/commonMain/composeResources/values/strings_mdblist.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/strings_mdblist.xml' }
            @{ Module = 'autosync'; Source = 'composeApp/src/commonMain/composeResources/values/autosync_strings.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/autosync_strings.xml' }
            @{ Module = 'autosync_toast'; Source = 'composeApp/src/commonMain/composeResources/values/autosync_toast_strings.xml'; Target = 'composeApp/src/commonMain/composeResources/values-pt-rBR/autosync_toast_strings.xml' }
        )
    }
    @{
        Key    = 'github:bitchord'
        Label  = 'BitChord'
        Repo   = 'BitChord\repo'
        Branch = 'v1.8.2'
        Files  = @(
            @{ Module = 'android'; Source = 'app/src/main/res/values/strings.xml'; Target = 'app/src/main/res/values-pt/strings.xml' }
            @{ Module = 'shared_ui'; Source = 'sharedUi/src/commonMain/composeResources/values/strings.xml'; Target = 'sharedUi/src/commonMain/composeResources/values-pt/strings.xml' }
            @{ Module = 'wearos'; Source = 'wearos/src/main/res/values/strings.xml'; Target = 'wearos/src/main/res/values-pt/strings.xml' }
        )
    }
    @{
        Key    = 'github:tizentube'
        Label  = 'TizenTube & Cobalt'
        Repo   = 'TizenTube\repo'
        Branch = 'main'
        Files  = @(
            @{ Module = 'tizentube'; Type = 'json'; Source = 'mods/translations/resources/en.json'; Target = 'mods/translations/resources/pt-BR.json' }
        )
    }
)

$PlatformProjects = @(
    @{ Key = 'crowdin:31'; Label = 'Crowdin Platform'; Platform = 'crowdin'; ProjectId = 31 }
    @{ Key = 'crowdin:863186'; Label = 'Better Lyrics'; Platform = 'crowdin'; ProjectId = 863186 }
    @{ Key = 'weblate:ytdlnis/strings'; Label = 'YTDLnis'; Platform = 'weblate'; Project = 'ytdlnis'; Component = 'strings' }
    @{ Key = 'weblate:elowry/dnstoggle-strings'; Label = 'DNSToggle — textos'; Platform = 'weblate'; Project = 'elowry'; Component = 'dnstoggle-strings' }
    @{ Key = 'weblate:elowry/dnstoggle-metadata'; Label = 'DNSToggle — metadados'; Platform = 'weblate'; Project = 'elowry'; Component = 'dnstoggle-metadata' }
)

function Get-NormalizedText {
    param([string]$Text)
    if ($null -eq $Text) { return '' }
    return (($Text -replace "`r`n", "`n") -replace "`r", "`n").Trim()
}

function Get-StateText {
    param([string]$Text)
    $normalized = Get-NormalizedText $Text
    if ($normalized.Length -gt 500) {
        return $normalized.Substring(0, 500)
    }
    return $normalized
}

function Format-Text {
    param([string]$Text)
    $normalized = Get-NormalizedText $Text
    if (-not $normalized) { return '(texto vazio)' }
    $normalized = $normalized -replace '\s+', ' '
    if ($normalized.Length -gt 180) {
        return $normalized.Substring(0, 177) + '...'
    }
    return $normalized
}

function Get-TextHash {
    param([string]$Text)
    $sha1 = [System.Security.Cryptography.SHA1]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes((Get-NormalizedText $Text))
        return [System.Convert]::ToHexString($sha1.ComputeHash($bytes))
    }
    finally {
        $sha1.Dispose()
    }
}

function Format-Gmt3 {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) { return '' }
    try {
        $date = [DateTimeOffset]::Parse($Value, [System.Globalization.CultureInfo]::InvariantCulture)
        return $date.ToOffset([TimeSpan]::FromHours(-3)).ToString('dd/MM/yyyy HH:mm')
    }
    catch {
        return $Value
    }
}

function Get-NowGmt3 {
    return [DateTimeOffset]::UtcNow.ToOffset([TimeSpan]::FromHours(-3)).ToString('dd/MM/yyyy HH:mm')
}

function Assert-JsonResponse {
    param($Response, [string]$Url)
    if ($Response -is [string] -and $Response.TrimStart().StartsWith('<')) {
        throw "A API retornou HTML em vez de JSON. Verifique o token e tente novamente."
    }
}

function Invoke-Api {
    param([string]$Url, [hashtable]$Headers)
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            $response = Invoke-RestMethod -Uri $Url -Headers $Headers
            Assert-JsonResponse $response $Url
            return $response
        }
        catch {
            if ($attempt -eq 3) { throw }
            Start-Sleep -Milliseconds 700
        }
    }
}

function Get-AllCrowdin {
    param([string]$Url)
    $all = [System.Collections.Generic.List[object]]::new()
    $offset = 0
    while ($true) {
        $separator = if ($Url.Contains('?')) { '&' } else { '?' }
        $response = Invoke-Api "$Url$separator`limit=500&offset=$offset" $CrowdinHeaders
        if ($null -eq $response.data) { break }
        $page = @($response.data)
        foreach ($wrapper in $page) {
            $all.Add($wrapper.data)
        }
        if ($page.Count -lt 500) { break }
        $offset += 500
    }
    return $all
}

function Get-AllWeblate {
    param([string]$Url)
    $all = [System.Collections.Generic.List[object]]::new()
    $next = $Url
    while ($next) {
        $response = Invoke-Api $next $WeblateHeaders
        foreach ($item in @($response.results)) {
            if ($null -ne $item) { $all.Add($item) }
        }
        $next = $response.next
    }
    return $all
}

function Get-GitFile {
    param([string]$RepoPath, [string]$Ref, [string]$Path)
    $text = git -C $RepoPath show "${Ref}:$Path" 2>$null | Out-String
    if ($LASTEXITCODE -ne 0) {
        throw "Arquivo não encontrado no upstream: $Path"
    }
    return $text
}

function Get-XmlUnits {
    param([string]$Text)
    [xml]$document = $Text
    $map = @{}
    if ($null -eq $document.DocumentElement) { return $map }

    foreach ($node in $document.DocumentElement.ChildNodes) {
        if ($node.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
        if ($node.GetAttribute('translatable') -eq 'false') { continue }
        $name = $node.GetAttribute('name')
        if ([string]::IsNullOrWhiteSpace($name)) { continue }

        switch ($node.LocalName) {
            'string' {
                $map["string|$name"] = $node.InnerText
            }
            'plurals' {
                foreach ($item in $node.ChildNodes) {
                    if ($item.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
                    $quantity = $item.GetAttribute('quantity')
                    if ($quantity) {
                        $map["plural|$name|$quantity"] = $item.InnerText
                    }
                }
            }
            'string-array' {
                $index = 0
                foreach ($item in $node.ChildNodes) {
                    if ($item.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
                    $map["array|$name|$index"] = $item.InnerText
                    $index++
                }
            }
        }
    }
    return $map
}

function Get-JsonUnits {
    param([string]$Text)
    $object = $Text | ConvertFrom-Json -AsHashtable
    $map = @{}

    function WalkJson {
        param($Node, [string]$Prefix)
        if ($null -eq $Node) { return }

        if ($Node -is [string]) {
            if ($Prefix) { $map[$Prefix] = $Node }
            return
        }
        if ($Node -is [System.ValueType]) {
            if ($Prefix) { $map[$Prefix] = [string]$Node }
            return
        }
        if ($Node -is [System.Collections.IDictionary]) {
            foreach ($key in $Node.Keys) {
                $keyText = [string]$key
                if ($keyText.StartsWith('__')) { continue }
                $path = if ($Prefix) { "$Prefix.$keyText" } else { $keyText }
                WalkJson $Node[$key] $path
            }
            return
        }
        if ($Node -is [System.Collections.IEnumerable]) {
            $index = 0
            foreach ($value in $Node) {
                $path = if ($Prefix) { "$Prefix[$index]" } else { "[$index]" }
                WalkJson $value $path
                $index++
            }
            return
        }
        if ($Prefix) { $map[$Prefix] = [string]$Node }
    }

    WalkJson $object ''
    return $map
}

function Get-GitHubSnapshot {
    param($Config)

    $repoPath = Join-Path $Root $Config.Repo
    if (-not (Test-Path -LiteralPath $repoPath)) {
        throw "Repositório local não encontrado: $($Config.Repo)"
    }

    $ref = "upstream/$($Config.Branch)"
    $warnings = [System.Collections.Generic.List[string]]::new()

    if (-not $NoFetch) {
        git -C $repoPath fetch upstream $Config.Branch --quiet 2>$null | Out-Null
        if ($LASTEXITCODE -ne 0) {
            $warnings.Add('Não foi possível atualizar o upstream; usando a última referência local.')
        }
    }

    $sha = (git -C $repoPath rev-parse $ref 2>$null | Out-String).Trim()
    if ($LASTEXITCODE -ne 0 -or -not $sha) {
        throw "Referência $ref não encontrada. Atualize o clone ou rode sem -NoFetch."
    }
    $date = (git -C $repoPath log -1 --format=%cI $ref 2>$null | Out-String).Trim()

    $units = @{}
    $orphans = @{}

    foreach ($file in $Config.Files) {
        $sourceText = Get-GitFile $repoPath $ref $file.Source
        $sourceUnits = if ($file.Type -eq 'json') {
            Get-JsonUnits $sourceText
        }
        else {
            Get-XmlUnits $sourceText
        }

        $targetPath = Join-Path $repoPath $file.Target
        $targetUnits = @{}
        if (Test-Path -LiteralPath $targetPath) {
            $targetText = Get-Content -LiteralPath $targetPath -Raw -Encoding UTF8
            $targetUnits = if ($file.Type -eq 'json') {
                Get-JsonUnits $targetText
            }
            else {
                Get-XmlUnits $targetText
            }
        }
        else {
            $warnings.Add("Arquivo de tradução ausente: $($file.Target)")
        }

        foreach ($key in $sourceUnits.Keys) {
            $id = "$($file.Module)|$key"
            $text = Get-NormalizedText ([string]$sourceUnits[$key])
            $hasTarget = $targetUnits.ContainsKey($key) -and -not [string]::IsNullOrWhiteSpace([string]$targetUnits[$key])
            $units[$id] = @{
                text       = Get-StateText $text
                hash       = Get-TextHash $text
                translated = [bool]$hasTarget
            }
        }

        foreach ($key in $targetUnits.Keys) {
            if ($sourceUnits.ContainsKey($key)) { continue }
            $id = "$($file.Module)|$key"
            if ($orphans.ContainsKey($id)) { continue }
            $text = Get-NormalizedText ([string]$targetUnits[$key])
            $orphans[$id] = @{
                text = Get-StateText $text
                hash = Get-TextHash $text
            }
        }
    }

    $pending = @($units.Values | Where-Object { -not $_['translated'] }).Count
    return @{
        kind          = 'github'
        label         = $Config.Label
        checked_at    = Get-NowGmt3
        upstream      = $sha
        upstream_date = $date
        total         = $units.Count
        pending       = $pending
        checks        = $null
        last_change   = $date
        units         = $units
        orphans       = $orphans
        warnings      = @($warnings)
    }
}

function Get-CrowdinSnapshot {
    param($Config)

    if ([string]::IsNullOrWhiteSpace($CrowdinToken)) {
        throw 'Token do Crowdin não configurado em scripts/tokens.ps1.'
    }

    $base = "https://api.crowdin.com/api/v2/projects/$($Config.ProjectId)"
    $strings = Get-AllCrowdin "$base/strings"
    $translations = Get-AllCrowdin "$base/languages/pt-BR/translations"

    $latest = @{}
    foreach ($translation in $translations) {
        $stringId = [string]$translation.stringId
        $current = $latest[$stringId]
        if (-not $current -or [long]$translation.translationId -gt [long]$current['id']) {
            $latest[$stringId] = @{
                id   = [long]$translation.translationId
                text = ('' + $translation.text)
            }
        }
    }

    $units = @{}
    foreach ($string in $strings) {
        if ($string.isHidden) { continue }
        $id = [string]$string.id
        $text = Get-NormalizedText ('' + $string.text)
        $translation = $latest[$id]
        $translated = $translation -and -not [string]::IsNullOrWhiteSpace([string]$translation['text'])
        $units[$id] = @{
            text       = Get-StateText $text
            hash       = Get-TextHash $text
            translated = [bool]$translated
        }
    }

    $pending = @($units.Values | Where-Object { -not $_['translated'] }).Count
    return @{
        kind        = 'crowdin'
        label       = $Config.Label
        checked_at  = Get-NowGmt3
        total       = $units.Count
        pending     = $pending
        checks      = $null
        last_change = $null
        units       = $units
        orphans     = @{}
        warnings    = @()
    }
}

function Get-WeblateSnapshot {
    param($Config)

    if ([string]::IsNullOrWhiteSpace($WeblateToken)) {
        throw 'Token do Weblate não configurado em scripts/tokens.ps1.'
    }

    $base = "https://hosted.weblate.org/api/translations/$($Config.Project)/$($Config.Component)/pt_BR"
    $translation = Invoke-Api "$base/" $WeblateHeaders
    $rawUnits = Get-AllWeblate "$base/units/?page_size=100"

    $units = @{}
    foreach ($unit in $rawUnits) {
        $id = [string]$unit.id
        $source = (@($unit.source) -join ' | ')
        $text = Get-NormalizedText $source
        $translated = [bool]$unit.translated -or ([int]$unit.state -eq 100)
        $units[$id] = @{
            text       = Get-StateText $text
            hash       = Get-TextHash $text
            translated = [bool]$translated
        }
    }

    $pending = @($units.Values | Where-Object { -not $_['translated'] }).Count
    return @{
        kind        = 'weblate'
        label       = $Config.Label
        checked_at  = Get-NowGmt3
        total       = $units.Count
        pending     = $pending
        checks      = [int]$translation.failing_checks
        last_change = $translation.last_change
        units       = $units
        orphans     = @{}
        warnings    = @()
    }
}

function Compare-Snapshot {
    param($Previous, $Current)

    $result = @{
        Baseline     = $true
        Added        = [System.Collections.Generic.List[object]]::new()
        Removed      = [System.Collections.Generic.List[object]]::new()
        Changed      = [System.Collections.Generic.List[object]]::new()
        Untranslated = [System.Collections.Generic.List[object]]::new()
        Orphans      = [System.Collections.Generic.List[object]]::new()
    }

    $previousUnits = $null
    if ($Previous -and $Previous.Contains('units') -and $Previous['units']) {
        $previousUnits = $Previous['units']
    }
    $currentUnits = $Current['units']
    if (-not $previousUnits -or $previousUnits.Count -eq 0) {
        foreach ($id in $currentUnits.Keys) {
            $currentUnit = $currentUnits[$id]
            if (-not $currentUnit['translated']) {
                $result['Untranslated'].Add([pscustomobject]@{
                    Text = $currentUnit['text']
                })
            }
        }
        return $result
    }

    $result['Baseline'] = $false
    $previousOrphans = if ($Previous.Contains('orphans') -and $Previous['orphans']) {
        $Previous['orphans']
    }
    else {
        @{}
    }

    foreach ($id in $currentUnits.Keys) {
        $currentUnit = $currentUnits[$id]
        if (-not $previousUnits.Contains($id)) {
            $result['Added'].Add([pscustomobject]@{
                Text       = $currentUnit['text']
                Translated = [bool]$currentUnit['translated']
            })
            continue
        }

        $previousUnit = $previousUnits[$id]
        if ($previousUnit['hash'] -ne $currentUnit['hash']) {
            $result['Changed'].Add([pscustomobject]@{
                Old        = $previousUnit['text']
                New        = $currentUnit['text']
                Translated = [bool]$currentUnit['translated']
            })
        }
        if (-not $currentUnit['translated']) {
            $result['Untranslated'].Add([pscustomobject]@{
                Text = $currentUnit['text']
            })
        }
    }

    foreach ($id in $previousUnits.Keys) {
        if ($currentUnits.ContainsKey($id)) { continue }
        $previousUnit = $previousUnits[$id]
        $result['Removed'].Add([pscustomobject]@{
            Text = $previousUnit['text']
        })
    }

    foreach ($id in $Current['orphans'].Keys) {
        if ($previousUnits.Contains($id)) { continue }
        if ($previousOrphans.Contains($id)) { continue }
        $orphan = $Current['orphans'][$id]
        $result['Orphans'].Add([pscustomobject]@{
            Text = $orphan['text']
        })
    }

    return $result
}

function Write-List {
    param(
        [string]$Title,
        $Items,
        [string]$Color,
        [scriptblock]$Formatter
    )

    $list = @($Items)
    if ($list.Count -eq 0) { return }
    $list = @($list | Sort-Object -Property @{
        Expression = {
            if ($_.PSObject.Properties['Text']) { return [string]$_.Text }
            if ($_.PSObject.Properties['New']) { return [string]$_.New }
            return ''
        }
    })

    Write-Host "$Title ($($list.Count)):" -ForegroundColor $Color
    $limit = if ($AllDetails) { $list.Count } else { [Math]::Min($MaxItems, $list.Count) }
    for ($index = 0; $index -lt $limit; $index++) {
        Write-Host ('  • ' + (& $Formatter $list[$index]))
    }
    if ($limit -lt $list.Count) {
        Write-Host "  … e mais $($list.Count - $limit). Use -AllDetails para ver tudo." -ForegroundColor DarkGray
    }
}

function Test-ProjectSelected {
    param([string]$Key, [string]$Label)
    if ([string]::IsNullOrWhiteSpace($Project)) { return $true }
    return ($Key -like "*$Project*" -or $Label -like "*$Project*")
}

function Get-ResultHasNews {
    param($Previous, $Current, $Diff, [string]$Kind)

    $hasNews = $false
    foreach ($name in @('Added', 'Removed', 'Changed', 'Orphans')) {
        if ($Diff[$name].Count -gt 0) { $hasNews = $true }
    }

    if ($Previous) {
        if ($Previous.Contains('pending') -and [int]$Previous['pending'] -ne [int]$Current['pending']) {
            $hasNews = $true
        }
        if ($Kind -ne 'github' -and $Previous.Contains('checks') -and $Previous['checks'] -ne $null) {
            if ([int]$Previous['checks'] -ne [int]$Current['checks']) {
                $hasNews = $true
            }
        }
        if ($Kind -ne 'github' -and $Previous.Contains('last_change')) {
            if ([string]$Previous['last_change'] -ne [string]$Current['last_change']) {
                $hasNews = $true
            }
        }
    }
    return $hasNews
}

if ([string]::IsNullOrWhiteSpace($StateFile)) {
    $StateFile = Join-Path $PSScriptRoot '.state\check-updates.json'
}
if (-not [System.IO.Path]::IsPathRooted($StateFile)) {
    $StateFile = Join-Path $Root $StateFile
}
if ($ResetState -and (Test-Path -LiteralPath $StateFile)) {
    Remove-Item -LiteralPath $StateFile -Force
}

$state = @{ version = 1; projects = @{} }
if (Test-Path -LiteralPath $StateFile) {
    try {
        $loaded = Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8 | ConvertFrom-Json -AsHashtable
    }
    catch {
        throw "Não foi possível ler o estado local: $($_.Exception.Message)"
    }
    if ($loaded -is [System.Collections.IDictionary]) {
        $state = $loaded
    }
}
if (-not $state.Contains('projects') -or -not $state['projects']) {
    $state['projects'] = @{}
}

$results = [System.Collections.Generic.List[object]]::new()

foreach ($config in $GitHubProjects) {
    if (-not (Test-ProjectSelected $config.Key $config.Label)) { continue }
    try {
        $snapshot = Get-GitHubSnapshot $config
        $previous = if ($state['projects'].Contains($config.Key)) { $state['projects'][$config.Key] } else { $null }
        if ($previous -and [int]$previous['total'] -gt 0 -and [int]$snapshot.total -eq 0) {
            throw 'A consulta retornou zero strings; o estado anterior foi preservado.'
        }
        $diff = Compare-Snapshot $previous $snapshot
        $hasNews = Get-ResultHasNews $previous $snapshot $diff 'github'
        $results.Add([pscustomobject]@{
            Key      = $config.Key
            Label    = $config.Label
            Kind     = 'github'
            Snapshot = $snapshot
            Previous = $previous
            Diff     = $diff
            HasNews  = $hasNews
            Error    = $null
        })
    }
    catch {
        $results.Add([pscustomobject]@{
            Key      = $config.Key
            Label    = $config.Label
            Kind     = 'github'
            Snapshot = $null
            Previous = $null
            Diff     = $null
            HasNews  = $false
            Error    = $_.Exception.Message
        })
    }
}

foreach ($config in $PlatformProjects) {
    if (-not (Test-ProjectSelected $config.Key $config.Label)) { continue }
    try {
        $snapshot = if ($config.Platform -eq 'crowdin') {
            Get-CrowdinSnapshot $config
        }
        else {
            Get-WeblateSnapshot $config
        }
        $previous = if ($state['projects'].Contains($config.Key)) { $state['projects'][$config.Key] } else { $null }
        if ($previous -and [int]$previous['total'] -gt 0 -and [int]$snapshot.total -eq 0) {
            throw 'A consulta retornou zero strings; o estado anterior foi preservado.'
        }
        $diff = Compare-Snapshot $previous $snapshot
        $hasNews = Get-ResultHasNews $previous $snapshot $diff $config.Platform
        $results.Add([pscustomobject]@{
            Key      = $config.Key
            Label    = $config.Label
            Kind     = $config.Platform
            Snapshot = $snapshot
            Previous = $previous
            Diff     = $diff
            HasNews  = $hasNews
            Error    = $null
        })
    }
    catch {
        $results.Add([pscustomobject]@{
            Key      = $config.Key
            Label    = $config.Label
            Kind     = $config.Platform
            Snapshot = $null
            Previous = $null
            Diff     = $null
            HasNews  = $false
            Error    = $_.Exception.Message
        })
    }
}

$newsCount = 0
$noNewsCount = 0
$errorCount = 0

Write-Host "Consulta de atualizações — $(Get-NowGmt3) (GMT-3)" -ForegroundColor Cyan

foreach ($result in $results) {
    if ($result.Error) {
        $errorCount++
        Write-Host "`n=== $($result.Label) ===" -ForegroundColor Cyan
        Write-Host "ERRO: $($result.Error)" -ForegroundColor Red
        continue
    }

    $snapshot = $result.Snapshot
    $previous = $result.Previous
    $diff = $result.Diff
    $warnings = @($snapshot['warnings'])

    if ($Quiet -and -not $result.HasNews -and $warnings.Count -eq 0) {
        $noNewsCount++
        continue
    }

    Write-Host "`n=== $($result.Label) ===" -ForegroundColor Cyan
    if ($result.Kind -eq 'github') {
        $upstreamDate = Format-Gmt3 ([string]$snapshot['upstream_date'])
        if ($upstreamDate) {
            Write-Host "Origem atualizada em: $upstreamDate"
        }
    }

    $checksText = ''
    if ($null -ne $snapshot['checks']) {
        $checksText = " | Avisos de qualidade: $($snapshot['checks'])"
    }
    Write-Host "Strings: $($snapshot['total']) | Sem tradução: $($snapshot['pending'])$checksText"

    foreach ($warning in $warnings) {
        Write-Host "Aviso: $warning" -ForegroundColor Yellow
    }

    if ($diff['Baseline']) {
        Write-Host "Linha de base criada." -ForegroundColor Green
        if ($snapshot['pending'] -gt 0) {
            Write-List 'Strings ainda sem tradução' $diff['Untranslated'] 'Yellow' {
                param($item)
                return '"' + (Format-Text $item.Text) + '"'
            }
        }
        $noNewsCount++
        continue
    }

    if (-not $result.HasNews) {
        if ($snapshot['pending'] -gt 0) {
            Write-List 'Strings ainda sem tradução' $diff['Untranslated'] 'Yellow' {
                param($item)
                return '"' + (Format-Text $item.Text) + '"'
            }
        }
        Write-Host "Sem novidades." -ForegroundColor Green
        $noNewsCount++
        continue
    }

    $newsCount++

    if ($previous -and [int]$previous['pending'] -ne [int]$snapshot['pending']) {
        Write-Host "Pendentes: $($previous['pending']) → $($snapshot['pending'])" -ForegroundColor Yellow
    }
    if ($result.Kind -ne 'github' -and $previous -and $null -ne $snapshot['checks'] -and $previous['checks'] -ne $null) {
        if ([int]$previous['checks'] -ne [int]$snapshot['checks']) {
            Write-Host "Avisos de qualidade: $($previous['checks']) → $($snapshot['checks'])" -ForegroundColor Yellow
        }
    }
    if ($result.Kind -ne 'github' -and $previous -and [string]$previous['last_change'] -ne [string]$snapshot['last_change']) {
        $lastChange = Format-Gmt3 ([string]$snapshot['last_change'])
        if ($lastChange) {
            Write-Host "Última alteração na plataforma: $lastChange" -ForegroundColor DarkGray
        }
    }

    Write-List 'Novas strings na fonte' $diff['Added'] 'Yellow' {
        param($item)
        $suffix = if ([bool]$item.Translated) { ' — já traduzida' } else { ' — para traduzir' }
        return '"' + (Format-Text $item.Text) + '"' + $suffix
    }

    Write-List 'Strings removidas da fonte' $diff['Removed'] 'Red' {
        param($item)
        return '"' + (Format-Text $item.Text) + '"'
    }

    Write-List 'Textos alterados na fonte' $diff['Changed'] 'Magenta' {
        param($item)
        $suffix = if ([bool]$item.Translated) { ' — revisar tradução' } else { ' — sem tradução' }
        return '"' + (Format-Text $item.Old) + '"  →  "' + (Format-Text $item.New) + '"' + $suffix
    }

    Write-List 'Strings ainda sem tradução' $diff['Untranslated'] 'Yellow' {
        param($item)
        return '"' + (Format-Text $item.Text) + '"'
    }

    Write-List 'Traduções que sobraram no pt-BR' $diff['Orphans'] 'DarkYellow' {
        param($item)
        return '"' + (Format-Text $item.Text) + '"'
    }
}

if (-not $NoSave) {
    foreach ($result in $results) {
        if (-not $result.Error) {
            $state['projects'][$result.Key] = $result.Snapshot
        }
    }
    $state['version'] = 1
    $stateDirectory = Split-Path -Parent $StateFile
    if (-not (Test-Path -LiteralPath $stateDirectory)) {
        New-Item -ItemType Directory -Force -Path $stateDirectory | Out-Null
    }
    $temporary = "$StateFile.tmp"
    $json = ConvertTo-Json -InputObject $state -Depth 12
    [System.IO.File]::WriteAllText($temporary, $json, $Utf8NoBom)
    Move-Item -LiteralPath $temporary -Destination $StateFile -Force
}

Write-Host "`nResumo: $newsCount com novidades, $noNewsCount sem novidades, $errorCount erro(s)." -ForegroundColor Cyan

if ($errorCount -gt 0) { exit 1 }
if ($newsCount -gt 0) { exit 2 }
exit 0
