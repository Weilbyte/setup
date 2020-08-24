New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null

# Remove NVIDIA Control Panel from context
Set-ItemProperty "HKCU:\SOFTWARE\NVIDIA Corporation\Global\NvCplApi\Policies" ContextUIPolicy 0 -ErrorAction silentlycontinue

# Remove Git GUI and Shell from context
Remove-Item -Path HKCR:\Directory\Background\shell\git_gui\ -Recurse -ErrorAction silentlycontinue
Remove-Item -Path HKCR:\Directory\Background\shell\git_shell\ -Recurse -ErrorAction silentlycontinue
Remove-Item -Path HKCR:\Directory\shell\git_gui\ -Recurse -ErrorAction silentlycontinue
Remove-Item -Path HKCR:\Directory\shell\git_shell\ -Recurse -ErrorAction silentlycontinue