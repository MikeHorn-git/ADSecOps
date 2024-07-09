$ExtractPath = "C:\PingCastle"

Set-Location $ExtractPath
.\PingCastle.exe --healthcheck --server adsecops.local --log
