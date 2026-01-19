Open PowerShell as Administrator or Command Prompt.

For all installed hotfixes: 

``` Powershell
Get-HotFix
```

To search for a specific KB: 

```Powershell
Get-HotFix -Id KBXXXXXX
```
(replace KBXXXXXX with the actual KB number).

Alternatively, in Command Prompt: systeminfo | findstr KBXXXXXX (replace KBXXXXXX). 
