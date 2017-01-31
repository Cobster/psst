$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Import-Module $here\Psst.psd1

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

    It "Files in the Exclude list should not be expanded" {
        New-Item "$TestDirectory\Templates" -ItemType Directory
        Add-Content -Path "$TestDirectory\Templates\message.txt" -Value '$($Model.Message)' -Force

        $Model = @{
            Message = "Should not see this"
        }

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model $Model -Exclude "message.txt"

        "$TestDirectory\message.txt" | Should Not Exist
    }

    It "Files in the subfolder and excluded should not be expanded" {
        New-Item "$TestDirectory\Templates" -ItemType Directory
        New-Item "$TestDirectory\Templates\Sub" -ItemType Directory
        Add-Content -Path "$TestDirectory\Templates\Sub\message.txt" -Value '$($Model.Message)' -Force

        $Model = @{
            Message = "Should not see this"
        }

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model $Model -Exclude "$TestDirectory\Templates\sub\message.txt"

        "$TestDirectory\sub\message.txt" | Should Not Exist
    }

    It "Should extract the template from a zip archive if directory does not exist" {
        New-Item "$TestDirectory\Templates" -ItemType Directory
        Add-Content -Path "$TestDirectory\Templates\message.txt" -Value '$($Model.Message)' -Force
        Compress-Archive "$TestDirectory\Templates" -DestinationPath "$TestDirectory\Templates.zip"
        Remove-Item "$TestDirectory\Templates" -Recurse -Force

        $Model = @{
            Message = "Should see this"
        }

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model $Model

        "$TestDirectory\message.txt" | Should Exist
        "$TestDirectory\message.txt" | Should Contain "Should see this"

    }

    It "Should url decode template file and directory names before expanding" {

        New-Item "$TestDirectory\Templates" -ItemType Directory
        New-Item "$TestDirectory\Templates\%24(%24Model.DirName)\%24(%24Model.FileName)" -ItemType File -Force

        $Model = @{
            DirName = "Bar"
            FileName = "Woot.txt"
        }

        Expand-TemplateDirectory -InputPath "$TestDirectory\Templates" -Model $Model

        "$TestDirectory\Bar\Woot.txt" | Should Exist

    }
}