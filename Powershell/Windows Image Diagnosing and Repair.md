Using /checkhealth will run a quick scan to determine if there are any corruptions with the Windows image but will not repair them. 

PS C:\> ``dism /online /cleanup-image /checkhealth``


Using /scanhealth will preform a more advanced scan to determine if there are any image problems. 

PS C:\> ``dism /online /cleanup-image /scanhealth`` 


Use /restorehealth to run an advanced scan and repair problems with Windows image automatically.

PS C:\> ``dism /online /cleanup-image /restorehealth``
