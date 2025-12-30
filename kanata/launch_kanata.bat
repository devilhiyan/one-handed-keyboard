@echo off
cd /d "%~dp0"
start "" /MIN powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "start_kanata.ps1"
exit