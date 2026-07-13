#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Windows 11 Debloat Script — removes AppX packages, optional capabilities and Windows features.

.DESCRIPTION
    Removes the AppX packages, optional capabilities and Windows features defined in the
    .psd1 files under .\configs. Designed to be idempotent: items that are already absent
    are silently skipped. Must be run with Windows PowerShell 5.1 (powershell.exe).

.PARAMETER WhatIf
    Dry-run mode — shows what would be removed without making any changes.

.EXAMPLE
    powershell.exe -ExecutionPolicy Bypass -File .\DebloatSystem.ps1
    powershell.exe -ExecutionPolicy Bypass -File .\DebloatSystem.ps1 -WhatIf
#>

[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"
. "$PSScriptRoot\functions\Set\Set-RegistryValue.ps1"
. "$PSScriptRoot\functions\Remove\Remove-AppxPackages.ps1"
. "$PSScriptRoot\functions\Remove\Remove-Capabilities.ps1"
. "$PSScriptRoot\functions\Remove\Remove-OneDrive.ps1"
. "$PSScriptRoot\functions\Disable\Disable-Features.ps1"

$appxPackagesFile = "$PSScriptRoot\configs\AppxPackages.psd1"
$capabilitiesFile = "$PSScriptRoot\configs\Capabilities.psd1"
$featuresFile     = "$PSScriptRoot\configs\Features.psd1"

foreach ($file in @($appxPackagesFile, $capabilitiesFile, $featuresFile)) {
    if (-not (Test-Path $file)) {
        Write-Fail "==> Error: config file not found at $file"
        exit 1
    }
}

$appxPackages = Import-PowerShellDataFile -Path $appxPackagesFile
$capabilities = Import-PowerShellDataFile -Path $capabilitiesFile
$features     = Import-PowerShellDataFile -Path $featuresFile

# ─── Remove AppX Packages ────────────────────────────────────────────────────
Write-Header 'Removing AppX Packages'
Remove-AppxPackages -Packages $appxPackages.Packages

# ─── Remove Optional Capabilities ───────────────────────────────────────────
Write-Header 'Removing Optional Capabilities'
Remove-Capabilities -Capabilities $capabilities.Capabilities

# ─── Disable Optional Features ──────────────────────────────────────────────
Write-Header 'Disabling Optional Features'
Disable-Features -Features $features.Features

# ─── Remove OneDrive ─────────────────────────────────────────────────────────
Write-Header 'Removing OneDrive'
Remove-OneDrive

# ─── Done ────────────────────────────────────────────────────────────────────
Write-Host ''
Write-Ok "Done. A restart may be required for some changes to take effect."
