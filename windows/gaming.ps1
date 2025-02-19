Set-ExecutionPolicy Bypass -Scope Process -Force

$apps = @(
    "7zip.7zip",
    "AgileBits.1Password",
    "Brave.Brave",
    "Discord.Discord",
    "EpicGames.EpicGamesLauncher",
    "Mozilla.Firefox",
    "Valve.Steam",
    "VideoLAN.VLC"
)

foreach ($app in $apps) {
    winget install --id=$app -e --silent
}

# Uncomment the following line to disable unnecessary services
# Disable unnecessary services
# $services = @(
#     "DiagTrack",               # Windows Telemetry
#     "SysMain",                 # Superfetch
#     "WSearch"                  # Windows Search
# )
#
# foreach ($service in $services) {
#     Set-Service -Name $service -StartupType Disabled
#     Stop-Service -Name $service -Force
# }

# Set power plan to high performance
# powercfg /setactive SCHEME_MIN

# Disable visual effects
# Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2

# Disable Game DVR and Game Bar
# Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0
# Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0

# Optimize CPU priority for games
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "GPU Priority" -Value 8
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Priority" -Value 6
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name "Scheduling Category" -Value "High"

# Disable hibernation
# powercfg /hibernate off
