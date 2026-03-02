# install_claude.ps1
param(
  [string]$PackagePath = "$PSScriptRoot\Claude.msix"
)

# Step 1 — Enable Virtual Machine Platform if not already active
$vmp = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
if ($vmp.State -ne "Enabled") {
  Write-Host "Enabling Virtual Machine Platform..."
  Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
  Write-Host "VMP enabled. A reboot is required for Cowork to function."
} else {
  Write-Host "Virtual Machine Platform already enabled."
}

# Step 2 — Provision Claude system-wide
Write-Host "Provisioning Claude..."
try {
  Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath $PackagePath -Regions "All" -Verbose
  Write-Host "Claude provisioned successfully."
  exit 0
} catch {
  Write-Host "ERROR: Failed to provision Claude: $_"
  exit 1
}