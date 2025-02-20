@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"
cd ..

if not exist ".env" exit /b 1

for /f "tokens=1,* delims==" %%a in (.env) do (
    if "%%a"=="WINDOWS_USERNAME" (
        set "WINDOWS_USERNAME=%%b"
        set "WINDOWS_USERNAME=!WINDOWS_USERNAME:"=!"
        set "WINDOWS_USERNAME=!WINDOWS_USERNAME: =!"
    )
)

if "%WINDOWS_USERNAME%"=="" exit /b 1

powershell -Command "(Get-Content windows/autounattend.template.xml) -replace '\${WINDOWS_USERNAME}', '%WINDOWS_USERNAME%' | Set-Content windows/autounattend.xml"

endlocal
