function Remove-AppxPackages {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string[]]$Packages
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

    Write-Ok "AppX packages removed!"
}
