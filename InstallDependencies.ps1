#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Installs a set of essential dependencies and runtimes for games and applications.

.DESCRIPTION
    Using Winget, this script automates the installation of various versions
    of the following dependency packages:
    - .NET Runtime and .NET Desktop Runtime
    - Microsoft Visual C++ Redistributable (VCRedist)
    - Microsoft DirectX

.NOTES
    Author:      joao-vcthr
    Date:        04/28/2026
    Requirements: Must be run as Administrator. An internet connection is required.
#>

param (
    [switch]$DotNet,
    [switch]$VCRedist,
    [switch]$DirectX,
    [switch]$All
)

. "$PSScriptRoot\functions\Install\Install-App.ps1"
. "$PSScriptRoot\functions\Install\Install-PackageGroup.ps1"
. "$PSScriptRoot\functions\Install\Start-AppInstallation.ps1"

# --- Load Packages ---
$packagesFile = "$PSScriptRoot\packages\Dependencies.json"

if (-not (Test-Path $packagesFile)) {
    Write-Host "==> Error: packages.json not found at $packagesFile" -ForegroundColor Red
    exit 1
}

$packages = Get-Content $packagesFile | ConvertFrom-Json -AsHashtable
$installOrder = $packages["Order"]

# Update winget
winget source update

Write-Host "==> Installing dependencies..." -ForegroundColor Cyan

DISM /Online /Enable-Feature /FeatureName:NetFx3 /All # Enable .NET 3.5
Start-AppInstallation @PSBoundParameters

Write-Host "==> Dependencies installed! Restart the computer." -ForegroundColor Green
