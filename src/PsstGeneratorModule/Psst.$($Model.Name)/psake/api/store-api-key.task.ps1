Task StoreApiKey -requiredVariables SettingsPath {
    `$promptForKeyCredParams = @{
        DestinationPath = `$SettingsPath
        Message         = 'Enter your NuGet API key in the password field'
        Key             = 'NuGetApiKey'
    }

    PromptUserForCredentialAndStorePassword @promptForKeyCredParams
    "The NuGetApiKey has been stored in `$SettingsPath"
}