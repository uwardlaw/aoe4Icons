
$iconHtmlDir = $PSScriptRoot + "\buildMenus"
Get-ChildItem -Path $iconHtmlDir |
    Foreach-Object {
        $(Get-Content $_.FullName) -split '"' | select-string -pattern 'img/' |
            ForEach-Object{
                $imgString.Add($_)
            }
    }

$imgString | Sort-Object -Unique |
    FoeachObject {
        $uniqueImgString.Add(
    }

$null = New-Item  ".\icons" -Type Directory -Force -ea 0


