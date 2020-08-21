## Pause
function Pause{
    if ($psISE){
        $null = Read-Host 'Press Enter to continue...'
    }
    else{
        Write-Host "Press Any Key to continue..."
        (Get-Host).UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    }
}

function Start-RunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; (Get-Host).UI.RawUI.WindowTitle += `" [Administrator]`""
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias su Start-RunAs

function Invoke-CommandRunAs
{
    $cd = (Get-Location).Path
    $commands = "Set-Location $cd; Write-Host `"[Administrator] $cd> $args`"; $args; Pause; exit"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($commands)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoExit","-encodedCommand",$encodedCommand
}

Set-Alias sudo Invoke-CommandRunAs

function Start-CmdRunAs
{
	sudo cmd
}

function CalcNetworkAddressv4( $IP, $Subnet ){
	# CIDR の時は サブネットマスクに変換する
	if( $Subnet -eq $null ){
		$Temp = $IP -split "/"
		$IP = $Temp[0]
		$CIDR = $Temp[1]
		$intCIDR = [int]$Temp[1]
		for( $i = 0 ; $i -lt 4 ; $i++ ){
			# all 1
			if( $intCIDR -ge 8 ){
				$Subnet += "255"
				$intCIDR -= 8
			}
			# all 0
			elseif($intCIDR -le 0){
				$Subnet += "0"
				$intCIDR = 0
			}
			else{
				# オクテット内 CIDR で表現できる最大数
				$intNumberOfNodes = [Math]::Pow(2,8 - $intCIDR)
				# サブネットマスクを求める
				$intSubnetOct = 256 - $intNumberOfNodes
				$Subnet += [string]$intSubnetOct
				$intCIDR = 0
			}
			
			# ラストオクテットにはピリオドを付けない
			if( $i -ne 3 ){
				$Subnet += "."
			}
		}
	}
	# サブネットマスクの時は CIDR を求める
	else{
		$SubnetOct = $Subnet -split "\."
		$intCIDR = 0
		for( $i = 0 ; $i -lt 4 ; $i++ ){
			# オクテット内のビットマスクを作る
			$intSubnetOct = $SubnetOct[$i]
			$strBitMask = [Convert]::ToString($intSubnetOct,2)
			
			# マスクのビット長カウント
			for( $j = 0 ; $j -lt 8; $j++ ){
				if( $strBitMask[$j] -eq "1" ){
					$intCIDR++
				}
			}
		}
		$CIDR = [string]$intCIDR
	}

	echo "Subnetmusk:        $Subnet"
	echo "CIDR:              /$CIDR"
	
	$SubnetOct = $Subnet -split "\."
	$IPOct = $IP -split "\."

	# ネットワーク ID の算出
	$StrNetworkID = ""
	for( $i = 0 ; $i -lt 4 ; $i++ ){
		$intSubnetOct = [int]$SubnetOct[$i]
		$intIPOct = [int]$IPOct[$i]
		$intNetworkID = $intIPOct -band $intSubnetOct

		$StrNetworkID += [string]$intNetworkID

		if( $i -ne 3 ){
			$StrNetworkID += "."
		}
	}
	echo "Network ID:        $StrNetworkID"

	# ブロードキャストアドレスの算出
	$NetworkIDOct = $StrNetworkID  -split "\."
	for( $i = 0 ; $i -lt 4 ; $i++ ){
		$intSubnetOct = [int]$SubnetOct[$i]
		$intNetworkIDOct = [int]$NetworkIDOct[$i]
		$BitPattern = $intSubnetOct -bxor 255
		$intBroadcastAddress = $intNetworkIDOct -bxor $BitPattern
		$StrBroadcastAddress += [string]$intBroadcastAddress

		if( $i -ne 3 ){
			$StrBroadcastAddress += "."
		}
	}
	echo "Broadcast Address: $StrBroadcastAddress"
}

Set-Alias calcipv4 CalcNetworkAddressv4