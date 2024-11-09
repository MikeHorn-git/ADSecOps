Import-Module PSPKi

$caName = "adsecops-DC-CA"
$targetTemplateName = "WebServer"

# Retrieve the Certification Authority
$ca = Get-CertificationAuthority -Name $caName
if (-not $ca) {
    Write-Error "Certification Authority '$caName' not found."
    exit
}

# Retrieve the certificate template to modify
$template = Get-CertificateTemplate -Name $targetTemplateName
if (-not $template) {
    Write-Error "Certificate template '$targetTemplateName' not found."
    exit
}

# Check if the template has the RequiresManagerApproval property
$property = $template | Get-Member -Name "RequiresManagerApproval"
if (-not $property) {
    Write-Error "RequiresManagerApproval property not found on the template."
    exit
}

# Enable manager approval (ESC1) if it's disabled
if (-not $template.RequiresManagerApproval) {
    $template.RequiresManagerApproval = $true
    Set-CATemplate -InputObject @($template)
    Write-Output "RequiresManagerApproval has been set to true."
} else {
    Write-Output "RequiresManagerApproval is already true. No changes needed."
}
