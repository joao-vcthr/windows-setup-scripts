function Set-Network {  
    Write-Running "Clearing old DNS cache..."
    Clear-DnsClientCache

    Write-Host "[1] Google DNS"
    Write-Host "[2] Cloudflare DNS"
    Write-Host "[3] OpenDNS"
    Write-Host "[4] Quad9 DNS"
    Write-Host "[5] Keep Current"
    $dns_provider = Read-Host "Choose Your DNS Provider"
    
    switch ($dns_provider) {
        1 {Write-Running "Changing DNS to Google DNS" ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("8.8.8.8", "8.8.4.4")}
        2 {Write-Running "Changing DNS to Cloudflare DNS" ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("1.1.1.1", "1.0.0.1")}
        3 {Write-Running "Changing DNS to OpenDNS" ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("208.67.222.222","208.67.220.220")}
        4 {Write-Running "Changing DNS to Quad9 DNS" ; Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("9.9.9.9","149.112.112.112")}
        5 {Write-Running "Keeping current DNS Provider"}
        default {Write-Fail "Invalid Option" ; ChangeDns}
    }

    netsh winsock reset
    Write-Running "==> Network configuration complete!"
}
