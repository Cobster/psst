function Expand-TemplateDirectory
{
    [CmdletBinding()]
    param (
        [string] $InputPath,
        [string] $OutputPath = $PWD,
        [string[]] $Exclude,
        [hashtable] $Model    
    )

    Write-Verbose "Expanding $InputPath to $OutputPath"

    $Exclude | ForEach-Object { Write-Verbose "Excluding: $_" }

    # Expand all the files
    Get-ChildItem -Path $InputPath -File | ForEach-Object {

        if (-not ($Exclude -contains $_.FullName)) {
            # Expand the file name
            $FileName = Expand-Template -Template $_.Name -Model $Model
            $FilePath = "$OutputPath\$FileName"

            Write-Verbose "Expanding $($_.FullName) to $FilePath"

            # Expand the file contents
            Expand-Template -InputFile $_.FullName -OutputFile $FilePath -Model $Model
        }
    }

    # Expand all the subdirectories
    Get-ChildItem -Path $InputPath -Directory | ForEach-Object {

        # Expand the directory name
        $DirectoryName = Expand-Template -Template $_.Name -Model $Model
        $DirectoryPath = "$OutputPath\$DirectoryName"
        
        Write-Verbose "Creating $DirectoryPath"
        New-Item $DirectoryPath -ItemType Directory -Force | Out-Null  

        # Expand the directory
        Expand-TemplateDirectory -InputPath $_.FullName -OutputPath $DirectoryPath -Model $Model -Exclude $Exclude
    } 
}