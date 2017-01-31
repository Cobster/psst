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
        [string] `$OutputPath = `$PWD
    )

    `$TemplateDir = "`$PSScriptRoot\$($Model.Name)"

    # Resolve the specified output path and create it if necessary
    `$OutputPath = `$ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(`$OutputPath)
    if (-not (Test-Path `$OutputPath)) {
        New-Item `$OutputPath -ItemType Directory -Force
    }

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