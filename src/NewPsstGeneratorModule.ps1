function New-PsstGeneratorModule 
{
<#

.SYNOPSIS
    Scaffolds the code files needed to create a PsstGeneratorModule generator. 

.DESCRIPTION
    This function scaffolds out a new Psst Generator project. 
    
.PARAMETER OutputPath
    The optional output directory where the new PsstGeneratorModule generator will be located.

.PARAMETER Name
    The name of the brand new Psst generator module.
#>

    [CmdletBinding()]
    param (
        [System.Management.Automation.PathInfo] $OutputPath = $PWD,

        [string] $Name,

        [string] $GitRepository, 

        [string] $Version = '1.0.0'
    )

    $TemplateDir = "$PSScriptRoot\PsstGeneratorModule"
    
    # Build the model
    $Model = @{
        Name = (Get-NamingConventions $Name)
        TemplateDir = $TemplateDir
        Version = $Version
        Module = $ModuleData
    }

    # A list of paths in the template directory which will not be expanded.
    $Exclude = @()

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes 
 
}