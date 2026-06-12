#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Facilitates the initial commissioning and hardening of a freshly installed Windows environment.

.DESCRIPTION
    This script automates the essential configuration steps required to transform a default installation into an optimised workstation. It consolidates multiple administrative tasks into a single workflow to ensure consistency across deployments.

    Key actions include:
    - Authorising a high-performance power scheme and deactivating hibernation to reclaim storage.
    - Synchronising the system clock and localising the time zone settings.
    - Establishing a secure network configuration with custom DNS and cleared caches.
    - Initialising system integrity checks (DISM/SFC) and physical disk verification.
    - Customising Winget settings to enable installer hash overrides for smoother package management.

.NOTES
    Author:      joao-vcthr
    Date:        05/08/2026
    Requirements: Must be run as Administrator. An internet connection is required for synchronisation and Winget configuration.
#>

. "$PSScriptRoot\functions\Set\Set-SystemClock.ps1"
. "$PSScriptRoot\functions\Set\Set-PowerPlan.ps1"
. "$PSScriptRoot\functions\Set\Set-Network.ps1"
. "$PSScriptRoot\functions\Set\Set-KeyboardLayout.ps1"
. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"

Write-Header "Starting Initial Setup..."

Set-SystemClock
Set-Network
Set-KeyboardLayout
Set-DODownloadMode -DownloadMode 0 # Disable Delivery Optimisation
Select-PowerPlan

winget source update
winget install --id Microsoft.PowerShell --source winget --exact --accept-package-agreements --accept-source-agreements
winget settings --enable InstallerHashOverride

Write-Ok "Initial Setup Done!"
