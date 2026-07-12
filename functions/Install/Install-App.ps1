function Install-App {
    param(
        [hashtable]$App
    )

    $options = @(
        "install"
        "--id", $App.Id
        "--exact"
        "--accept-package-agreements"
        "--accept-source-agreements"
    )

    if ($App.ContainsKey("Args")) {
        $options += $App.Args
    }

    winget @options
}
