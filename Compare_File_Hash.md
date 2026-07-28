Open Command Prompt

Run this command to get the hash of a file. 

```shell
certutil -hashfile "C:\path\to\file.zip" SHA256
```

Could also put MD5 instead of SHA256. 

This will output the hash in whatever algorithm you selected. 

Now open PowerShell 

Run this command to compare a file to the known hash. 

```shell
(Get-FileHash ".\C:\path\to\file.zip" -Algorithm SHA256).hash -eq "hash-from-source-or-above-command"
```

Outputs True or False. 