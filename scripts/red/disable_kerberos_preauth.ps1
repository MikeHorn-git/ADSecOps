Import-Module ActiveDirectory

# Get members of the Administrateurs group
$adminMembers = Get-ADGroupMember -Identity "Administrators" | Where-Object { $_.objectClass -eq "user" }

# Disable Kerberos pre-authentication for each member
foreach ($user in $adminMembers) {
    Set-ADAccountControl -Identity $user.SamAccountName -DoesNotRequirePreAuth $true
}
