function Disable-Services {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string[]]$Services
    )

    foreach ($Name in $Services) {
        $svc = Get-Service -Name $Name -ErrorAction SilentlyContinue

        if (-not $svc) {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Stop and disable service')) {
            try {
                Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue
                Set-Service -Name $Name -StartupType Disabled -ErrorAction Stop
                Write-Ok $Name
            } catch {
                Write-Fail "$Name -- $($_.Exception.Message)"
            }
        }
    }

    Write-Ok "Services disabled!"
}
