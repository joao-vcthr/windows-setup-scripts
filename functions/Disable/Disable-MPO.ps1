function Disable-MPO {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Force | Out-Null

    New-ItemProperty `
        -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" `
        -Name "OverlayTestMode" `
        -PropertyType DWord `
        -Value 5 `
        -Force | Out-Null

    Write-Ok "MPO disabled"
}
