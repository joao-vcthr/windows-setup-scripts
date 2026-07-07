function Set-PowerPlan {
    Write-Running "Changing power plan to Balanced..."
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e # Change powerplan to Balanced

    powercfg /change monitor-timeout-ac 5 # Monitor timeout
    powercfg /change disk-timeout-ac 0 # Disk timeout
    powercfg /change standby-timeout-ac 0 # Disable Suspension

    powercfg /setacvalueindex SCHEME_CURRENT 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 000 # JavaScript Timer Frequency
    powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 000 # USB selective suspend setting
    powercfg /setacvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 000 # USB PCI Express ASPM

    powercfg.exe /hibernate off # Disable Hibernation

    Write-Ok "Power plan configured!"
}
