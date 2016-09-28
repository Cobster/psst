function New-$($Model.Name.UpperCamelCase) 
{
<#

.SYNOPSIS
    Scaffolds the code files needed to create a $($Model.Name) generator. 

.DESCRIPTION
    
.PARAMETER OutputPath
    The optional output directory where the new $($Model.Name) generator will be located.

#>

    [CmdletBinding()]
    param (
        [System.Management.Automation.PathInfo] `$OutputPath = `$PWD
    )

    `$TemplateDir = "`$PSScriptRoot\$($Model.Name)"

    # Build the model
    `$Model = @{
        # Name = (Get-NamingConventions `$Name)
        TemplateDir = `$TemplateDir

        # Uncomment to add the data in the module to the model        
        # Module = `$ModuleData 
    }

    # A list of paths in the template directory which will not be expanded.
    `$Exclude = @()

    Expand-TemplateDirectory -InputPath `$TemplateDir -OutputPath `$OutputPath -Model `$Model -Exclude `$Excludes 
 
}