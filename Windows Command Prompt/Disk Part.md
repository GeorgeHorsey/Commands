To enter Disk Part launch command prompt as administrator. 

Run the command 

``diskpart``

Use this command to list all connected disks. 

``list disk``

To select the desired disk. 

``select disk <index_number>``

To view disk partitions. 

``list partition``

To select the desired partition. 

``select partition <index_number>``

If a partition says it's protected you can use the following command to force it's deletion USE CAUTION RUNNING THIS COMMAND. 

``delete partition override``
