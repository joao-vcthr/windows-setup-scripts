function Remove-Capabilities {
    $wuauserv        = Get-Service -Name wuauserv
    $wuauservStopped = $wuauserv.Status -ne "Running"

    if ($wuauservStopped) {
        Write-Host "  Starting Windows Update service temporarily..." -ForegroundColor DarkGray
        Start-Service -Name wuauserv
    }

    try {
        foreach ($Name in $Config.Capabilities) {
            try {
                $found = Get-WindowsCapability -Online -ErrorAction Stop |
                        Where-Object { $_.Name -like "$Name*" -and $_.State -eq "Installed" }
            } catch {
                Write-Skip "$Name (not queryable — $($_.Exception.Message))"
                continue
            }

            if (-not $found) {
                Write-Skip $Name
                continue
            }

            if ($PSCmdlet.ShouldProcess($Name, "Remove-WindowsCapability")) {
                try {
                    $found | Remove-WindowsCapability -Online -ErrorAction Stop | Out-Null
                    Write-Ok $Name
                } catch {
                    Write-Fail "$Name — $($_.Exception.Message)"
                }
            }
        }
    } finally {
        if ($wuauservStopped) {
            Write-Host "  Stopping Windows Update service..." -ForegroundColor DarkGray
            Stop-Service -Name wuauserv
        }
    }
    
}