function Set-Network {
    Write-Host "==> Configuring network" -ForegroundColor Cyan
    
    Write-Host "==> Clearing old DNS cache..." -ForegroundColor Cyan
    Clear-DnsClientCache

    Write-Host "[1] Google DNS"
    Write-Host "[2] Cloudflare DNS"
    Write-Host "[3] OpenDNS"
    Write-Host "[4] Quad9 DNS"
    Write-Host "[5] Keep Current"
    $dns_provider = Read-Host "Choose Your DNS Provider"
    
    switch ($dns_provider) {
        1 {Write-Host "Changing DNS to Google DNS" -ForegroundColor Cyan ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("8.8.8.8", "8.8.4.4")}
        2 {Write-Host "Changing DNS to Cloudflare DNS" -ForegroundColor Cyan ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("1.1.1.1", "1.0.0.1")}
        3 {Write-Host "Changing DNS to OpenDNS" -ForegroundColor Cyan ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("208.67.222.222","208.67.220.220")}
        4 {Write-Host "Changing DNS to Quad9 DNS" -ForegroundColor Cyan ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("9.9.9.9","149.112.112.112")}
        5 {Write-Host "Keeping current DNS Provider"}
        default {Write-Host "Invalid Option" -ForegroundColor Red ; ChangeDns}
    }

    netsh winsock reset
    Write-Host "==> Network configuration complete!" -ForegroundColor Green
}
