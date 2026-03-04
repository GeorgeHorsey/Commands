Preffered method for finding the Dell Service Tag. Run Powershell. 

```powershell
Get-CimInstance -ClassName Win32_BIOS | Select-Object SerialNumber
```


Deprectated option for computers with WMIC installed. This should be run in a command prompt. 

```shell
wmic bios get serialnumber
```
