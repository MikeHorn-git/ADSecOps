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

# Disable manager approval (ESC1) if it's enabled
if ($template.PSObject.Properties.Match("RequiresManagerApproval")) {
    if ($template.RequiresManagerApproval) {
        $template.RequiresManagerApproval = $false
        Set-CATemplate -InputObject $template
        Write-Output "RequiresManagerApproval has been set to false."
    } else {
        Write-Output "RequiresManagerApproval is already false. No changes needed."
    }
} else {
    Write-Error "RequiresManagerApproval property not found on the template."
}
