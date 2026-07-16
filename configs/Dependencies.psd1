@{
    Order = @(
        'DotNet'
        'VCRedist'
        'DirectX'
    )

    DotNet = @(
        @{ Id = 'Microsoft.DotNet.DesktopRuntime.8'; }
        @{ Id = 'Microsoft.DotNet.DesktopRuntime.10'; }
    )

    VCRedist = @(
        @{ Id = 'Microsoft.VCRedist.2005.x64'; }
        @{ Id = 'Microsoft.VCRedist.2005.x86'; }
        @{ Id = 'Microsoft.VCRedist.2008.x64'; }
        @{ Id = 'Microsoft.VCRedist.2008.x86'; }
        @{ Id = 'Microsoft.VCRedist.2010.x64'; }
        @{ Id = 'Microsoft.VCRedist.2010.x86'; }
        @{ Id = 'Microsoft.VCRedist.2012.x64'; }
        @{ Id = 'Microsoft.VCRedist.2012.x86'; }
        @{ Id = 'Microsoft.VCRedist.2013.x64'; }
        @{ Id = 'Microsoft.VCRedist.2013.x86'; }
        @{ Id = 'Microsoft.VCRedist.2015+.x64'; }
        @{ Id = 'Microsoft.VCRedist.2015+.x86'; }
    )

    DirectX = @(
        @{ Id = 'Microsoft.DirectX'; }
    )
}
