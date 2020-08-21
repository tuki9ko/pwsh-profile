$psdir = "${env:PSCustomScripts}"
Get-ChildItem $psdir\autoload | Where-Object Extension -eq ".ps1" | ForEach-Object{.$psdir\autoload\$_}

Write-Host "Custom PowerShell Environment Loaded" -ForegroundColor Cyan
