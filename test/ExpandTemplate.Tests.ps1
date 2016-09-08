$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

Describe "Expand-Template" {

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
        Expand-Template '$Greeting $Target' -Greeting Hello -Target World -OutFile "TestDrive:\Result"
        Get-Content "TestDrive:\Result" | Should Be "Hello World"
    }

    It "Should use template file when -Path is specified" {
        '$Greeting $Target' | Out-File "TestDrive:\Template" -NoNewline
        Expand-Template -Path "TestDrive:\Template" -Greeting "Gracias" -Target "Amigo" | Should Be "Gracias Amigo"
    }
}
