Import-Module ActiveDirectory
Import-Module GroupPolicy

$gpoName = "VulnGPO"
$domain = "adsecops.local"
$ouPath = "CN=Users,DC=adsecops,DC=local"

New-GPO -Name $gpoName

# Define test users with multiples permissions
$users = @(
    @{Name="GpoEditUser"; GivenName="Gpo"; Surname="EditUser"; SamAccountName="GpoEditUser"; Permission="GpoEdit"},
    @{Name="GpoFullControlUser"; GivenName="Gpo"; Surname="FullControlUser"; SamAccountName="GpoFullControlUser"; Permission="GpoEditDeleteModifySecurity"},
    @{Name="GpoReadApplyUser"; GivenName="Gpo"; Surname="ReadApplyUser"; SamAccountName="GpoReadApplyUser"; Permission="GpoRead,GpoApply"}
)

foreach ($user in $users) {
    $password = (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force)

    # Create test users
    New-ADUser -Name $user.Name -GivenName $user.GivenName -Surname $user.Surname -SamAccountName $user.SamAccountName -UserPrincipalName "$($user.SamAccountName)@$domain" -Path $ouPath -AccountPassword $password -Enabled $true

    # Apply the specified permissions to the GPO
    # Split the permissions string into an array for multiple permissions (GpoReadApplyUser)
    $permissions = $user.Permission -split ","

    foreach ($permission in $permissions) {
        # Set the GPO permissions for the user
        Set-GPPermission -Name $gpoName -TargetName $user.SamAccountName -TargetType User -PermissionLevel $permission
    }
}
