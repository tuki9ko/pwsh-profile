## Load Environment
$load_script = "${env:PSCustomScripts}\PowerShellEnvironment.ps1"
if (Test-Path $load_script) {
	.$load_script
}

$a = (Get-Host).UI.RawUI 
$a.WindowTitle = " �O( `�E�ցE)�_�_||Powershell//�^�^(�E�ցE�L )�O "

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