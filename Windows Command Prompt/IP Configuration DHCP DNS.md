List network all adapters address, mask and gateway. 

``ipconfig``

List detailed info about network adapters. 

``ipconfig /all``

Use /release and /renew if you recently changed networks that support DHCP and your ip address has not switched over to the new network. 

Release DHCP Lease

``ipconfig /release``

Renew DHCP Lease

``ipconfig /renew``

Run the following commands in order: 

Flush DNS
``ipconfig /flushdns``

Register DNS
``ipconfig /registerdns``

Release
``ipconfig /release``

Renew
``ipconfig /renew``

NETSH winsock Reset Catalog 
``NETSH winsock reset catalog``

NETSH int ipv4 reset reset.log
``NETSH int ipv4 reset reset.log``

NETSH int ipv6 reset reset.log
``NETSH int ipv6 reset reset.log``
