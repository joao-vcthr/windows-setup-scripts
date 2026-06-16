#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Windows 11 Debloat Script — removes AppX packages, optional capabilities and Windows features.

.DESCRIPTION
    Removes the AppX packages, optional capabilities and Windows features defined directly
    in the three function files. Designed to be idempotent: items that are already absent
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
. "$PSScriptRoot\functions\Remove\Remove-Packages.ps1"
. "$PSScriptRoot\functions\Remove\Remove-Capabilities.ps1"
. "$PSScriptRoot\functions\Remove\Remove-OneDrive.ps1"
. "$PSScriptRoot\functions\Disable\Disable-Features.ps1"

# ─── Remove AppX Packages ────────────────────────────────────────────────────
Write-Header 'AppX Packages'
Remove-Packages

# ─── Remove Optional Capabilities ───────────────────────────────────────────
Write-Header 'Optional Capabilities'
Remove-Capabilities

# ─── Remove OneDrive ───────────────────────────────────────────
Write-Header 'OneDrive'
Remove-OneDrive

# ─── Disable Optional Features ──────────────────────────────────────────────
Write-Header 'Optional Features'
Disable-Features

# ─── Done ────────────────────────────────────────────────────────────────────
Write-Host ''
Write-Ok "Done. A restart may be required for some changes to take effect." -ForegroundColor Yellow
