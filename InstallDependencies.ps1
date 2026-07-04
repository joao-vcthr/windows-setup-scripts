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

. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"
. "$PSScriptRoot\functions\Install\Install-App.ps1"
. "$PSScriptRoot\functions\Install\Install-PackageGroup.ps1"
. "$PSScriptRoot\functions\Install\Start-AppInstallation.ps1"

# --- Load Packages ---
$packagesFile = "$PSScriptRoot\packages\Dependencies.psd1"

if (-not (Test-Path $packagesFile)) {
    Write-Fail "==> Error: Dependencies.psd1 not found at $packagesFile"
    exit 1
}

$packages = Import-PowerShellDataFile -Path $packagesFile
$installOrder = $packages["Order"]

Write-Header "Installing dependencies..."

if ($PSBoundParameters.Count -eq 0 -or $PSBoundParameters.ContainsKey("All") -or $PSBoundParameters.ContainsKey("DotNet")) {
    DISM /Online /Enable-Feature /FeatureName:NetFx3 /All # Enable .NET 3.5
}

Start-AppInstallation @PSBoundParameters

Write-Ok "Dependencies installed! Restart the computer."
