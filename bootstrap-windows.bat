@echo off
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

choco feature disable -n=allowGlobalConfirmation

choco install 1password
choco install 7zip
choco install brave
choco install calibre
choco install discord
choco install epicgameslauncher
choco install googlechrome
choco install powertoys
choco install spotify
choco install steam
choco install telegram
choco install vlc

echo Bootstrap concluído.
echo Remember to install Battle.net and Whatsapp.
