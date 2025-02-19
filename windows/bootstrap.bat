@echo off

powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

if "%1"=="" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0development.ps1"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0gaming.ps1"
)
