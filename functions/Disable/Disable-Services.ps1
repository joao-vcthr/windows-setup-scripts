function Disable-Services {
    # List of services to be disabled
    $services = @(
        "WSearch",          # Windows Search
        "Spooler",          # Print Spooler
        "Fax",              # Fax
        "WerSvc",           # Windows Error Reporting
        "RemoteRegistry",   # Remote Registry
        "TermService",      # Remote Desktop Services
        "TabletInputService", # Touch Keyboard & Handwriting
        "seclogon",         # Secondary Logon
        "SCardSvr",         # Smart Card
        "SCPolicySvc",      # Smart Card Policy
        "SysMain",          # SysMain
        # "WbioSrvc",         # Windows Biometric Service
        "MapsBroker",       # Downloaded Maps Manager
        "CscService",       # Offline Files
        "RasMan",           # Remote Access Connection Manager
        "RemoteAccess",     # Routing and Remote Access
        "RetailDemo",       # Retail Demo Service
        "diagnosticshub.standardcollector.service", # Diagnostics Hub
        "DiagTrack",        # Connected User Experiences & Telemetry
        "dmwappushservice", # Device Management Wireless Application Protocol
        "DoSvc", # Delivery Optimization
        "lfsvc" # Geolocation
    )

foreach ($s in $services) {
    Write-Host "==> Disabling service: $s" -ForegroundColor Cyan
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
    }

    Write-Host "==> Services disabled!" -ForegroundColor Green
}
