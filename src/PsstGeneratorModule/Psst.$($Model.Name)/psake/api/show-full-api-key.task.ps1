Task 'show-full-api-key' -requiredVariables SettingsPath {
    if (`$NuGetApiKey) {
        "The embedded NuGetApiKey is: `$NuGetApiKey"
    }
    elseif (`$NuGetApiKey = GetSetting -Path `$SettingsPath -Key NuGetApiKey) {
        "The stored NuGetApiKey is: `$NuGetApiKey"
    }
    else {
        "The NuGetApiKey has not been provided or stored."
    }
}