@echo off
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

choco feature enable -n allowGlobalConfirmation

choco install 1password 7zip brave calibre discord ea-app epicgameslauncher googlechrome opera-gx powertoys spotify telegram vlc
choco install dotnet-5.0-desktopruntime dotnet-6.0-desktopruntim dotnetcore-3.1-desktopruntime vcredist140

winget install Valve.Steam
winget install WhatsApp.WhatsApp

echo Very well, installation completed!
echo Remember to install Battle.net
