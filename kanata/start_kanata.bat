@echo off
:: Navigate to the script's directory
cd /d "%~dp0"

set "KANATA_EXE=kanata-windows-binaries-x64-v1.10.1\kanata_windows_tty_wintercept_x64.exe"
set "KANATA_KBD=kanata.kbd"

echo Starting Kanata with config: %KANATA_KBD%
"%KANATA_EXE%" --cfg "%KANATA_KBD%"

pause