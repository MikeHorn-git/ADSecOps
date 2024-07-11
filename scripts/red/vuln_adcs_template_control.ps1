# Ensure the necessary module is imported
Import-Module PSPKi

# Define the Certification Authority and the group or user to add enrollment rights for
$caName = "adsecops-DC-CA" # Replace with your CA name
$userGroup = "Users" # Replace with the user group to add
$targetTemplateName = "DirectoryEmailReplication" # Replace with the template name you want to modify

# Get the Certification Authority object
$ca = Get-CertificationAuthority -Name $caName

# Get the certificate template to modify
$template = Get-CertificateTemplate -Name $targetTemplateName

# Ensure the user group has enrollment rights
$securityDescriptor = $template.SecurityDescriptor

# Convert group to NTAccount
$identityReference = New-Object System.Security.Principal.NTAccount($userGroup)
# Define ActiveDirectoryRights for Enrollment
$adRights = [System.DirectoryServices.ActiveDirectoryRights]"ReadProperty, WriteProperty"
# Define AccessControlType
$accessControlType = [System.Security.AccessControl.AccessControlType]::Allow

# Create a new access rule for the user group
$accessRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule(
    $identityReference,
    $adRights,
    $accessControlType
)

# Add the access rule to the security descriptor
$securityDescriptor.AddAccessRule($accessRule)
$template.SecurityDescriptor = $securityDescriptor

# Save the updated template
Set-Object -InputObject $template

Write-Output "Enrollment rights updated for template: $($template.DisplayName)"

# Ensure the template includes Client Authentication EKU
if (-not ($template.ExtendedKeyUsage -contains "Client Authentication")) {
    $template.ExtendedKeyUsage += "Client Authentication"
    Set-Object -InputObject $template
    Write-Output "Client Authentication EKU added to template: $($template.DisplayName)"
}

# Enable Enrollee Supplies Subject
if (-not ($template.RequestAttributes -contains "ENROLLEE_SUPPLIES_SUBJECT")) {
    $template.RequestAttributes += "ENROLLEE_SUPPLIES_SUBJECT"
    Set-Object -InputObject $template
    Write-Output "Enrollee Supplies Subject enabled for template: $($template.DisplayName)"
}

# Disable Manager Approval (assuming it's enabled)
if ($template.RequiresManagerApproval) {
    $template.RequiresManagerApproval = $false
    Set-Object -InputObject $template
    Write-Output "Manager Approval disabled for template: $($template.DisplayName)"
}
