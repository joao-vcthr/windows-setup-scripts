function Set-KeyboardLayout {
    Write-Host "==> Removing unused keyboard layouts..." -ForegroundColor Cyan
    $LanguageList = New-WinUserLanguageList "pt-BR"
    $LanguageList[0].InputMethodTips.Clear()
    $LanguageList[0].InputMethodTips.Add("0416:00010416")
    Set-WinUserLanguageList -LanguageList $LanguageList -Force
}
