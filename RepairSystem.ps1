#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Executes a comprehensive suite of maintenance tasks to rectify system corruption and optimise disk health.

.DESCRIPTION
    This script is designed for periodic system "tuning" and error correction. It performs a deep-level analysis of the operating system's integrity and storage performance through the following actions:
    - Initialises an online cleanup and restoration of the Windows Image using DISM.
    - Runs the System File Checker (SFC) to cross-reference and repair protected system files.
    - Schedules an offline volume repair (CHKDSK) for the C: drive to address file system inconsistencies.
    - Optimises the primary partition using the 'ReTrim' command, which is particularly beneficial for maintaining SSD performance.

.NOTES
    Author:      joao-vcthr
    Date:        04/28/2026
    Requirements: Must be run as Administrator. A restart is required to finalise disk repairs.
#>

$ErrorActionPreference = "Stop"

DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
Repair-Volume -DriveLetter C -OfflineScanAndFix -Confirm:$false
Repair-Volume -DriveLetter D -OfflineScanAndFix -Confirm:$false
