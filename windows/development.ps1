Set-ExecutionPolicy Bypass -Scope Process -Force

$apps = @(
    "7zip.7zip",
    "AgileBits.1Password",
    "Brave.Brave",
    "Google.Chrome",
    "Microsoft.VisualStudioCode",
    "Microsoft.WindowsTerminal",
    "Mozilla.Firefox",
    "Postman.Postman",
    "VideoLAN.VLC"
)

foreach ($app in $apps) {
    winget install --id=$app -e --silent
}

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl --set-default-version 2

winget install --id=Canonical.Ubuntu -e --silent
