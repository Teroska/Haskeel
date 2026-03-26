param(
    [Parameter(Mandatory=$true)][string]$Source,
    [Parameter(Mandatory=$true)][string]$Destination
)

if ($Source -notmatch "practice-01-scripts" -or $Destination -notmatch "practice-01-scripts") {
    [Console]::Error.WriteLine("Error: Paths must be within the practice-01-scripts directory.")
    exit 1
}

if (-not (Test-Path $Source)) {
    [Console]::Error.WriteLine("Error: Source directory does not exist.")
    exit 1
}

if (-not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
}

$timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"
$targetDir = Join-Path $Destination $timestamp
New-Item -ItemType Directory -Path $targetDir | Out-Null

Copy-Item -Path "$Source\*" -Destination $targetDir -Recurse -Force
$fileCount = (Get-ChildItem -Path $targetDir -Recurse -File).Count

Write-Host "Backup successfully created at: $targetDir" -ForegroundColor Green
Write-Host "Files copied: $fileCount" -ForegroundColor Cyan

