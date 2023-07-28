
param(
    [string]$url,
    [string]$file
)

if(-Not [string]::IsNullOrEmpty($url) -and -Not [string]::IsNullOrEmpty($file)){

    $path = 'C:\Users\Public\' + $file

    Invoke-WebRequest -Uri $url -Outfile $path 

    Write-Host "[+] Exit..."

}else{

    Write-Host "[-] Error... \n please insert 2 arguments :("

}