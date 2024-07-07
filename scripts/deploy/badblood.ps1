$badBloodZipPath = "C:\BadBlood.zip"
$badBloodExtractPath = "C:\BadBlood"
$badBloodMasterPath = "C:\BadBlood\BadBlood-master"

Invoke-WebRequest -Uri "https://github.com/davidprowe/BadBlood/archive/master.zip" -OutFile $badBloodZipPath

Add-Type -AssemblyName System.IO.Compression.FileSystem -Verbose
[System.IO.Compression.ZipFile]::ExtractToDirectory($badBloodZipPath, $badBloodExtractPath)

Remove-Item -Path $badBloodZipPath -Force -Verbose

Set-Location $badBloodMasterPath -Verbose
.\Invoke-BadBlood.ps1 -NonInteractive
