function Set-PowerPlanHighPerformance {
    Write-Host "==> Configuring power plan..." -ForegroundColor Cyan

    Write-Host "==> Changing power plan to High Performance..." -ForegroundColor Cyan
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c # Change powerplan to High Performance

    powercfg /change monitor-timeout-ac 5 # Monitor timeout
    powercfg /change disk-timeout-ac 0 # Disk timeout
    powercfg /change standby-timeout-ac 0 # Disable Suspension

    powercfg /setacvalueindex SCHEME_CURRENT 02f815b5-a5cf-4c84-bf20-649d1f75d3d8 4c793e7d-a264-42e1-87d3-7a0d2f523ccd 000 # JavaScript Timer Frequency
    powercfg /setacvalueindex SCHEME_CURRENT 0d7dbae2-4294-402a-ba8e-26777e8488cd 309dce9b-bef4-4119-9921-a851fb12f0f4 001 # Slide show
    powercfg /setacvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 003 # Power Saving Mode
    powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP RTCWAKE 000 # Real-Time Clock Wake
    powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 000 # USB selective suspend setting
    powercfg /setacvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 001 # USB PCI Express ASPM

    powercfg.exe /hibernate off # Disable Hibernation

    Write-Host "==> Power plan configured!" -ForegroundColor Green
}
