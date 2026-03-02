#uninstall_claude.ps1
try {
  Write-Host "Removing Claude for all users and de-provisioning"

  # Remove installed instances for all users
  $pkgs = Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*Claude*" }
  foreach ($p in $pkgs) {
    Write-Host "Removing $($p.PackageFullName)"
    Remove-AppxPackage -Package $p.PackageFullName -AllUsers
  }

  # De-provision the package so it won’t be installed for new users
  $prov = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like "*Claude*" }
  foreach ($pp in $prov) {
    Write-Host "Deprovisioning $($pp.DisplayName)"
    Remove-AppxProvisionedPackage -Online -PackageName $pp.PackageName -Verbose
  }

  Write-Host "Claude removed successfully."
  exit 0
} catch {
  Write-Host "ERROR: Uninstall failed: $_"
  exit 1
}