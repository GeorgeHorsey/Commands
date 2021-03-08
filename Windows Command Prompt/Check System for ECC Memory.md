Run the following command in command promot to check if the system you are on has ECC memory of not. 

``wmic MEMORYCHIP get DataWidth,TotalWidth``

Example output 

//ECC Memory

DataWidth 64 TotalWidth 72

//Non-ECC Memory

DataWidth 64 TotalWidth 64
