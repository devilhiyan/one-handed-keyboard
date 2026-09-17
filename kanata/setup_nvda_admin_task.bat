@echo off
:: Setup script to create the 'NVDA_Elevated' scheduled task.
:: This allows the one-handed keyboard B key to launch NVDA as Administrator with 0 UAC prompts.
echo ================================================================
echo  Registering NVDA Elevated Task for One-Handed Keyboard Toggle
echo ================================================================
powershell -NoProfile -Command "Start-Process schtasks -ArgumentList '/create /tn \"NVDA_Elevated\" /tr \"\"\"C:\Program Files\NVDA\nvda_slave.exe\"\" launchNVDA -r\" /sc ONCE /st 00:00 /rl HIGHEST /f' -Verb RunAs"
echo.
echo Setup triggered. Once approved, the task is permanently registered!
echo You can now press physical 'B' in Hyn mode to toggle NVDA silently.
pause
