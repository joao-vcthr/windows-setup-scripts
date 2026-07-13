function Remove-AppxPackages {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string[]]$Packages
    )

    foreach ($Name in $Packages) {
        
        $found = Get-AppxPackage -Name $Name -AllUsers -ErrorAction SilentlyContinue

        if (-not $found) {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Remove-AppxPackage')) {
            try {
                $found | Remove-AppxPackage -AllUsers -ErrorAction Stop

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

    Write-Ok "AppX packages removed!"
}
