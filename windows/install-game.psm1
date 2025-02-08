# Run as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$apps = @(
    "7zip.7zip",
    "AgileBits.1Password",
    "Blizzard.BattleNet",
    "Brave.Brave",
    "Discord.Discord",
    "EpicGames.EpicGamesLauncher",
    "TheBrowserCompany.Arc",
    "Valve.Steam",
    "VideoLAN.VLC"
)

foreach ($app in $apps) {
    winget install -e --accept-source-agreements --accept-package-agreements --silent $app
}
