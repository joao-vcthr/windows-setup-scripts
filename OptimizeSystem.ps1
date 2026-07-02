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

. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"
. "$PSScriptRoot\functions\Disable\Disable-GameDVR"
. "$PSScriptRoot\functions\Disable\Disable-Services"
. "$PSScriptRoot\functions\Disable\Disable-Telemetry"
. "$PSScriptRoot\functions\Disable\Disable-MPO"


Write-Header "Optmizing System..."

Disable-GameDVR
Disable-Services
Disable-Telemetry
Disable-AppPermissions
Disable-MPO

Write-Header "Disabling System Restore..."
Disable-ComputerRestore -Drive "C:\"
vssadmin delete shadows /all /quiet

Write-Header "Optimizing Disks"
Optimize-Volume -DriveLetter 'C' -Verbose -ReTrim
Optimize-Volume -DriveLetter 'D' -Verbose -ReTrim

Write-Ok "Optimization completed! Restart the computer"
