function Remove-OneDrive {
	taskkill /f /im OneDrive.exe
	taskkill /f /im explorer.exe

	if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    	& "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall
	} else {
    	& "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall
	}

	Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
	Remove-Item "$env:SystemDrive\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue

	reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f
	reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f

	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Force | Out-Null
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1

	Start-Process explorer.exe
}