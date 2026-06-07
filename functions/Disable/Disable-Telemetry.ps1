. "$PSScriptRoot\..\Set\Set-RegistryValue.ps1"

function Disable-Telemetry {
    Write-Host "==> Disabling Telemetry" -ForegroundColor Cyan

    # --- Recommendations & Offers ---
    Write-Host "Disabling Personalized offers..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0

    Write-Host "Disabling Improve Start and search results..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0

    Write-Host "Disabling account notifications in settings..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" -Name "EnableAccountNotifications" -Value 0

    Write-Host "Disabling recommendations in settings..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value 0
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value 0

    Write-Host "Disabling Advertising ID..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0

    # --- Speech ---
    Write-Host "Disabling Speech..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -Value 0

    # --- Inking & Typing Personalization ---
    Write-Host "Disabling Inking & Typing Personalization..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value 0

    # --- Diagnostics & Feedback ---
    Write-Host "Configuring Diagnostics & Feedback..."
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 1
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 1

    Write-Host "Disabling typing data collection..."
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" -Name "AllowLinguisticDataCollection" -Value 0

    Write-Host "Disabling Error Reporting..."
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1

    # --- Search ---
    Write-Host "Configuring Search..."
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SafeSearchMode" -Value 0
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -Value 0
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -Value 0
    Set-RegistryValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -Value 0

    # --- Language list ---
    Write-Host "Blocking acess to language list..."
    Set-RegistryValue -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Value 1

    Write-Host "==> Telemetry Disabled!" -ForegroundColor Green
}

function Disable-AppPermissions {

    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"

    # Value 2 = Force Deny
    $forceDeny = 2

    $permissions = @(
        @{ Name = "LetAppsAccessLocation";    Label = "Location"               },
        @{ Name = "LetAppsAccessCamera";      Label = "Camera"                 },
        @{ Name = "LetAppsAccessAccountInfo"; Label = "Account Info"           },
        @{ Name = "LetAppsAccessContacts";    Label = "Contacts"               },
        @{ Name = "LetAppsAccessCalendar";    Label = "Calendar"               },
        @{ Name = "LetAppsAccessPhone";       Label = "Phone Calls"            },
        @{ Name = "LetAppsAccessCallHistory"; Label = "Call History"           },
        @{ Name = "LetAppsAccessTasks";       Label = "Tasks"                  },
        @{ Name = "LetAppsAccessMessaging";   Label = "Messaging"              },
        @{ Name = "LetAppsAccessRadios";      Label = "Radios"                 },
        @{ Name = "LetAppsSyncWithDevices";   Label = "Other Devices"          },
        @{ Name = "LetAppsGetDiagnosticInfo"; Label = "App Diagnostics"        }
    )

    Write-Host "`n[AppPrivacy] Disbaling Apps Permissions..." -ForegroundColor Yellow

    foreach ($perm in $permissions) {
        Write-Host "  Disabling: $($perm.Label)" -ForegroundColor Cyan
        Set-RegistryValue -Path $policyPath -Name $perm.Name -Value $forceDeny
    }

    # --- Automatic File Downloads ---
    # Controlado separadamente (OneDrive Files On-Demand), em HKCU.
    # Valor 1 no DWORD "Enabled" = bloqueia downloads automáticos de arquivos na nuvem.
    Write-Host "`n[CloudFiles] Disabling: Automatic File Downloads" -ForegroundColor Cyan
    Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\CloudFiles" `
                      -Name "DisableLibraryRehydration" `
                      -Value 1

    Write-Host "`n==> App permissions disabled!" -ForegroundColor Green
}
