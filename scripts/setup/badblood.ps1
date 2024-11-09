$ZipPath = "C:\BadBlood.zip"
$ExtractPath = "C:\BadBlood"
$MasterPath = "C:\BadBlood\BadBlood-master"

Invoke-WebRequest -Uri "https://github.com/davidprowe/BadBlood/archive/master.zip" -OutFile $ZipPath

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($ZipPath, $ExtractPath)

Remove-Item -Path $ZipPath -Force

Set-Location $MasterPath
.\Invoke-BadBlood.ps1 -NonInteractive
