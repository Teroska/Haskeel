param(
    [string]$LogPath,
    [string]$Level
)

if ([string]::IsNullOrWhiteSpace($LogPath) -or [string]::IsNullOrWhiteSpace($Level)) {
    if ([string]::IsNullOrWhiteSpace($LogPath)) {
        $LogPath = Read-Host "Please enter the log file path"
    }
    if ([string]::IsNullOrWhiteSpace($Level)) {
        $Level = Read-Host "Please enter the log level (INFO, WARNING, or ERROR)"
    }
}

$Level = $Level.ToUpper().Trim()
if ($Level -notmatch "^(INFO|WARNING|ERROR)$") {
    [Console]::Error.WriteLine("Error: Invalid log level. Must be INFO, WARNING, or ERROR.")
    exit 1
}

if ($LogPath -notmatch "practice-01-scripts") {
    [Console]::Error.WriteLine("Error: Log file must be within the practice-01-scripts directory.")
    exit 1
}

if (-not (Test-Path $LogPath -PathType Leaf)) {
    [Console]::Error.WriteLine("Error: Log file does not exist or is not a file.")
    exit 1
}

$matchedLines = @(Get-Content $LogPath | Where-Object { $_ -match "\b$Level\b" })
$totalCount = $matchedLines.Count

Write-Host "Log Analysis Report: $Level" -ForegroundColor Cyan
Write-Host "Total lines found: $totalCount" 

if ($totalCount -gt 0) {
    Write-Host "`n--- First 3 lines ---" -ForegroundColor Yellow
    $matchedLines | Select-Object -First 3 | ForEach-Object { Write-Host $_ }

    Write-Host "`n--- Last 3 lines ---" -ForegroundColor Yellow
    $matchedLines | Select-Object -Last 3 | ForEach-Object { Write-Host $_ }

    $dates = $matchedLines | Where-Object { $_ -match "^\d{4}-\d{2}-\d{2}" } | ForEach-Object { 
        if ($_ -match "^(\d{4}-\d{2}-\d{2})") { $matches[1] } 
    } | Select-Object -Unique
    
    $dateCount = @($dates).Count
    Write-Host "`nUnique dates found at line starts: $dateCount" -ForegroundColor Green
}

