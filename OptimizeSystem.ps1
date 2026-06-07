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
    - Optimizing the main disk (TRIM).
    The computer will be restarted upon completion.

.NOTES
    Author:      joao-vcthr
    Date:        04/28/2026
    Requirements: Must be run as Administrator.
#>

$ErrorActionPreference = "Stop"

. "$PSScriptRoot\functions\Disable\Disable-GameDVR"
. "$PSScriptRoot\functions\Disable\Disable-Services"
. "$PSScriptRoot\functions\Disable\Disable-Telemetry"

Write-Host "==> Optmizing System..." -ForegroundColor Cyan

Disable-GameDVR
Disable-Services
Disable-Telemetry
Disable-AppPermissions

Write-Host "==> Disabling System Restore..." -ForegroundColor Cyan
Disable-ComputerRestore -Drive "C:\"
vssadmin delete shadows /all /quiet

Write-Host "==> Optimizing Disks" -ForegroundColor Cyan
Optimize-Volume -DriveLetter 'C' -Verbose -ReTrim
Optimize-Volume -DriveLetter 'D' -Verbose -ReTrim

Write-Host "==> Optimization completed! The computer will restart em 5 seconds" -ForegroundColor Green

Start-Sleep 5
Restart-Computer
