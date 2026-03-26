param(
    [Parameter(Mandatory=$true)][string]$Source,
    [Parameter(Mandatory=$true)][string]$Destination
)

if ($Source -notmatch "practice-01-scripts" -or $Destination -notmatch "practice-01-scripts") {
    [Console]::Error.WriteLine("Error: Paths must be within the practice-01-scripts directory.")
    exit 1
}

if (-not (Test-Path $Source -PathType Container)) {
    [Console]::Error.WriteLine("Error: Source directory does not exist.")
    exit 1
}

if (-not (Test-Path $Destination)) {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
}

$sourceDirName = (Get-Item $Source).Name
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"
$archiveName = "${sourceDirName}__arch_${timestamp}.zip"
$archivePath = Join-Path $Destination $archiveName

Compress-Archive -Path "$Source\*" -DestinationPath $archivePath -Force

$archiveSize = (Get-Item $archivePath).Length / 1KB

Write-Host "Archive successfully created: $archivePath" -ForegroundColor Green
Write-Host "Archive size: $([math]::Round($archiveSize, 2)) KB" -ForegroundColor Cyan

