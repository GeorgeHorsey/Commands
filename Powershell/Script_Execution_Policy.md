Default Windows installations block the running of scripts. These commands are how you allow and restrict running scripts. 

To start run the following command to see the current ExecutionPolicy is set. 

``Get-ExecutionPolicy``

This command will return the current policy set. Refer below for the defenition of each. 

If it is set as Restricted run the following command to allow scripts to be run. 

``Set-ExecutionPolicy RemoteSigned``

After running your script return it do Restricted. 

``Set-ExecutionPolicy Restricted``

Verify with Get-ExecutionPolicy. 


Purpose: To control the execution of scripts to prevent accidental, potentially harmful, code from running.

Policies:

Restricted: The default in some cases, this policy prevents all scripts from running.

AllSigned: Only allows scripts that are digitally signed by a trusted publisher to run.

RemoteSigned: Allows locally written scripts to run but requires scripts downloaded from the internet to be digitally signed.

Unrestricted: Allows all scripts to run, but may display a warning for unsigned scripts downloaded from the internet.

Bypass: Runs all scripts without any restrictions or warnings.
