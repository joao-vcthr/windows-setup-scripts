@{
    Order = @(
        'Browsers'
        'Productivity'
        'Communication'
        'Security'
        'Office'
        'ScreenCapture'
        'Hardware'
        'CLI'
        'Media'
        'Maintenance'
        'Compression'
        'Gaming'
        'ProgrammingLanguages'
        'DevelopmentTools'
    )

    Browsers = @(
        @{ Id = 'Mozilla.Firefox'; Source = 'winget' }
    )

    Productivity = @(
        @{ Id = 'Obsidian.Obsidian'; Source = 'winget' }
        @{ Id = 'Doist.Todoist'; Source = 'winget' }
        @{ Id = 'Mozilla.Thunderbird.MSIX'; Source = 'winget' }
    )

    Communication = @(
        @{ Id = 'Telegram.TelegramDesktop'; Source = 'winget' }
        @{ Id = 'Discord.Discord'; Source = 'winget' }
        @{ Id = '9NBDXK71NK08'; Source = 'msstore'} # WhatsApp Beta
    )

    Security = @(
        @{ Id = 'KeePassXCTeam.KeePassXC'; Source = 'winget'}
    )

    Office = @(
        @{ Id = 'TheDocumentFoundation.LibreOffice'; Source = 'winget' }
        @{ Id = 'StirlingTools.StirlingPDF'; Source = 'winget' }
    )

    ScreenCapture = @(
        @{ Id = 'ShareX.ShareX'; Source = 'winget' }
        @{ Id = 'OBSProject.OBSStudio'; Source = 'winget' }
    )

    Hardware = @(
        @{ Id = 'REALiX.HWiNFO'; Source = 'winget' }
        @{ Id = 'CPUID.CPU-Z'; Source = 'winget'}
        @{ Id = 'TechPowerUp.GPU-Z'; Source = 'winget' }
    )

    CLI = @(
        @{ Id = 'Fastfetch-cli.Fastfetch'; Source = 'winget' }
        @{ Id = 'Ookla.Speedtest.CLI'; Source = 'winget' }
    )

    Media = @(
        @{ Id = 'VideoLAN.VLC'; Source = 'winget' }
        @{ Id = 'FxSound.FxSound'; Source = 'winget' }
    )

    Maintenance = @(
        @{ Id = 'BleachBit.BleachBit'; Source = 'winget' }
        @{ Id = 'Klocman.BulkCrapUninstaller'; Source = 'winget' } 
        @{ Id = 'AdventDevelopmentInc.Kudu'; Source = 'winget' }
    )

    Compression = @(
        @{ Id = '9N8G7TSCL18R'; Source = 'msstore' } # NanaZip
    )

    Gaming = @(
        @{ Id = 'Valve.Steam'; Source = 'winget' }
        @{ Id = 'RiotGames.LeagueOfLegends.BR'; Source = 'winget' }
        @{ Id = 'EpicGames.EpicGamesLauncher'; Source = 'winget' }
        @{ Id = 'ElectronicArts.EADesktop'; Source = 'winget' }
    )

    ProgrammingLanguages = @(
        @{ Id = 'Rustlang.Rustup'; Source = 'winget' }
        @{ Id = 'LLVM.LLVM'; Source = 'winget' }
        @{ Id = 'Oracle.JDK.25'; Source = 'winget' }
        @{ Id = 'GoLang.Go'; Source = 'winget' }
    )

    DevelopmentTools = @(
        @{ Id = 'Microsoft.WindowsTerminal'; Source = 'winget' }
        @{ Id = 'Microsoft.VisualStudioCode'; Source = 'winget' }
        @{ Id = 'Microsoft.VisualStudio.BuildTools'; Source = 'winget' }
        @{ Id = 'Kitware.CMake'; Source = 'winget' }
        @{ Id = 'Git.Git'; Source = 'winget' }
        @{ Id = 'Notepad++.Notepad++'; Source = 'winget' }
        @{ Id = 'JetBrains.Toolbox'; Source = 'winget' }
    )
}
