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
        [string] $Name,

        [string] $OutputPath = $PWD,

        [string] $Version = '0.0.0'
    )

    $TemplateDir = "$PSScriptRoot\PsstGeneratorModule"
    
    # Resolve the specified output path and create it if necessary
    $OutputPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
    if (-not (Test-Path $OutputPath)) {
        New-Item $OutputPath -ItemType Directory -Force
    }

    # Build the model
    $Model = @{
        Name = (Get-NamingConventions $Name)
        TemplateDir = $TemplateDir
        Version = $Version
        Tests = "Tests"
        FullName = (Get-NamingConventions "Psst.$Name")
    }

    # A list of paths in the template directory which will not be expanded.
    $Exclude = @()

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes
 
}