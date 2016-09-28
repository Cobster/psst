$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Import-Module $here\Psst.psd1

Describe "Expand-Template" {

    $TestDirectory = [IO.Path]::Combine([IO.Path]::GetTempPath(), [IO.Path]::GetRandomFileName())

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should replace an unbound parameter" {
        Expand-Template '$Foo' -Foo "Bar" | Should Be "Bar"
    }

    It "Should replace multiple unbound parameters" {
        Expand-Template '$Greeting $Target' -Greeting Hello -Target World | Should Be "Hello World"
    }

    It "Should replace expressions" {
        $Data = @{ FirstName = "Santa"; LastName = "Claus" }
        Expand-Template 'Hello $($Person.FirstName) $($Person.LastName)' -Person $Data | Should Be "Hello Santa Claus" 
    }

    It "Should write result to file when -OutputFile is specified" {
        Expand-Template '$Greeting $Target' -Greeting Hello -Target World -OutputFile "$TestDirectory\Result"
        Get-Content "$TestDirectory\Result" | Should Be "Hello World"
    }

    It "Should use template file when -InputFile is specified" {
        '$Greeting $Target' | Out-File "TestDrive:\Template" -NoNewline
        Expand-Template -InputFile "TestDrive:\Template" -Greeting "Gracias" -Target "Amigo" | Should Be "Gracias Amigo"
    }
}
