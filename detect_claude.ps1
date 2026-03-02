#detect_claude.ps1
try {
  # Detect if Claude is provisioned (preferred for system-wide availability)
  $prov = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like "*Claude*" }
  # Or also check actual installs
  $exists = Get-AppxPackage -AllUsers | Where-Object { $_.Name -like "*Claude*" }

  if ($prov -or $exists) {
    Write-Host "Claude provisioned/installed"
    exit 0
  } else {
    Write-Host "Claude not present"
    exit 1
  }
} catch {
  Write-Host "ERROR: Detection failed: $_"
  exit 1
}