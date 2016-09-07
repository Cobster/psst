$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$src\$sut"

Describe "Expand-Template" {

    It "should replace an unbound parameter" {
        Expand-Template '$Foo' -Foo "Bar" | Should Be "Bar"
    }

    It "should replace multiple unbound parameters" {
        Expand-Template '$Greeting $Target' -Greeting Hello -Target World | Should Be "Hello World"
    }
}
