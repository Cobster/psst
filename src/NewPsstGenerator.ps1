
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
        [string] $TemplatePath,
        [string] $OutputPath = $PWD
    )

    $TemplateDir = "$PSScriptRoot\PsstGenerator"

    # Resolve the specified output path and create it if necessary
    $OutputPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
    if (-not (Test-Path $OutputPath)) {
        New-Item $OutputPath -ItemType Directory -Force
    }

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
    $Excludes += '$($Model.Name)\.exclude'

    Expand-TemplateDirectory -InputPath $TemplateDir -OutputPath $OutputPath -Model $Model -Exclude $Excludes 

    if (-not ([string]::IsNullOrWhiteSpace($TemplatePath)) -and (Test-Path -Path $TemplatePath))
    {
        Write-Verbose "Copying template from $TemplatePath"
        Get-ChildItem -Path $TemplatePath | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination "$OutputPath\$($Model.Name)" -Recurse
        }

        Get-ChildItem -Path "$OutputPath\$($Model.Name)" -File -Recurse | ForEach-Object {
            (Get-Content $_.FullName -Raw) -replace '\$', '`$' | Set-Content $_.FullName
        }
    }
}