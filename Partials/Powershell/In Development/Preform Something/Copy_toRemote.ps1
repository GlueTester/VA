
$PC = Read-Host "What is the Computer Name"
$Session = New-PSSession -ComputerName $PC
Copy-Item "S:\IMS\+ Hardware Team\Drivers\Canon" -Destination "C:\Temp\" -ToSession $Session -Recurse