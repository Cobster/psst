
function New-PsstGenerator 
{
<#

.SYNOPSIS
    Scaffolds the code files needed to create a Psst generator. 

.DESCRIPTION
    
.PARAMETER Name
    The name of a brand new Psst generator.

.PARAMETER OutputPath
    The output directory where the new Psst generator will be located.

#>
    [CmdletBinding()]
    param (
        [string] $Name,
        [string] $OutputPath = $PWD
    )

    $TemplateDir = "$PSScriptRoot\PsstGenerator"

    # Build the model
    $Model = @{
        Name = (Get-NamingConventions $Name)
        TemplateDir = $TemplateDir
        # Psst is content of 'Psst.psd1' it is defined a varaible by Psst.psm1
        Module = (Import-PowerShellDataFile "$PSScriptRoot\psst.psd1")
        Tests = "Tests" 
    }

    # A list of paths in the template directory which will not be expanded.
    $Excludes = @()
    $Excludes += Join-Path $TemplateDir '$($Model.Name)\.exclude'

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes 
}