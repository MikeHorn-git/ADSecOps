$pingCastleZipPath = "C:\PingCastle.zip"
$pingCastleExtractPath = "C:\PingCastle"

Invoke-WebRequest -Uri "https://github.com/vletoux/pingcastle/releases/download/3.2.0.1/PingCastle_3.2.0.1.zip" -OutFile $pingCastleZipPath

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($pingCastleZipPath, $pingCastleExtractPath)

Remove-Item -Path $pingCastleZipPath -Force

Set-Location $pingCastleExtractPath
.\PingCastle.exe --healthcheck --server adsecops.local --log
