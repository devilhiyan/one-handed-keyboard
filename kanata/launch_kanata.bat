@echo off
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File "start_kanata.ps1"
pause
