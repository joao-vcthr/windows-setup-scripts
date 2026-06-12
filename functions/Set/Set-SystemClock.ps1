. "$PSScriptRoot\..\Helpers\Write-Output.ps1"

function Set-SystemClock {
    Write-Header "Setting time zone to Brasília..." -ForegroundColor Cyan
    Set-TimeZone -Id "E. South America Standard Time"
    
    Write-Header "Synchronising clock..." -ForegroundColor Cyan
    net start w32time
    W32tm /resync /force
    
    Write-Ok "Time zone set and Clock synchronised successfully!" -ForegroundColor Green
}
