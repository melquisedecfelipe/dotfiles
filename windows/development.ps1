Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

winget install --id=AgileBits.1Password -e  && winget install --id=7zip.7zip -e  && winget install --id=Anysphere.Cursor -e  && winget install --id=Google.Chrome -e  && winget install --id=Microsoft.VisualStudioCode -e  && winget install --id=Microsoft.WindowsTerminal -e  && winget install --id=Postman.Postman -e  && winget install --id=TheBrowserCompany.Arc -e  && winget install --id=VideoLAN.VLC -e

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

wsl --set-default-version 2
