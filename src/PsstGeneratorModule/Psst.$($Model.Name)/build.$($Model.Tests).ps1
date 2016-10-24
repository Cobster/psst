Import-Module "Psst"

Describe "$($Model.FullName) Build" {

    It "Should create a powershell module that can be imported" {
        Invoke-psake -taskList build
        Import-Module "`$PSScriptRoot\release\$($Model.FullName)"
        (Get-Module -Name $($Model.FullName)) -ne `$null | Should Be `$true
    }
}