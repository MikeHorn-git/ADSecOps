Import-Module PSPKi

$caName = "adsecops-DC-CA"
$userGroup = "Users"
$targetTemplateName = "WebServer"

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

# Ensure the template includes Client Authentication EKU
if (-not ($template.ExtendedKeyUsage -contains "Client Authentication")) {
    $template.ExtendedKeyUsage += "Client Authentication"
    Set-Object -InputObject $template
}

# Enable Enrollee Supplies Subject
if (-not ($template.RequestAttributes -contains "ENROLLEE_SUPPLIES_SUBJECT")) {
    $template.RequestAttributes += "ENROLLEE_SUPPLIES_SUBJECT"
    Set-Object -InputObject $template
}

# Disable Manager Approval (assuming it's enabled)
if ($template.RequiresManagerApproval) {
    $template.RequiresManagerApproval = $false
    Set-Object -InputObject $template
}
