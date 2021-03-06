`$here = Split-Path -Parent `$MyInvocation.MyCommand.Path
`$sut = (Split-Path -Leaf `$MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "`$here\`$sut"

Describe "New-$($Model.Name.UpperCamelCase)" {
    `$TestDirectory = [IO.Path]::Combine([IO.Path]::GetTempPath(), [IO.Path]::GetRandomFileName())

    BeforeEach {
        New-Item `$TestDirectory -ItemType Directory
        Push-Location `$TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item `$TestDirectory -Force -Recurse
    }

    It "Should be listed in the module data FunctionsToExport property" {
        `$ModulePath = Get-ChildItem "`$here\*.psd1" | Select-Object -First 1
        `$ModuleData = Import-PowerShellDataFile -Path `$ModulePath.FullName
        `$ModuleData.FunctionsToExport[0] -contains 'New-$($Model.Name.UpperCamelCase)' | Should Be $true
    }

    It "Should be dot sourced in the module file" {
        `$ModulePath = Get-ChildItem "`$here\*.psm1" | Select-Object -First 1
        "`$(`$ModulePath.FullName)" | Should Contain "\. \```$PSScriptRoot\\New$($Model.Name.UpperCamelCase)\.ps1"
    }
}
