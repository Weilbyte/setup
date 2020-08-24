if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Warning "[!] Insufficient permissions, re-run as administrator"
Break
}

$dependencies = @("PS-Menu", "PSWriteColor", "posh-git", "oh-my-posh")

foreach ($dep in $dependencies) {
    If(-not(Get-InstalledModule $dep -ErrorAction silentlycontinue)){
        Write-Host "[-] Installing dependency module :: $dep"
        Install-Module $dep -Scope CurrentUser -Force
    }
    Import-Module $dep
}

if (Get-Command choco -errorAction SilentlyContinue)
{
    Write-Host "[-] Chocolatey already installed"
} else {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) | Out-Null
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    if (Get-Command choco -errorAction SilentlyContinue) {
        Write-Host "[-] Chocolatey successfully installed"
    } else {
        Write-Warning "[!] Error installing Chocolatey"
        Break
    }
}

choco feature enable -n=allowGlobalConfirmation | Out-Null

$tasks = Get-ChildItem .\tasks -File | Sort-Object
foreach ($task in $tasks) {
    $taskName = (($task.Name -replace '.ps1','') -replace (($task.Name -split '-')[0]),'') -replace '-',' '
    Write-Host "[-] Running task:$taskName"
    & $task.FullName
}