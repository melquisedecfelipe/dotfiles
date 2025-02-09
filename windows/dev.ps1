Set-ExecutionPolicy Bypass -Scope Process -Force

$apps = @(
    "AgileBits.1Password",
    "7zip.7zip",
    "Google.Chrome",
    "Microsoft.VisualStudioCode",
    "Microsoft.WindowsTerminal",
    "Postman.Postman",
    "TheBrowserCompany.Arc",
    "VideoLAN.VLC"
)

foreach ($app in $apps) {
    winget install --id=$app -e --silent
}

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl --set-default-version 2

winget install --id=Canonical.Ubuntu -e --silent

shutdown /r /t 5 /c "Restarting to complete WSL installation."
