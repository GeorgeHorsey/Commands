Launch Powershell as Administrator on a Domain Joined computer. 

Run the command below to list all the reachable Domain Controllers. 

```shell
nltest /DCLIST:yourdomain.com
```

Run the command below to verify a trusted domain connection. 

```shell
nltest /SC_VERIFY:yourdomain.com
```
