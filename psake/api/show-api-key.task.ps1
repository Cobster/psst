Task ShowApiKey -requiredVariables SettingsPath {
    $OFS = ""
    if ($NuGetApiKey) {
        "The embedded (partial) NuGetApiKey is: $($NuGetApiKey[0..7])"
    }
    elseif ($NuGetApiKey = GetSetting -Path $SettingsPath -Key NuGetApiKey) {
        "The stored (partial) NuGetApiKey is: $($NuGetApiKey[0..7])"
    }
    else {
        "The NuGetApiKey has not been provided or stored."
        return
    }

    "To see the full key, use the task 'ShowFullApiKey'"
}