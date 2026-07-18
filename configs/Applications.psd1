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
        @{ Id = 'Mozilla.Firefox' }
    )

    Productivity = @(
        @{ Id = 'Obsidian.Obsidian' }
        @{ Id = 'Doist.Todoist' }
        @{ Id = 'flxzt.rnote' }
        @{ Id = 'Mozilla.Thunderbird.MSIX' }
    )

    Communication = @(
        @{ Id = 'Telegram.TelegramDesktop' }
        @{ Id = 'Discord.Discord' }
        @{ Id = '9NBDXK71NK08'} # WhatsApp Beta
    )

    Security = @(
        @{ Id = 'KeePassXCTeam.KeePassXC'}
    )

    Office = @(
        @{ Id = 'TheDocumentFoundation.LibreOffice' }
        @{ Id = 'StirlingTools.StirlingPDF' }
    )

    ScreenCapture = @(
        @{ Id = 'ShareX.ShareX' }
        @{ Id = 'OBSProject.OBSStudio' }
    )

    Hardware = @(
        @{ Id = 'REALiX.HWiNFO' }
        @{ Id = 'CPUID.CPU-Z' }
        @{ Id = 'TechPowerUp.GPU-Z' }
    )

    CLI = @(
        @{ Id = 'Fastfetch-cli.Fastfetch' }
        @{ Id = 'Ookla.Speedtest.CLI' }
    )

    Media = @(
        @{ Id = 'VideoLAN.VLC' }
        @{ Id = 'FxSound.FxSound' }
    )

    Maintenance = @(
        @{ Id = 'BleachBit.BleachBit' }
        @{ Id = 'Klocman.BulkCrapUninstaller' }
    )

    Compression = @(
        @{ Id = '9N8G7TSCL18R' } # NanaZip
    )

    Gaming = @(
        @{ Id = 'Valve.Steam' }
        @{ Id = 'RiotGames.LeagueOfLegends.BR' }
        @{ Id = 'EpicGames.EpicGamesLauncher' }
        @{ Id = 'XPDM5VSMTKQLBJ' } # Battle.net
    )

    ProgrammingLanguages = @(
        @{ Id = 'Rustlang.Rustup' }
        @{ Id = 'LLVM.LLVM' }
        @{ Id = 'Oracle.JDK.25' }
        @{ Id = 'GoLang.Go' }
    )

    DevelopmentTools = @(
        @{ Id = 'Microsoft.WindowsTerminal' }
        @{ Id = 'Microsoft.VisualStudioCode' }
        @{ Id = 'Microsoft.VisualStudio.BuildTools' }
        @{ Id = 'JetBrains.Toolbox' }
        @{ Id = 'Git.Git' }
    )
}
