function New-PsstGeneratorModule 
{
<#

.SYNOPSIS
    Scaffolds the code files needed to create a PsstGeneratorModule generator. 

.DESCRIPTION
    
.PARAMETER OutputPath
    The optional output directory where the new PsstGeneratorModule generator will be located.

#>

    [CmdletBinding()]
    param (
        [System.Management.Automation.PathInfo] $OutputPath = $PWD
    )

    $TemplateDir = "$PSScriptRoot\PsstGeneratorModule"

    # Build the model
    $Model = @{
        # Name = (Get-NamingConventions $Name)
        TemplateDir = $TemplateDir
        
        # todo: New-PsstGenerator needs to compute the current module
        # Psst is content of 'Psst.psd1' it is defined a varaible by Psst.psm1
        # Module = (Import-PowerShellDataFile "C:\projects\Psst\psst\src\psst.psd1") 
    }

    # A list of paths in the template directory which will not be expanded.
    $Exclude = @()

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes 
 
}