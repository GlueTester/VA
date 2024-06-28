$SourcePath = "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\Scanners\Canon DR-MR160II"
$SetupFile = "" 
$DestinationPath = "C:\Temp\"

$PC = Read-Host "What is the Computer Name"
$Session = New-PSSession -ComputerName $PC
Copy-Item $SourcePath -Destination $DestinationPath -ToSession $Session -Recurse
Invoke-Command -ComputerName $PC -ScriptBlock { Start-Process "C:\Temp\Canon DR-MR160II\Setup.exe" -ArgumentList /silent -Wait -NoNewWindow 