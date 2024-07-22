$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$userName = $currentUser.Split("\")[1]

# https://learn.microsoft.com/en-us/windows-server/networking/core-network-guide/cncg/server-certs/install-the-certification-authority
Add-ADGroupMember -Identity "Enterprise Admins" -Members $userName
Add-ADGroupMember -Identity "Domain Admins" -Members $userName

# https://www.powershellgallery.com/packages/PSPKI/4.2.0
Install-Module -Name 'PSPKI' -Force -AllowClobber
