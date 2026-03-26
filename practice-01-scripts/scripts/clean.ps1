param(
    [string]$TargetDir,
    [switch]$DryRun
)

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $TargetDir = Read-Host "Please enter the target directory to clean"
    $dryRunChoice = Read-Host "Do you want to enable Dry-Run mode to only preview files? (y/n)"
    if ($dryRunChoice -match "^[Yy]") {
        $DryRun = $true
    }
}

if ([string]::IsNullOrWhiteSpace($TargetDir) -or $TargetDir -match "^[a-zA-Z]:\\?$" -or $TargetDir -eq "/" -or $TargetDir -eq "\") {
    [Console]::Error.WriteLine("Error: Critical danger. Attempted to clean a root directory!")
    exit 1
}

if ($TargetDir -notmatch "practice-01-scripts") {
    [Console]::Error.WriteLine("Error: Cleanup is only allowed within the practice-01-scripts directory.")
    exit 1
}

if (-not (Test-Path $TargetDir -PathType Container)) {
    [Console]::Error.WriteLine("Error: Target directory does not exist.")
    exit 1
}

$filesToDelete = @(Get-ChildItem -Path $TargetDir -Include *.tmp, *.bak, *.cache -Recurse -File)

if ($DryRun) {
    Write-Host "[DRY-RUN] Files that WOULD BE deleted:" -ForegroundColor Yellow
} else {
    Write-Host "Deleted files:" -ForegroundColor Green
    if ($filesToDelete.Count -gt 0) {
        $filesToDelete | Remove-Item -Force
    }
}

$filesToDelete | ForEach-Object { Write-Host $_.FullName }
Write-Host "Total files: $($filesToDelete.Count)" -ForegroundColor Cyan

