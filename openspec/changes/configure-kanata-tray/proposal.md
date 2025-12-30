# Configure Kanata to Start Minimized to Tray

## Context
The user wants the Kanata application to start minimized to the system tray, avoiding the persistent command prompt window that currently appears upon launch. Additionally, logging (console output and/or quiet flags) should be suppressed to ensure a clean background operation.

## Proposed Changes
1.  **Modify `kanata/launch_kanata.bat`**:
    *   Use `start` to launch PowerShell in a hidden window and exit immediately.
2.  **Modify `kanata/start_kanata.ps1`**:
    *   Remove `Write-Host` statements.
    *   Add `-q` (quiet) flag to the Kanata executable call.

## Technical Details
*   **`kanata/launch_kanata.bat`**:
    ```batch
    @echo off
    cd /d "%~dp0"
    start "" /MIN powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "start_kanata.ps1"
    exit
    ```
*   **`kanata/start_kanata.ps1`**:
    ```powershell
    Set-Location $PSScriptRoot

    $ahkScript = Join-Path $PSScriptRoot "kanata_mouse_bridge.ahk"

    # Use cmd /c start to leverage Windows file association
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

## Verification Plan
1.  Run `launch_kanata.bat`.
2.  Observe that no permanent console window remains.
3.  Verify Kanata is running (via Tray icon or Task Manager).
4.  Verify AHK Mouse Bridge is running.
