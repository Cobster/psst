# Load the Psst module
if (-not (Get-Module -Name Psst -ErrorAction SilentlyContinue)) {
    Import-Module Psst
}


Describe "$($Model.FullName) Build" {

    It "Should create a powershell module that can be imported" {
        Invoke-psake -taskList build -parameters @{Version="0.0.0.0"}
        Import-Module "`$PSScriptRoot\release\$($Model.FullName)"
        (Get-Module -Name $($Model.FullName)) -ne `$null | Should Be `$true
    }

}