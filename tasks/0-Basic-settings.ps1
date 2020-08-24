# Set network type to private
Set-NetConnectionProfile -NetworkCategory Private

# Show known file extensions
if ((Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced HideFileExt).HideFileExt -eq "1") {
    Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced HideFileExt "0"
    Stop-Process -processName: Explorer -force 
}

# Remove screen and standby timeouts on AC
powercfg -change -monitor-timeout-ac 0
powercfg -change -standby-timeout-ac 0