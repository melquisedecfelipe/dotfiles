@echo off

powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0dev.ps1"
