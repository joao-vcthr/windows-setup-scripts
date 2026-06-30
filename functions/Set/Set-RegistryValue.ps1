function Set-RegistryValue {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        $Value,

        [Parameter(Mandatory = $false)]
        [Microsoft.Win32.RegistryValueKind]$Type = [Microsoft.Win32.RegistryValueKind]::DWord
    )

    try {
        # Verify if path exists
        if (-not (Test-Path -Path $Path)) {
            Write-Verbose " '$Path' does not exist. Creating..."
            New-Item -Path $Path -Force | Out-Null
        }

        # Verify if the value/property already exists
        $existingProperty = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue

        if ($null -eq $existingProperty) {
            Write-Verbose " '$Name' does not exist. Creating..."
            New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        }
        else {
            Write-Verbose "Changing '$Name'..."
            Set-ItemProperty -Path $Path -Name $Name -Value $Value
        }

        Write-Ok "'$Name' defined as '$Value' at '$Path'"
    }
    catch {
        Write-Fail "Error defining registry value: $_"
    }
}
