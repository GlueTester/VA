#Grab all present hardware and for by class
Get-PnpDevice -PresentOnly | Select Class,FriendlyName | sort Class

#https://superuser.com/questions/1014635/powershell-script-to-export-all-devices-in-device-manager-as-tree-or-list
Invoke-Command -ComputerName localhost { 
Get-WmiObject Win32_PNPEntity | Where { $_.PNPClass -notin  "System","Net","Processor","SoftwareDevice","AudioEndpoint","BluetoothVirtual","Battery","Media","Volume","Modem","Camera","VolumeSnapshot","DiskDrive","Computer","HIDClass"}


} | Sort-Object -Property PNPClass | Format-Table Name, Manufacturer, PNPClass, Status


Get-WmiObject Win32_PNPEntity | Where { $_.PNPClass -notin  "System","Firmware","SecurityDevices","MTD","Net","Processor","SoftwareDevice","SoftwareComponent","AudioEndpoint","Mouse","BluetoothVirtual","Battery","Media","Volume","Modem","Camera","VolumeSnapshot","DiskDrive","Computer","HIDClass"}| Sort-Object -Property PNPClass | Format-Table Name, Manufacturer, PNPClass, Status