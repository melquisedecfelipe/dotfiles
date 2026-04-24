@echo off

if "%1"=="" (
  echo Usage: generate.bat ^<username^>
  exit /b 1
)

powershell -Command "(Get-Content '%~dp0autounattend.template.xml') -replace '\${WINDOWS_USERNAME}', '%1' | Set-Content '%~dp0autounattend.xml'"

echo   [OK] autounattend.xml generated
