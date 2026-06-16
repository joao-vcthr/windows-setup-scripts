function Set-SystemClock {
    Write-Header "Setting system clock..."
    
    Write-Running "Setting time zone to Brasília..."
    Set-TimeZone -Id "E. South America Standard Time"
    
    Write-Running "Synchronising clock..."
    net start w32time
    W32tm /resync /force
    
    Write-Ok "Time zone set and Clock synchronised successfully!"
}
