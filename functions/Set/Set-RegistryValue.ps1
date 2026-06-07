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
        # Verifica se o caminho (chave) existe; se não, cria
        if (-not (Test-Path -Path $Path)) {
            Write-Verbose " '$Path' does not exist. Creating..."
            New-Item -Path $Path -Force | Out-Null
        }

        # Verifica se o valor (propriedade) já existe dentro da chave
        $existingProperty = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue

        if ($null -eq $existingProperty) {
            Write-Verbose " '$Name' does not exist. Creating..."
            New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        }
        else {
            Write-Verbose "Changing '$Name'..."
            Set-ItemProperty -Path $Path -Name $Name -Value $Value
        }

        Write-Host "OK: '$Name' defined as '$Value' at '$Path'" -ForegroundColor Green
    }
    catch {
        Write-Error "Error defining registry value: $_"
    }
}
