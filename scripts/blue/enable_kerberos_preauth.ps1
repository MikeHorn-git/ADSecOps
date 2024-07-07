Import-Module ActiveDirectory

$users = Get-ADUser -Filter { DoesNotRequirePreAuth -eq $true } -Properties DoesNotRequirePreAuth

foreach ($user in $users) {
    Set-ADAccountControl -Identity $user.SamAccountName -DoesNotRequirePreAuth $false
}

