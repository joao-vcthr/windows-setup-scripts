#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Installs desktop applications via Winget and MS Store using switch parameters.
.DESCRIPTION
    Automated installation script for various software categories.
    Package list is defined externally in Applications.psd1.
.NOTES
    Author:      joao-vcthr
    Date:        09/21/2025
    Requirements: Must be run as Administrator. An internet connection is required.
#>

param (
    [switch]$Browsers,
    [switch]$Communication,
    [switch]$ScreenCapture,
    [switch]$Productivity,
    [switch]$Office,
    [switch]$Hardware,
    [switch]$Media,
    [switch]$Maintenance,
    [switch]$Compression,
    [switch]$Gaming,
    [switch]$ProgrammingLanguages,
    [switch]$DevelopmentTools,
    [switch]$All
)

. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"
. "$PSScriptRoot\functions\Install\Install-App.ps1"
. "$PSScriptRoot\functions\Install\Install-PackageGroup.ps1"
. "$PSScriptRoot\functions\Install\Start-AppInstallation.ps1"

# --- Load Packages ---
$packagesFile = "$PSScriptRoot\packages\Applications.psd1"

if (-not (Test-Path $packagesFile)) {
    Write-Fail "==> Error: Applications.psd1 not found at $packagesFile"
    exit 1
}

$packages = Import-PowerShellDataFile -Path $packagesFile
$installOrder = $packages["Order"]

Write-Header "Installing Apps..."

Start-AppInstallation @PSBoundParameters

Write-Ok "Apps installed!"
