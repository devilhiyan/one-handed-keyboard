Set-Location $PSScriptRoot

# function Log-Debug {
#     param([string]$Message)
#     $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
#     Add-Content -Path "launch_debug.log" -Value "[$timestamp] $Message"
# }

# Log-Debug "Starting launch script..."

$ahkPath = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
$ahkScript = Join-Path $PSScriptRoot "kanata_mouse_bridge.ahk"

# Log-Debug "Launching AHK script: $ahkScript"
if (Test-Path $ahkPath) {
    Start-Process -FilePath $ahkPath -ArgumentList "`"$ahkScript`"" -WindowStyle Hidden
} else {
    # Log-Debug "AHK executable not found at $ahkPath. Using fallback."
    # Fallback to file association if specific path not found
    Start-Process cmd -ArgumentList "/c start """" ""$ahkScript""" -WindowStyle Hidden
}

try {
    $configFile = Join-Path $PSScriptRoot "kanata.kbd"
    # Log-Debug "Starting Kanata with config: $configFile"
    
    $kanataExe = Join-Path $PSScriptRoot "kanata_windows_gui_wintercept_cmd_allowed_x64.exe"
    
    # Running without log redirection for production
    $proc = Start-Process -FilePath $kanataExe -ArgumentList "-n", "-c", "`"$configFile`"" -Wait -NoNewWindow -PassThru
    
    # Log-Debug "Kanata exited with code: $($proc.ExitCode)"
} catch {
    # Log-Debug "Error running Kanata: $_"
} finally {
    # Log-Debug "Cleaning up AHK processes..."
    $processes = Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like "*kanata_mouse_bridge.ahk*" }
    foreach ($proc in $processes) {
        # Log-Debug "Stopping AHK Process ID: $($proc.ProcessId)"
        Stop-Process -Id $proc.ProcessId -Force -ErrorAction SilentlyContinue
    }
    # Log-Debug "Cleanup complete."
}