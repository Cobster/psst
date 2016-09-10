<#

.SYNOPSIS

Expands a template string with dynamically defined arguments.

.DESCRIPTION

The Expand-Template function uses PowerShell's built in string expansion functionality to populate the values of a 
parameterized string.  This can be a string literal that is passed to the function, or the contents of an input file.

.PARAMETER Template

The template that will be expanded.  This must be string literal so PowerShell does not preemptively expand the string. 

.PARAMETER InputFile

An optional input file that contains the template.

.PARAMETER OutputFile

Ann optional output file path. When specified the expanded template will be written to this file.

#>
function Expand-Template
{
    # IMPORTANT!
    # Do not mark this function with [CmdletBinding] or mark any parameters with [Parameter]
    # Doing so will break the dynamism of the unbound arguments.  PowerShell gets angry and
    # throws exceptions because the unbound arguments exist.

    param (
        [string] $Template,
        [string] $InputFile,
        [string] $OutputFile
    )

    if ([string]::IsNullOrEmpty($Template)) {
        $Template = Get-Content -Path $InputFile -Raw
    }

    # IMPORTANT! 
    # All variables except $Template are purposefully prefixed with double underscores
    # to prevent naming collisions with replacement variables in the value of $Template.

    $__argc = $MyInvocation.UnboundArguments.Count
    for ($__i = 0; $__i -lt $__argc; $__i++) {
        $__arg = [string]($MyInvocation.UnboundArguments[$__i])

        # Variables have a leading dash
        if ($__arg.StartsWith('-')) {
            # Remove the leading dash
            $__arg = $__arg.Substring(1)
            # Get the next argument which is the value for __arg
            $__argv = $MyInvocation.UnboundArguments[$__i+1]
            # Create a new local variable
            New-Variable -Name $__arg -Value $__argv
            # Increment loop counter past the arg value 
            $__i++
        }
    }

    # Expand the variables in the template and return it to the caller.
    $Artifact = $ExecutionContext.InvokeCommand.ExpandString($Template)

    if (-not [string]::IsNullOrEmpty($OutputFile)) {
        $Artifact | Out-File -FilePath $OutputFile -NoNewline
    }
    else {
        $Artifact
    }
}