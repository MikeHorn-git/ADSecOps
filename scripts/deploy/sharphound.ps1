$ZipPath = "C:\SharpHound.zip"
$ExtractPath = "C:\SharpHound"

Invoke-WebRequest -Uri "https://github.com/BloodHoundAD/SharpHound/releases/download/v2.4.1/SharpHound-v2.4.1.zip" -OutFile $ZipPath

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($ZipPath, $ExtractPath)

Remove-Item -Path $ZipPath -Force

Set-Location $ExtractPath
./SharpHound.exe --CollectionMethods All
