$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$runTestsScript = Join-Path -Path $scriptDir -ChildPath "run_tests.ps1"

& $runTestsScript --cmd "python -m pytest sample_py/ -q" --format html
