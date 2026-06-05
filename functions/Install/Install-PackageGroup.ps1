function Install-PackageGroup {
    param(
        [string]$GroupName
    )

    Write-Host "==> Installing $GroupName..." -ForegroundColor Cyan

    foreach ($app in $packages[$GroupName]) {
        Install-App -App $app
    }

    Write-Host "==> $GroupName installed!" -ForegroundColor Green
}
