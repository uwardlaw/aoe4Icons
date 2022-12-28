$aoeCivImgUrls = @{}

$iconHtmlDir = $PSScriptRoot + "\buildMenus"
Get-ChildItem -Path $iconHtmlDir | Foreach-Object {
    $civName = $_.name.substring(0,$_.name.LastIndexOf('.'))
    $urlList = [System.Collections.Arraylist]::new()

    $(Get-Content $_.FullName) -split '"' | select-string -pattern 'img/' | ForEach-Object{
            $urlList.Add($_.ToString()) | out-null
    }

    $aoeCivImgUrls.Add($civName, $urlList)
}

$shared = [System.Collections.Arraylist]::new()

<#
$startList = @() + $aoeCivImgUrls[$civName] 
$startList | ForEach-Object {
    $inShared = $false
    $url = $_

    #write-host Checking $url

    $aoeCivImgUrls.GetEnumerator() | ForEach-Object {
        if ($_.Key -eq $civName){
            #write-host Skipping $civName
            return
        }
        if ($url -in $_.Value){
            #write-host $_.Key.ToString() has $url
            $_.Value.Remove($url)
            if(!$shared.Contains($url)){
                $shared.Add($url.ToString()) | out-null
                $inShared = $true
            }
        }
    }

    if($inShared){
        $aoeCivImgUrls[$civName].Remove($url)
    }
}

$aoeCivImgUrls['shared'] = $shared

#>

<#
$aoeCivImgUrls.GetEnumerator() | ForEach-Object {
    $path = ($PSScriptRoot + '\' + $_.Key + '_urls.txt')
    $_.Key | Out-File -FilePath $path
    $_.Value | Get-Unique | Sort-Object | Add-Content -Path $path
}

#>
$null = New-Item  ".\icons" -Type Directory -Force -ea 0

$aoeCivImgUrls.GetEnumerator() | ForEach-Object {
    $path = ('.\icons\' + $_.Key + '\')
    $null = New-Item  $path -Type Directory -Force -ea 0
    $_.Value | Get-Unique | ForEach-Object{
        $filename = $_.Split('/')[1]
        Invoke-WebRequest ('https://age4builder.com/' + $_) -OutFile ($path + $_.Split('/')[1])
    }
}


