@echo off
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

choco feature enable -n allowGlobalConfirmation

choco install 1password 7zip brave calibre discord epicgameslauncher googlechrome opera-gx powertoys spotify steam telegram  vlc

echo Very well, installation completed!
echo Remember to install Battle.net and Whatsapp
