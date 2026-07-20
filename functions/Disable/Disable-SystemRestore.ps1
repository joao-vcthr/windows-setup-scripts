function Disable-SystemRestore {
    Write-Running "Disabling Computer Restore in all Drivers"
    Disable-ComputerRestore "C:\", "D:\"

    Write-Running "Deleting old restoration points"
    vssadmin delete shadows /all /quiet

    Write-Running "Disabling System Restore Permanently"
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" -Name "DisableSR" -Value 1

    Write-Ok "Computer Restore Disabled and old restoration points deleted"
}
