function Disable-MPO {
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\Dwm" -Name "OverlayTestMode" -Value 5
    Write-Ok "MPO disabled"
}
