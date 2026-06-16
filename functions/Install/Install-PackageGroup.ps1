function Install-PackageGroup {
    param(
        [string]$GroupName
    )

    Write-Header "Installing $GroupName..."

    foreach ($app in $packages[$GroupName]) {
        Install-App -App $app
    }

    Write-Ok "$GroupName installed!"
}
