$ZipPath = "C:\PingCastle.zip"
$ExtractPath = "C:\PingCastle"

Invoke-WebRequest -Uri "https://github.com/vletoux/pingcastle/releases/download/3.2.0.1/PingCastle_3.2.0.1.zip" -OutFile $ZipPath

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($ZipPath, $ExtractPath)

Remove-Item -Path $ZipPath -Force
