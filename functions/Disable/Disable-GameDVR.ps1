function Disable-GameDVR {

    # Configurações de Usuário (HKCU)
    $paths = @(
        @{
            Path = "HKCU:\System\GameConfigStore"
            Values = @(
                @{ Name = "GameDVR_Enabled";                Value = 0 }
                @{ Name = "GameDVR_FSEBehavior";            Value = 2 }
                @{ Name = "GameDVR_HonorUserFSEBehaviorMode"; Value = 1 }
                @{ Name = "GameDVR_EFSEFeatureFlags";       Value = 0 }
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
        foreach ($item in $entry.Values) {
            Write-Running "Configuring $($item.Name) to $($item.Value) at $($entry.Path)"
            Set-RegistryValue -Path $entry.Path -Name $item.Name -Value $item.Value
        }
    }

    # Configurações de Máquina/Política (HKLM)
    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"

    Write-Running "Disabling AllowGameDVR global policy"
    Set-RegistryValue -Path $policyPath -Name "AllowGameDVR" -Value 0

    Write-Ok "GameDVR and capture resources disabled! Restart the computer"
}
