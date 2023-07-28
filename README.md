### Robert Chaves Perez (r0b0t95) 2023

**the script should work as expected, allowing you to download files of types .png, .jpg, and .gif using the provided methods**

```powershell
.\DownLoadFile.ps1 -url 'url/fileName.png' -file newFileName.png 
```

```powershell
.\DownLoadFile.ps1 -url 'url/fileName.jpg' -file newFileName.jpg 
```

```powershell
<#
 Robert Chaves Perez (r0b0t95) 2023

 use from C:\Windows\System32
 and you can access from any directory
#>

param(
    [string]$url,
    [string]$file
)

if(-Not [string]::IsNullOrEmpty($url) -and -Not [string]::IsNullOrEmpty($file)){

    $path = 'C:\Users\Public\' + $file

    Invoke-WebRequest -Uri $url -Outfile $path 

    Write-Host "[+] File downloaded successfully..."

}else{

    Write-Host "[-] Error... \n please insert 2 arguments :("

}
```
