#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Windows 11 Debloat Script — declarative removal of packages, capabilities and features.

.DESCRIPTION
    Removes all AppX packages, optional capabilities and Windows features listed in the
    JSON config file defined by $ConfigPath below.  Designed to be idempotent: items
    that are already absent are silently skipped.

.PARAMETER WhatIf
    Dry-run mode — shows what would be removed without making any changes.

.EXAMPLE
    .\Debloat.ps1
    .\Debloat.ps1 -WhatIf
#>

[CmdletBinding(SupportsShouldProcess)]
param()

. "$PSScriptRoot\functions\Disable\Disable-Features.ps1"
. "$PSScriptRoot\functions\Remove\Remove-Capabilities.ps1"
. "$PSScriptRoot\functions\Remove\Remove-Packages.ps1"
. "$PSScriptRoot\functions\Helpers\Write-Output.ps1"

# ─── Config path — edit this to point to your debloat.json ──────────────────
$ConfigPath = "$PSScriptRoot\config\Debloat.json"

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"


# ─── Load config ────────────────────────────────────────────────────────────

if (-not (Test-Path $ConfigPath)) {
    Write-Error "Config file not found: $ConfigPath"
    exit 1
}

$Config = Get-Content -Raw $ConfigPath | ConvertFrom-Json

# ─── Remove AppX Packages ───────────────────────────────────────────────────
Write-Header "AppX Packages"
Remove-Packages

# ─── Remove Optional Capabilities ───────────────────────────────────────────
Write-Header "Optional Capabilities"
Remove-Capabilities

# ─── Disable Optional Features ──────────────────────────────────────────────
Write-Header "Optional Features"
Disable-Features



# ─── Done ────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "  Done.  A restart may be required for some changes to take effect." -ForegroundColor Yellow
Write-Host ""