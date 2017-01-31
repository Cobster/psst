Task 'remove-api-key' -requiredVariables SettingsPath {
    if (GetSetting -Path `$SettingsPath -Key NuGetApiKey) {
        RemoveSetting -Path `$SettingsPath -Key NuGetApiKey
    }
}