PowerShell Profile
===

My PowerShell profile.

## Description

自分用の PowerShell プロファイルです。  
プロンプトの書き換えとスクリプトの読み込みを行います。  
スクリプトは autoload フォルダに配置することで自動ロードします。

autoload に以下のスクリプトを含めています。  

## Requirement

PowerShell2.x 以降であれば動くと思います。  
以下の環境で確認済み
- Windows7 PowerShell5.0
- Windows10 PowerShell5.1

```powershell
> $PSVersionTable
Name                           Value
----                           -----
PSVersion                      5.0.10586.117
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.10586.117
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

```powershell
> $PSVersionTable
Name                           Value
----                           -----
PSVersion                      5.1.17134.228
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.17134.228
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

## Usage, Install

大前提として、PowerShell でのスクリプト実行を許可します。
```powershell
# インターネットからダウンロードされた署名済みスクリプトを実行許可
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

プロファイルのパスを確認します。
```powershell
Test-Path $profile.CurrentUserAllHosts
```

`FALSE` であれば、プロファイルを作成します。
```powershell
New-Item -Path $profile.CurrentUserAllHosts -ItemType file
```

リポジトリをクローンし、フォルダの中身をプロファイルがあるフォルダに置きます。(profile.ps1 が上書きされるように)

autoload フォルダに任意のスクリプトを置くことで、PowerShell 起動時に読み込ませることができます。  
プロンプトを書き換えているので、気に入らなければ profile.ps1 の `prompt` 関数を削除してください。

## References

[PowerShell で Profile を利用して スクリプトの自動読み込みをしてみよう - tech.guitarrapc.com](http://tech.guitarrapc.com/entry/2013/09/23/164357)

[PowerShellのprofile.ps1自分用設定 - @tomoko523 - Qiita](https://qiita.com/tomoko523/items/87ccaec05a433b02f67e)

[PowerShellでsudo - @twinkfrag - Qiita](https://qiita.com/twinkfrag/items/3afb9032fd73eabe09be)

