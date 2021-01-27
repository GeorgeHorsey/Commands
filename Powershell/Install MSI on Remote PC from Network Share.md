Connect to remote Powershell session. 

``Enter-PSSession [remote hostname or ip address]``

Assign the network location to a drive letter

``net use [z]: [\\servername\folder] /user:[username] [password]``

CD to the drive letter you mapped and then into the location of the .msi file. 

Run this command to install the msi without any popups on remote computer. 

``msiexec /I [YourProgram.msi] /qn``
