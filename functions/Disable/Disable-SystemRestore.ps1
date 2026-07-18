function Disable-SystemRestore {
    Disable-ComputerRestore "C:\", "D:\"
    vssadmin delete shadows /all /quiet
    Write-Ok "Computer Restore Disabled and old restoration pointes deleted"

    Write-Running "Disabling System Restore Permanently"
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" -Name "DisableSR" -Value 1
}