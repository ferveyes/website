@pushd "%~dp0" && powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

Write-Host -NoNewline "Please close Outlook."
for(;;) {
  try
  {
    Wait-Process -Name outlook -Timeout 1 -ErrorAction Stop | Out-Null
    break
  }
  catch [Microsoft.PowerShell.Commands.ProcessCommandException]
  {
    break
  }
  catch
  {
    Write-Host -NoNewline "."
  }
}
echo .

$url = "https://ftp.vector.co.jp/64/77/2287/OAFT.zip"
echo "Downloading $url"
(New-Object System.Net.WebClient).DownloadFile($url, "OAFT.zip")

echo "Decompressing OAFT.zip"
Expand-Archive -Path OAFT.zip -DestinationPath OAFT -Force

echo "Starting setup.exe"
Start-Process .\OAFT\OAFT\setup.exe -Wait

$url = "https://github.com/ferveyes/website/releases/download/OutlookAttachedTool_dll_EN/OutlookAttachedTool.dll"
echo "Searching OutlookAttachedTool.dll"
dir -r -Filter "OutlookAttachedTool.dll" -File -Name $env:LOCALAPPDATA | %{
  $dest = (Join-Path $env:LOCALAPPDATA $_)
  echo "Overriding $dest by $url"
  (New-Object System.Net.WebClient).DownloadFile($url, $dest)
}

Pause
