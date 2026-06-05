function Start-AppInstallation {

    $selected = $script:PSBoundParameters
    $installOrder = $packages["Order"]

    if ($selected.ContainsKey("All")) {

        foreach ($group in $installOrder) {
            Install-PackageGroup -GroupName $group
        }

        return
    }

    foreach ($group in $installOrder) {

        if ($selected.ContainsKey($group)) {
            Install-PackageGroup -GroupName $group
        }
    }
}
