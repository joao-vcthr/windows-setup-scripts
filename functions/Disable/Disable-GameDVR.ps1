function Disable-GameDVR {
    
    # 1. Verifica se está rodando como Administrador (necessário para HKLM)
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error "This script must be run as administrator."
        return
    }

    # 2. Configurações de Usuário (HKCU)
    $paths = @(
        @{ 
            Path = "HKCU:\System\GameConfigStore"
            Values = @(
                @{ Name = "GameDVR_Enabled"; Value = 0 }
                @{ Name = "GameDVR_FSEBehavior"; Value = 2 }
                @{ Name = "GameDVR_HonorUserFSEBehaviorMode"; Value = 1 }
                @{ Name = "GameDVR_EFSEFeatureFlags"; Value = 0 }
            )
        },
        @{
            Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR"
            Values = @(
                @{ Name = "AppCaptureEnabled"; Value = 0 }
            )
        }
    )

    foreach ($entry in $paths) {
        if (-not (Test-Path $entry.Path)) { New-Item -Path $entry.Path -Force | Out-Null }
        
        foreach ($item in $entry.Values) {
            Write-Host "Configuring $($item.Name) to $($item.Value) at $($entry.Path)" -ForegroundColor Cyan
            Set-ItemProperty -Path $entry.Path -Name $item.Name -Value $item.Value -Force
        }
    }

    # 3. Configurações de Máquina/Política (HKLM)
    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
    if (-not (Test-Path $policyPath)) {
        New-Item -Path $policyPath -Force | Out-Null
    }
    
    Write-Host "Disabling AllowGameDVR global policy" -ForegroundColor Cyan
    Set-ItemProperty -Path $policyPath -Name "AllowGameDVR" -Value 0 -Force

    Write-Host "==> GameDVR and capture resources disabled! Restart the computer" -ForegroundColor Green
}
