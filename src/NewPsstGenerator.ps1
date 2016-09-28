
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
        [System.Management.Automation.PathInfo] $OutputPath = $PWD
    )

    $TemplateDir = "$PSScriptRoot\generator"

    # Build the model
    $Model = @{
        Name = (Get-NamingConventions $Name)
        TemplateDir = $TemplateDir
        # Psst is content of 'Psst.psd1' it is defined a varaible by Psst.psm1
        Module = (Import-PowerShellDataFile "$PSScriptRoot\psst.psd1") 
    }

    # A list of paths in the template directory which will not be expanded.
    $Exclude = @()

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes 
    

}