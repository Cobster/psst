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

    It "should create a new $($Model.Name)" {
        New-$($Model.Name.UpperCamelCase) 
        "`$TestDirectory\$($Model.Name)" | Should Exist
    }
}
