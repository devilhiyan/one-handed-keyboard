Set-Location $PSScriptRoot

$ahkScript = Join-Path $PSScriptRoot "kanata_mouse_bridge.ahk"

Write-Host "Starting Mouse Bridge (AutoHotkey)..."
Start-Process $ahkScript

Write-Host "Starting Kanata..."
try {
    .\kanata.exe -n
} finally {
    Write-Host "Kanata stopped. Closing Mouse Bridge..."
    $processes = Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like "*kanata_mouse_bridge.ahk*" }
    foreach ($proc in $processes) {
        Stop-Process -Id $proc.ProcessId -Force -ErrorAction SilentlyContinue
    }
}
