Source:
https://community.spiceworks.com/t/remove-clean-up-windows-agent-shell/975030 

Description
Remove and cleanup the Spiceworks Agent Shell, including wiping registry entries and file system content related to the Agent.

Agent Shell is used as the agent for Inventory online, Connectivity Dashboard (aka Resolve/Troubleshooting), and IP Scanner. This script handles removing the agent for all of these products.

After running the script you should be able to reinstall the agent “cleanly”.

---------------USAGE---------------

If you download the script you’ll have to change the file extension to .ps1 from .txt.

Getting a “cannot be loaded because the execution of scripts is disabled on this system” error?
You’ll often first need to bypass powershell execution-policy restrictions to use this script.

To do this, use:
Set-ExecutionPolicy -scope CurrentUser Unrestricted

---------------OPTIONS---------------
Optional CLI params:

force: force removal when standard detection/uninstall fails
verbose: log extra details to screen

Ex. “cleanup-agent-shell.ps1 -force” or “cleanup-agent-shell.ps1 -verbose”

---------------LOGGING---------------
This script writes a log to %TEMP%\spiceworks-agent-uninstall.log.
