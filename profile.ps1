## Load Environment
$load_script = "${env:PSCustomScripts}\PowerShellEnvironment.ps1"
if (Test-Path $load_script) {
	.$load_script
}

$a = (Get-Host).UI.RawUI 
$a.WindowTitle = " ŽO( `EƒÖE)__||Powershell//^^(EƒÖEL )ŽO "

## Prompt
function prompt{
	if ($?) {
		Write-Host "[$(Get-Location)]" -ForegroundColor "Cyan"
		Write-Host "(*'-')" -NoNewLine -ForegroundColor "Green"
		return "> "
	} else {
		Write-Host "[$(Get-Location)]" -ForegroundColor "Cyan"
		Write-Host "(*;-;)" -NoNewLine -ForegroundColor "Red"
		return "> "
	}
}