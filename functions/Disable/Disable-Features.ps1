function Disable-Features {
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $Features = @(
        'MediaPlayback'
        'MicrosoftWindowsPowerShellV2Root'
        'Microsoft-RemoteDesktopConnection'
        'Recall'
        'Microsoft-SnippingTool'
    )

    foreach ($Name in $Features) {
        try {
            $found = Get-WindowsOptionalFeature -Online -FeatureName $Name -ErrorAction Stop
        } catch {
            Write-Skip "$Name (not queryable -- $($_.Exception.Message))"
            continue
        }

        if (-not $found -or $found.State -ne 'Enabled') {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Disable-WindowsOptionalFeature')) {
            try {
                Disable-WindowsOptionalFeature -Online -FeatureName $Name -NoRestart -ErrorAction Stop | Out-Null
                Write-Ok $Name
            } catch {
                Write-Fail "$Name -- $($_.Exception.Message)"
            }
        }
    }
}
