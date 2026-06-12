function Remove-Packages {
    foreach ($Name in $Config.Packages) {
        $found = Get-AppxPackage -Name $Name -AllUsers -ErrorAction SilentlyContinue

        if (-not $found) {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, "Remove-AppxPackage")) {
            try {
                $found | Remove-AppxPackage -AllUsers -ErrorAction Stop
                Write-Ok $Name
            } catch {
                Write-Fail "$Name — $($_.Exception.Message)"
            }
        }
    }
}
