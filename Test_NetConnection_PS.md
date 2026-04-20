If a workstation cannot connect, run this command in PowerShell from the workstation to see if the server is listening:

```powershell
Test-NetConnection -ComputerName [YourServerIP] -Port [YourPort]
```