$out = "reports"
$format = "text"
$runId = (Get-Date -Format "yyyyMMdd_HHmmss")
$project = (Split-Path -Leaf (Get-Location))
$cmd = $null

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        "--cmd" { $cmd = $args[$i + 1]; $i++ }
        "--out" { $out = $args[$i + 1]; $i++ }
        "--format" { $format = $args[$i + 1]; $i++ }
        "--run-id" { $runId = $args[$i + 1]; $i++ }
        "--project" { $project = $args[$i + 1]; $i++ }
    }
}

if (-not $cmd) {
    Write-Host "Error: --cmd parameter is required. Example: .\scripts\run_tests.ps1 --cmd 'python -m pytest -q'"
    exit 1
}

$runDir = "$out\runs\$runId"
$rawDir = "$runDir\raw"
$summaryDir = "$runDir\summary"

New-Item -ItemType Directory -Force -Path $rawDir | Out-Null
New-Item -ItemType Directory -Force -Path $summaryDir | Out-Null

if ($format -eq "html") { 
    New-Item -ItemType Directory -Force -Path "$runDir\html" | Out-Null 
}




$startTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$testLog = "$rawDir\test_output.txt"

Invoke-Expression "$cmd *> `"$testLog`""
$exitCode = $LASTEXITCODE

if ($exitCode -eq 0) {
    $status = "SUCCESS"
} else {
    $status = "FAIL"
}

$status | Out-File -FilePath "$summaryDir\status.txt" -Encoding utf8
$logContent = Get-Content $testLog -ErrorAction SilentlyContinue

$errors = 0
$fails = 0
$errorLines = @()

if ($null -ne $logContent) { 
    foreach ($line in $logContent) {
        if ($line -match "ERROR") {
            $errors = $errors + 1
        }
        if ($line -match "FAILED") {
            $fails = $fails + 1
        }
        if ($line -match "ERROR" -or $line -match "FAILED") {
            $errorLines += $line
        }
    }
}

"ERROR: $errors, FAILED: $fails" | Out-File -FilePath "$summaryDir\stats.txt" -Encoding utf8
"Cmd: $cmd`nTime: $startTime`nRunID: $runId`nProject: $project" | Out-File -FilePath "$summaryDir\meta.txt" -Encoding utf8





$reportData = @()
$reportData += "Project: $project"
$reportData += "Date/Time: $startTime"
$reportData += "Command: $cmd"
$reportData += "Status: $status"
$reportData += "Log: $testLog"
$reportData += "ERROR count: $errors"
$reportData += "FAILED count: $fails"

if ($errors -eq 0 -and $fails -eq 0) {
    $reportData += "No ERROR or FAILED markers found."
} else {
    $reportData += "--- First 5 ERROR/FAILED ---"
    $reportData += $errorLines | Select-Object -First 5
    $reportData += "--- Last 5 ERROR/FAILED ---"
    $reportData += $errorLines | Select-Object -Last 5
}

$reportData | Out-File -FilePath "$runDir\report.txt" -Encoding utf8

if ($format -eq "html") {
    $html = "<html><head><meta charset='utf-8'><title>Report</title></head><body>"
    $html += "<h1>Test Report: $project</h1>"
    $html += "<p><b>Status:</b> $status</p><p><b>Command:</b> $cmd</p><p><b>Time:</b> $startTime</p>"
    $html += "<p><b>ERRORs:</b> $errors | <b>FAILEDs:</b> $fails</p>"
    $html += "<p><b>Raw log:</b> <a href='../raw/test_output.txt'>test_output.txt</a></p>"
    $html += "</body></html>"
    
    $html | Out-File -FilePath "$runDir\html\report.html" -Encoding utf8
}

exit $exitCode