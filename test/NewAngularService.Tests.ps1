$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

. "$src\ExpandTemplate.ps1"
. "$src\ConvertToKebabCase.ps1"
. "$src\GetNamingConventions.ps1"
. "$src\NewAngularImport.ps1"

Describe "New-AngularService" {
    $TestDirectory = "TestDrive:\Test"

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should create a new service file" {
        New-AngularService -Name Item
        "$TestDirectory\item.service.ts" | Should Exist
    }

    It "Should create a new service test file" {
        New-AngularService -Name Item
        "$TestDirectory\item.service.spec.ts" | Should Exist
    }

    It "Should import the Http service when -Http is specified" {
        New-AngularService -Name Item -Http
        "$TestDirectory\item.service.ts" | Should Contain "import \{.*Http.*\} from \'@angular\/http\';" 
    }

    It "Should constructor inject Http as a private service when -Http is specified" {
        New-AngularService -Name Item -Http
        $Result = Get-Content "$TestDirectory\item.service.ts" -Raw
        [Text.RegularExpressions.Regex]::IsMatch($Result, "constructor\(.*private http\: Http.*\)", "Singleline") | Should Be True
    }
}