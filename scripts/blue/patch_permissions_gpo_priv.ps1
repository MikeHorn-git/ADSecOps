Import-Module ActiveDirectory
Import-Module GroupPolicy

$gpoName = "VulnGPO"

# Define test users
$restrictedPermissions = @(
    @{Name="GpoEditUser"; Permission="GpoRead"},              # Restricting to read-only
    @{Name="GpoFullControlUser"; Permission="GpoRead"},       # Restricting to read-only
    @{Name="GpoReadApplyUser"; Permission="GpoRead,GpoApply"} # Keeping the same as needed
)

# Apply restrict permissions to test users
foreach ($user in $restrictedPermissions) {
    $permissions = $user.Permission -split ","
    foreach ($permission in $permissions) {
        Set-GPPermission -Name $gpoName -TargetName $user.Name -TargetType User -PermissionLevel $permission
    }
}
