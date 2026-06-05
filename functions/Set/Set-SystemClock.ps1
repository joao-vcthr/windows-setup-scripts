function Set-SystemClock {
    Write-Host "==> Setting time zone to Brasília..." -ForegroundColor Cyan
    Set-TimeZone -Id "E. South America Standard Time"
    
    Write-Host "==> Synchronising clock..." -ForegroundColor Cyan
    net start w32time
    W32tm /resync /force
    Write-Host "==> Time zone set and Clock synchronised successfully!" -ForegroundColor Green
}
