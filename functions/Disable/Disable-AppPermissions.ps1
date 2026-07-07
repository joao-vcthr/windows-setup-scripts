function Disable-AppPermissions {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [hashtable[]]$Permissions
    )

    $policyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"

    # Value 2 = Force Deny
    $forceDeny = 2

    foreach ($perm in $Permissions) {
        if ($PSCmdlet.ShouldProcess($perm.Label, 'Disable permission')) {
            try {
                Set-RegistryValue -Path $policyPath -Name $perm.Name -Value $forceDeny
                Write-Ok $perm.Label
            } catch {
                Write-Fail "$($perm.Label) -- $($_.Exception.Message)"
            }
        }
    }

    # --- Automatic File Downloads ---
    # Controlado separadamente (OneDrive Files On-Demand), em HKCU.
    # Valor 1 no DWORD "DisableLibraryRehydration" bloqueia downloads automaticos de arquivos na nuvem.
    Write-Running "[CloudFiles] Disabling: Automatic File Downloads"

    if ($PSCmdlet.ShouldProcess('Automatic File Downloads', 'Disable')) {
        try {
            Set-RegistryValue -Path "HKCU:\Software\Policies\Microsoft\CloudFiles" `
                               -Name "DisableLibraryRehydration" `
                               -Value 1
            Write-Ok "Automatic File Downloads"
        } catch {
            Write-Fail "Automatic File Downloads -- $($_.Exception.Message)"
        }
    }

    Write-Ok "App permissions disabled!"
}
