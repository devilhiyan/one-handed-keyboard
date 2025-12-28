$kanataPath = "$PSScriptRoot\kanata-windows-binaries-x64-v1.10.1\kanata_windows_gui_wintercept_x64.exe"
$configPath = "$PSScriptRoot\kanata.kbd"

Write-Host "Starting Kanata with config: $configPath"
& $kanataPath --cfg $configPath