param(
    [string]$Driver = ""
)

# Self-elevate the script if not running as Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    try {
        $argList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
        if ($Driver) { $argList += " -Driver `"$Driver`"" }
        Start-Process powershell.exe $argList -Verb RunAs -WindowStyle Hidden
        Exit
    } catch {
        # Proceed with current user permissions if elevation request is unavailable
    }
}

Set-Location $PSScriptRoot

function Log-Debug {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path (Join-Path $PSScriptRoot "launch_debug.log") -Value "[$timestamp] $Message" -ErrorAction SilentlyContinue
}

Log-Debug "Starting launch script..."

# Clean up any lingering or previous instances of Kanata and AHK bridge
Log-Debug "Cleaning up previous Kanata and AHK instances..."
Get-Process kanata* -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*kanata_mouse_bridge.ahk*" } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
Start-Sleep -Milliseconds 300

$ahkPath = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
$ahkScript = Join-Path $PSScriptRoot "kanata_mouse_bridge.ahk"

Log-Debug "Launching AHK script: $ahkScript"
if (Test-Path $ahkPath) {
    Start-Process -FilePath $ahkPath -ArgumentList "`"$ahkScript`"" -WindowStyle Hidden
    Start-Sleep -Seconds 1
} else {
    Log-Debug "AHK executable not found at $ahkPath. Using fallback."
    Start-Process cmd -ArgumentList "/c start """" ""$ahkScript""" -WindowStyle Hidden
}

# Determine Driver Mode from CLI param or kanata_settings.ini
$iniFile = Join-Path $PSScriptRoot "kanata_settings.ini"
$driverMode = "auto"
if ($Driver) {
    $driverMode = $Driver.Trim().ToLower()
    Log-Debug "Driver mode specified via CLI parameter: $driverMode"
} elseif (Test-Path $iniFile) {
    $match = Select-String -Path $iniFile -Pattern "^\s*Mode\s*=\s*(.*)"
    if ($match) {
        $driverMode = $match.Matches[0].Groups[1].Value.Trim().ToLower()
        Log-Debug "Driver mode loaded from INI: $driverMode"
    }
}

# Check if Interception kernel filter driver is installed in registry UpperFilters
$hasInterception = $false
try {
    $upperFilters = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e96b-e325-11ce-bfc1-08002be10318}" -ErrorAction SilentlyContinue).UpperFilters
    if ($upperFilters -contains "interception") {
        $hasInterception = $true
    }
} catch {
    Log-Debug "Error querying UpperFilters: $_"
}
Log-Debug "Interception driver detected in registry: $hasInterception"

$winterceptExe = Join-Path $PSScriptRoot "kanata_windows_gui_wintercept_cmd_allowed_x64.exe"
$winIOv2Exe    = Join-Path $PSScriptRoot "kanata-windows-binaries-x64-v1.10.1\kanata_windows_gui_winIOv2_cmd_allowed_x64.exe"

# Select Kanata Binary
$kanataExe = ""
if ($driverMode -eq "wintercept") {
    if ($hasInterception -and (Test-Path $winterceptExe)) {
        $kanataExe = $winterceptExe
        Log-Debug "Mode 'wintercept' selected and confirmed available."
    } elseif (Test-Path $winIOv2Exe) {
        Log-Debug "WARNING: 'wintercept' mode requested but Interception driver not found. Falling back to WinIOv2 for stability."
        $kanataExe = $winIOv2Exe
    } else {
        $kanataExe = $winterceptExe
    }
} elseif ($driverMode -eq "winIOv2") {
    if (Test-Path $winIOv2Exe) {
        $kanataExe = $winIOv2Exe
        Log-Debug "Mode 'winIOv2' explicitly selected."
    } else {
        $kanataExe = $winterceptExe
        Log-Debug "WinIOv2 binary missing; falling back to wintercept."
    }
} else { # auto
    if ($hasInterception -and (Test-Path $winterceptExe)) {
        $kanataExe = $winterceptExe
        Log-Debug "Auto-detected Interception driver. Using wintercept binary."
    } elseif (Test-Path $winIOv2Exe) {
        $kanataExe = $winIOv2Exe
        Log-Debug "Interception driver not detected. Using WinIOv2 binary (LLHOOK+SendInput)."
    } else {
        $kanataExe = $winterceptExe
        Log-Debug "Defaulting to wintercept binary."
    }
}

try {
    $configFile = Join-Path $PSScriptRoot "kanata.kbd"
    Log-Debug "Starting Kanata with config: $configFile"
    Log-Debug "Executable: $kanataExe"
    
    # Running with log redirection for diagnostics
    $proc = Start-Process -FilePath $kanataExe -ArgumentList "-n", "-c", "`"$configFile`"" -RedirectStandardOutput (Join-Path $PSScriptRoot "kanata.log") -RedirectStandardError (Join-Path $PSScriptRoot "kanata_err.log") -Wait -NoNewWindow -PassThru
    
    Log-Debug "Kanata exited with code: $($proc.ExitCode)"
} catch {
    Log-Debug "Error running Kanata: $_"
} finally {
    Log-Debug "Cleaning up AHK processes..."
    $processes = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*kanata_mouse_bridge.ahk*" }
    foreach ($p in $processes) {
        Log-Debug "Stopping AHK Process ID: $($p.ProcessId)"
        Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    }
    Log-Debug "Cleanup complete."
}