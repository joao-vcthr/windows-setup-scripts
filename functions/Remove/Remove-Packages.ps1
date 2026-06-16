function Remove-Packages {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $Packages = @(
        'Microsoft.Microsoft3DViewer'
        'Microsoft.BingSearch'
        'Microsoft.WindowsCamera'
        'Clipchamp.Clipchamp'
        'Microsoft.WindowsAlarms'
        'Microsoft.Copilot'
        'Microsoft.549981C3F5F10'         # Cortana
        'Microsoft.Windows.DevHome'
        'MicrosoftCorporationII.MicrosoftFamily'
        'Microsoft.WindowsFeedbackHub'
        'Microsoft.Edge.GameAssist'
        'Microsoft.GetHelp'
        'Microsoft.Getstarted'
        'microsoft.windowscommunicationsapps'
        'Microsoft.WindowsMaps'
        'Microsoft.MixedReality.Portal'
        'Microsoft.BingNews'
        'Microsoft.MicrosoftOfficeHub'
        'Microsoft.Office.OneNote'
        'Microsoft.Paint'
        'Microsoft.MSPaint'
        'Microsoft.People'
        'Microsoft.PowerAutomateDesktop'
        'MicrosoftCorporationII.QuickAssist'
        'Microsoft.SkypeApp'
        'Microsoft.ScreenSketch'
        'Microsoft.MicrosoftSolitaireCollection'
        'Microsoft.MicrosoftStickyNotes'
        'MicrosoftTeams'
        'MSTeams'
        'Microsoft.Todos'
        'Microsoft.WindowsSoundRecorder'
        'Microsoft.Wallet'
        'Microsoft.BingWeather'
        'Microsoft.YourPhone'
        'Microsoft.ZuneMusic'
        'Microsoft.ZuneVideo'
    )

    foreach ($Name in $Packages) {
        # Get-AppxPackage pode retornar multiplos resultados (ex.: pacote por usuario + provisionado)
        $found = Get-AppxPackage -Name $Name -AllUsers -ErrorAction SilentlyContinue

        if (-not $found) {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Remove-AppxPackage')) {
            try {
                $found | Remove-AppxPackage -AllUsers -ErrorAction Stop

                # Remove tambem o pacote provisionado para que nao seja reinstalado
                # em novas contas de usuario
                $provisioned = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue |
                               Where-Object { $_.DisplayName -like $Name }
                if ($provisioned) {
                    $provisioned | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Out-Null
                }

                Write-Ok $Name
            } catch {
                Write-Fail "$Name -- $($_.Exception.Message)"
            }
        }
    }
}
