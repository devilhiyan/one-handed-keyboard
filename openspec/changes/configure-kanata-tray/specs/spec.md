# Specification for Tray Launch

## Files
- `kanata/launch_kanata.bat`
- `kanata/start_kanata.ps1`

## Changes

### `kanata/launch_kanata.bat`
Replace the entire content with:

```batch
@echo off
cd /d "%~dp0"
start "" /MIN powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "start_kanata.ps1"
exit
```

### `kanata/start_kanata.ps1`
Remove all `Write-Host` calls and add `-q` to the kanata execution.

```powershell
Set-Location $PSScriptRoot

$ahkScript = Join-Path $PSScriptRoot "kanata_mouse_bridge.ahk"

Start-Process cmd -ArgumentList "/c start """" ""$ahkScript""" -WindowStyle Hidden

try {
    .\kanata_windows_gui_wintercept_cmd_allowed_x64.exe -n -q
} finally {
    $processes = Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like "*kanata_mouse_bridge.ahk*" }
    foreach ($proc in $processes) {
        Stop-Process -Id $proc.ProcessId -Force -ErrorAction SilentlyContinue
    }
}
```
