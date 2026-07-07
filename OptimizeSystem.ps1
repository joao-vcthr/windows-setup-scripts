#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Applies performance optimizations and fine-tuning to the system.

.DESCRIPTION
    This script applies advanced settings to optimize Windows performance,
    especially for gaming and power users. Actions include:
    - Disabling System Restore.
    - Disabling Game DVR via the Windows Registry.
    - Disabling a list of non-essential services (telemetry, printing, etc.).
    - Disabling app permissions.
    - Optimizing the main disk (TRIM).
    The computer will be restarted upon completion.

.NOTES
    Author:      joao-vcthr
    Date:        04/28/2026
    Requirements: Must be run as Administrator.
#>

[CmdletBinding(SupportsShouldProcess)]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"
. "$PSScriptRoot\functions\Set\Set-RegistryValue.ps1"
. "$PSScriptRoot\functions\Disable\Disable-GameDVR.ps1"
. "$PSScriptRoot\functions\Disable\Disable-Services.ps1"
. "$PSScriptRoot\functions\Disable\Disable-Telemetry.ps1"
. "$PSScriptRoot\functions\Disable\Disable-AppPermissions.ps1"
. "$PSScriptRoot\functions\Disable\Disable-MPO.ps1"

$servicesFile    = "$PSScriptRoot\configs\Services.psd1"
$permissionsFile = "$PSScriptRoot\configs\AppPermissions.psd1"

foreach ($file in @($servicesFile, $permissionsFile)) {
    if (-not (Test-Path $file)) {
        Write-Fail "==> Error: config file not found at $file"
        exit 1
    }
}

$services    = Import-PowerShellDataFile -Path $servicesFile
$permissions = Import-PowerShellDataFile -Path $permissionsFile

Write-Header "Optimizing System"

Write-Header "Disabling GameDVR"
Disable-GameDVR

Write-Header "Disabling Services"
Disable-Services -Services $services.Services

Write-Header "Disabling Telemetry"
Disable-Telemetry

Write-Header "Disabling App Permissions"
Disable-AppPermissions -Permissions $permissions.Permissions

Write-Header "Disabling MultiPlane Overlay (MPO)"
Disable-MPO

Write-Header "Disabling System Restore..."
Disable-ComputerRestore -Drive "C:\"
Disable-ComputerRestore -Drive "D:\"
vssadmin delete shadows /all /quiet

Write-Header "Optimizing Disks"
Optimize-Volume -DriveLetter 'C' -Verbose -ReTrim
Optimize-Volume -DriveLetter 'D' -Verbose -ReTrim

Write-Ok "Optimization completed! Restart the computer"
