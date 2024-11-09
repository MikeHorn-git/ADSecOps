$ExtractPath = "C:\AdRecon\"

New-Item -Path $ExtractPath -ItemType Directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/adrecon/ADRecon/master/ADRecon.ps1" -OutFile $ExtractPath\AdRecon.ps1
