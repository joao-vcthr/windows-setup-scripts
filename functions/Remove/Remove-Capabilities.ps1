function Remove-Capabilities {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $Capabilities = @(
        'Print.Fax.Scan'
        'Language.Handwriting'
        'Browser.InternetExplorer'
        'MathRecognizer'
        'OneCoreUAP.OneSync'
        'OpenSSH.Client'
        'Microsoft.Windows.MSPaint'
        'Microsoft.Windows.PowerShell.ISE'
        'App.Support.QuickAssist'
        'Microsoft.Windows.SnippingTool'
        'Language.Speech'
        'Language.TextToSpeech'
        'App.StepsRecorder'
        'Media.WindowsMediaPlayer'
        'Microsoft.Windows.WordPad'
    )

    # Get-WindowsCapability precisa do Windows Update para buscar metadados;
    # garante que o servico esta rodando e restaura o estado original ao final.
    $wuauserv          = Get-Service -Name wuauserv
    $wuauservWasRunning = $wuauserv.Status -eq 'Running'

    if (-not $wuauservWasRunning) {
        Write-Host '  Starting Windows Update service temporarily...' -ForegroundColor DarkGray
        Start-Service -Name wuauserv
    }

    try {
        foreach ($Name in $Capabilities) {
            try {
                $found = Get-WindowsCapability -Online -ErrorAction Stop |
                         Where-Object { $_.Name -like "$Name*" -and $_.State -eq 'Installed' }
            } catch {
                Write-Skip "$Name (not queryable -- $($_.Exception.Message))"
                continue
            }

            if (-not $found) {
                Write-Skip $Name
                continue
            }

            if ($PSCmdlet.ShouldProcess($Name, 'Remove-WindowsCapability')) {
                try {
                    $found | Remove-WindowsCapability -Online -ErrorAction Stop | Out-Null
                    Write-Ok $Name
                } catch {
                    Write-Fail "$Name -- $($_.Exception.Message)"
                }
            }
        }
    } finally {
        # Para o servico apenas se foi iniciado por este script
        if (-not $wuauservWasRunning) {
            Write-Host '  Stopping Windows Update service...' -ForegroundColor DarkGray
            Stop-Service -Name wuauserv
        }
    }
}
