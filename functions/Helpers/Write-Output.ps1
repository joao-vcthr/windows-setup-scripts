function Write-Header {
    param ([string] $Title)
    Write-Host ""
    Write-Host "━━━  $Title  " -ForegroundColor Cyan
}

function Write-Ok   { param ([string] $Msg) Write-Host "  ✔  $Msg" -ForegroundColor Green  }
function Write-Skip { param ([string] $Msg) Write-Host "  –  $Msg" -ForegroundColor DarkGray }
function Write-Fail { param ([string] $Msg) Write-Host "  ✖  $Msg" -ForegroundColor Red    }
function Write-Running { param ([string] $Msg) Write-Host "  ⧖  $Msg" -ForegroundColor Yellow  }
