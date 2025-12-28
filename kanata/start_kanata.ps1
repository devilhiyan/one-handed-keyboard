Set-Location $PSScriptRoot

$ahkScript = Join-Path $PSScriptRoot "kanata_mouse_bridge.ahk"

Write-Host "Starting Mouse Bridge (AutoHotkey)..."
# Use cmd /c start to leverage Windows file association
Start-Process cmd -ArgumentList "/c start """" ""$ahkScript""" -WindowStyle Hidden

Write-Host "Starting Kanata..."
try {
    .\kanata_windows_gui_wintercept_cmd_allowed_x64.exe -n
} finally {
    Write-Host "Kanata stopped. Closing Mouse Bridge..."
    $processes = Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like "*kanata_mouse_bridge.ahk*" }
    foreach ($proc in $processes) {
        Stop-Process -Id $proc.ProcessId -Force -ErrorAction SilentlyContinue
    }
}
