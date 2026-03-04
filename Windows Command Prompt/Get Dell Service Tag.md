```powershell
Get-CimInstance -ClassName Win32_BIOS | Select-Object SerialNumber
```



`wmic bios get serialnumber`
