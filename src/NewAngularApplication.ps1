function New-AngularApplication 
{
    param (
        [string] $Name
    )

    $TemplateDir = "$PSScriptRoot\templates\angular2\app"

    $Model = @{
        Name = (Get-NamingConventions $Name)
    }


    Expand-Template -InputFile "$TemplateDir\tsconfig.json" -OutputFile "$pwd\tsconfig.json" -Model $Model
    Expand-Template -InputFile "$TemplateDir\typings.json" -OutputFile "$pwd\typings.json" -Model $Model
    Expand-Template -InputFile "$TemplateDir\package.json" -OutputFile "$pwd\package.json" -Model $Model
    
    # Testing
    Expand-Template -InputFile "$TemplateDir\karma.conf.js" -OutputFile "$pwd\karma.conf.js" -Model $Model
    Expand-Template -InputFile "$TemplateDir\karma-test-shim.js" -OutputFile "$pwd\karma-test-shim.js" -Model $Model
    
    # Packaging
    Expand-Template -InputFile "$TemplateDir\webpack.config.js" -OutputFile "$pwd\webpack.config.js" -Model $Model
    Expand-Template -InputFile "$TemplateDir\webpack.test.js" -OutputFile "$pwd\webpack.test.js" -Model $Model
    Expand-Template -InputFile "$TemplateDir\webpack.helpers.js" -OutputFile "$pwd\webpack.helpers.js" -Model $Model

    #Documentation
    Expand-Template -InputFile "$TemplateDir\README.md" -OutputFile "$pwd\README.md" -Model $Model
}