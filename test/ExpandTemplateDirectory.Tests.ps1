$src = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace '\\test', '\\src' 
Import-Module $src\Psst.psd1

Describe "Expand-TemplateDirectory" {
    $TestDirectory = [IO.Path]::Combine([IO.Path]::GetTempPath(), [IO.Path]::GetRandomFileName())

    BeforeEach {
        New-Item $TestDirectory -ItemType Directory
        Push-Location $TestDirectory
    }

    AfterEach {
        Pop-Location
        Remove-Item $TestDirectory -Force -Recurse
    }

    It "Should expand the template file in the supplied path" {
        New-Item "$TestDirectory\Templates" -ItemType Directory
        Add-Content -Path "$TestDirectory\Templates\message.txt" -Value '$($Model.Message)' -Force
        
        $Model = @{
            Message = "Hello World"
        }

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model $Model 

        "$TestDirectory\message.txt" | Should Exist  
    }

    It "Should expand the contents of the template file" {
        New-Item "$TestDirectory\Templates" -ItemType Directory
        Add-Content -Path "$TestDirectory\Templates\message.txt" -Value '$($Model.Message)' -Force
        
        $Model = @{
            Message = "Hello World"
        }

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model $Model 

        "$TestDirectory\message.txt" | Should Contain "Hello World"  
    }

    It "Should expand the name of the template file" {
        New-Item "$TestDirectory\Templates" -ItemType Directory
        Add-Content -Path "$TestDirectory\Templates\`$(`$Model.Name).txt" -Value '$($Model.Message)' -Force

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model @{ Name = "custom"; Message = "Hello Custom" }

        "$TestDirectory\custom.txt" | Should Exist
    }


}