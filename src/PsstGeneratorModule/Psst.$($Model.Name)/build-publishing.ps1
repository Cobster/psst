function PromptUserForCredentialAndStorePassword {
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        `$DestinationPath,

        [Parameter(Mandatory)]
        [string]
        `$Message,

        [Parameter(Mandatory, ParameterSetName = 'SaveSetting')]
        [string]
        `$Key
    )

    `$cred = Get-Credential -Message `$Message -UserName "ignored" 
    if (`$DestinationPath) {
        SetSetting -Key `$Key -Value `$cred.Password -Path `$DestinationPath
    }
}

Task RemoveApiKey -requiredVariables SettingsPath {
    if (GetSetting -Path `$SettingsPath -Key NuGetApiKey) {
        RemoveSetting -Path `$SettingsPath -Key NuGetApiKey
    }
}

Task StoreApiKey -requiredVariables SettingsPath {
    `$promptForKeyCredParams = @{
        DestinationPath = `$SettingsPath
        Message         = 'Enter your NuGet API key in the password field'
        Key             = 'NuGetApiKey'
    }

    PromptUserForCredentialAndStorePassword @promptForKeyCredParams
    "The NuGetApiKey has been stored in `$SettingsPath"
}

Task ShowApiKey -requiredVariables SettingsPath {
    `$OFS = ""
    if (`$NuGetApiKey) {
        "The embedded (partial) NuGetApiKey is: `$(`$NuGetApiKey[0..7])"
    }
    elseif (`$NuGetApiKey = GetSetting -Path `$SettingsPath -Key NuGetApiKey) {
        "The stored (partial) NuGetApiKey is: `$(`$NuGetApiKey[0..7])"
    }
    else {
        "The NuGetApiKey has not been provided or stored."
        return
    }

    "To see the full key, use the task 'ShowFullApiKey'"
}

Task ShowFullApiKey -requiredVariables SettingsPath {
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

function AddSetting {
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSShouldProcess', '', Scope='Function')]
    param(
        [Parameter(Mandatory)]
        [string]`$Key,

        [Parameter(Mandatory)]
        [string]`$Path,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [object]`$Value
    )

    switch (`$type = `$Value.GetType().Name) {
        'securestring' { `$setting = `$Value | ConvertFrom-SecureString }
        default        { `$setting = `$Value }
    }

    if (Test-Path -LiteralPath `$Path) {
        `$storedSettings = Import-Clixml -Path `$Path
        `$storedSettings.Add(`$Key, @(`$type, `$setting))
        `$storedSettings | Export-Clixml -Path `$Path
    }
    else {
        `$parentDir = Split-Path -Path `$Path -Parent
        if (!(Test-Path -LiteralPath `$parentDir)) {
            New-Item `$parentDir -ItemType Directory > `$null
        }

        @{`$Key = @(`$type, `$setting)} | Export-Clixml -Path `$Path
    }
}

function GetSetting {
    param(
        [Parameter(Mandatory)]
        [string]`$Key,

        [Parameter(Mandatory)]
        [string]`$Path
    )

    if (Test-Path -LiteralPath `$Path) {
        `$securedSettings = Import-Clixml -Path `$Path
        if (`$securedSettings.`$Key) {
            switch (`$securedSettings.`$Key[0]) {
                'securestring' {
                    `$value = `$securedSettings.`$Key[1] | ConvertTo-SecureString
                    `$cred = New-Object -TypeName PSCredential -ArgumentList 'unknown', `$value
                    `$cred.GetNetworkCredential().Password
                }
                default {
                    `$securedSettings.`$Key[1]
                }
            }
        }
    }
}

function SetSetting {
    param(
        [Parameter(Mandatory)]
        [string]`$Key,

        [Parameter(Mandatory)]
        [string]`$Path,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [object]`$Value
    )

    if (GetSetting -Key `$Key -Path `$Path) {
        RemoveSetting -Key `$Key -Path `$Path
    }

    AddSetting -Key `$Key -Value `$Value -Path `$Path
}

function RemoveSetting {
    param(
        [Parameter(Mandatory)]
        [string]`$Key,

        [Parameter(Mandatory)]
        [string]`$Path
    )

    if (Test-Path -LiteralPath `$Path) {
        `$storedSettings = Import-Clixml -Path `$Path
        `$storedSettings.Remove(`$Key)
        if (`$storedSettings.Count -eq 0) {
            Remove-Item -Path `$Path
        }
        else {
            `$storedSettings | Export-Clixml -Path `$Path
        }
    }
    else {
        Write-Warning "The build setting file '`$Path' has not been created yet."
    }
}