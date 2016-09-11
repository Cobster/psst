$([String]::Join("`r`n", $Model.Imports))

@NgModule({
    $(New-Metadata -Metadata declarations -Model $Model.Metadata.Declarations),
    $(New-Metadata -Metadata exports -Model $Model.Metadata.Exports),
    $(New-Metadata -Metadata imports -Model $Model.Metadata.Imports),
    $(New-Metadata -Metadata providers -Model $Model.Metadata.Providers)
})
export class $($Name)Module { }