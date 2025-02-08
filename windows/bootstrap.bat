@echo off

powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

if "%1"=="game" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0game.ps1"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0development.ps1"
)
