@echo off

cd ..

for /f "usebackq tokens=1,* delims==" %%a in (".env") do (
    if "%%a"=="WINDOWS_USERNAME" set "WINDOWS_USERNAME=%%b"
)

set WINDOWS_USERNAME=%WINDOWS_USERNAME:"=%
set WINDOWS_USERNAME=%WINDOWS_USERNAME: =%

if "%WINDOWS_USERNAME%"=="" (
    echo WINDOWS_USERNAME not found
    exit /b 1
)

cd windows

powershell -Command "(Get-Content autounattend.template.xml) -replace '\${WINDOWS_USERNAME}', '%WINDOWS_USERNAME%' | Set-Content autounattend.xml"
