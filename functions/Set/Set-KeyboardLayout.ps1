function Set-KeyboardLayout {
    $LanguageList = New-WinUserLanguageList "en-US"
    $LanguageList[0].InputMethodTips.Clear()
    $LanguageList[0].InputMethodTips.Add("0416:00010416")
    Set-WinUserLanguageList -LanguageList $LanguageList -Force
}
