# getting a "cannot be loaded because the execution of scripts is disabled on this system" error?
# you'll often first need to bypass powershell execution-policy restrictions to use this script.
# to do this, use:
#   Set-ExecutionPolicy -scope CurrentUser Unrestricted

param ([switch]$force, [switch]$verbose)  #ex. "cleanup-agent-shell.ps1 -force" or "cleanup-agent-shell.ps1 -verbose"
if ($verbose) { $VerbosePreference = "Continue"}

#################################################
# Global variables
$script:app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "Agent Shell" -and $_.Vendor -match "Spiceworks" }
$script:uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_.DisplayName -match "Agent Shell" -and $_.Publisher -match "Spiceworks" } | select UninstallString
$script:uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_.DisplayName -match "Agent Shell" -and $_.Publisher -match "Spiceworks" } | select UninstallString
$script:installedAgentRevNumber = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_.DisplayName -match "Agent Shell" -and $_.Publisher -match "Spiceworks" } | select -ExpandProperty PSChildName
Write-Verbose "agent rev number $script:installedAgentRevNumber detected as installed"

function stopService {
    Stop-Service AgentShellService
}

function findInstallPath {
    If (Test-Path "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell") {
      Write-Verbose "agent shell detected in registry at HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell"
      $script:installpath = (gp "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell").InstallDirectory
    }
    ElseIf (Test-Path "HKLM:\SOFTWARE\Spiceworks\Agent Shell") {
      Write-Verbose "agent shell detected in registry at HKLM:\SOFTWARE\Spiceworks\Agent Shell"
      $script:installpath = (gp "HKLM:\SOFTWARE\Spiceworks\Agent Shell").InstallDirectory
    }
    Else {
      $script:installpath = "C:\Program Files (x86)\Spiceworks Agent Shell"
    }
    Write-Verbose "install dir is $installpath"
}

function forceRemoval {
    Write-Output "`"-force`" set, forcing uninstall and cleanup (bypassing `"installed state`" checks)"
    Write-Output "some errors are normal in 'force' mode"
    $app.Uninstall()
    start-process "msiexec.exe" -arg "/x $script:installedAgentRevNumber /qn /promptrestart /lv $($ENV:Temp)\spiceworks-agent-uninstall.log" -Wait
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell" -name *  #reg
    Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell" -recurse  #reg
    Remove-Item -Path "HKLM:\SOFTWARE\Spiceworks\Agent Shell" -recurse  #reg
    Remove-Item -recurse -force $installpath  #file sys
}

function standardRemoval {
    #attempt standard uninstall
    if ($app) {
        Write-Output "wmi reports agent shell is installed, running uninstaller using default windows uninstall behavior"
        $app.Uninstall()
    }
    else {Write-Warning "agent shell not installed per wmi"}
    
    #attempt msiexec uninstall
    if ($uninstall64) {
        Write-Output "agent shell found in 64bit reg `"uninstall`" hive, running uninstaller"
        $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
        $uninstall64 = $uninstall64.Trim()
        Write-Verbose "calling msi uninstaller..."
        start-process "msiexec.exe" -arg "/x $uninstall64 /qn /promptrestart /lv $($ENV:Temp)\spiceworks-agent-uninstall.log" -Wait
    } else {Write-Verbose "agent shell not found in 64bit reg `"uninstall`" hive"}
    
    if ($uninstall32) {
        Write-Output "agent shell found in 32bit reg `"uninstall`" hive, running uninstaller"
        $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
        $uninstall32 = $uninstall32.Trim()
        Write-Verbose "calling msi uninstaller..."
        start-process "msiexec.exe" -arg "/x $uninstall32 /qn /promptrestart /lv $($ENV:Temp)\spiceworks-agent-uninstall.log" -Wait
    } else {Write-Verbose "agent shell not found in 32bit reg `"uninstall`" hive"}

    #cleanup registry; remove HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell
    if (Test-Path "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell") {
        Write-Output "cleaning up registry"
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell" -name *
        Remove-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Spiceworks\Agent Shell" -recurse
    }
    else {Write-Verbose "no agent shell reg hive found"}

    #cleanup file system; recurs remove C:\Program Files (x86)\Spiceworks Agent Shell
    if (Test-Path $installpath) {
        Write-Output "cleaning up file system"
        Remove-Item -recurse -force $installpath
    }
    else {Write-Verbose "no agent shell file system dir found"}
}

Write-Output "stop agent shell service"
stopService
Write-Output "attempt agent shell removal"
findInstallPath
if ($force) {  forceRemoval } # force uninstall and cleanup blindly, without testing paths 
else { standardRemoval }
Write-Output "finished"