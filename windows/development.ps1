Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

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
