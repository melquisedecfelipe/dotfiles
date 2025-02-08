# Run as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$apps = @(
    "7zip.7zip",
    "AgileBits.1Password",
    "Canonical.Ubuntu",
    "Cursor.Cursor",
    "Google.Chrome",
    "Hyper.Hyper",
    "Microsoft.VisualStudioCode",
    "Microsoft.WindowsTerminal",
    "Postman.Postman",
    "TheBrowserCompany.Arc",
    "VideoLAN.VLC",
    "Zed.Zed"
)

foreach ($app in $apps) {
    winget install -e --accept-source-agreements --accept-package-agreements --silent $app
}

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl --set-default-version 2

$devPath = "$HOME\Development"
New-Item -Path $devPath -ItemType Directory -Force

wsl --exec bash -c "ln -sf /mnt/c/Users/$env:USERNAME/Development ~/Development"
