$Session = New-PSSession -ComputerName "lex-ws107773"
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\Censitrak" -Destination "C:\Temp\" -ToSession $Session -Recurse

$Session = New-PSSession -ComputerName "lex-ws107773"
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\Scanners\Fujitsu 7160\2.10.0.9" -Destination "C:\Temp\" -ToSession $Session -Recurse

PACS (FULL)
$Session = New-PSSession -ComputerName "LEX-MA95573"
Copy-Item "\\r03.med.va.gov\ct\Production\Software Packages\ChangeHealthcare_PACS\V09_14001332\" -Destination "C:\Temp\" -ToSession $Session -Recurse

UPS_WORLDSHIPv26
$Session = New-PSSession -ComputerName "LEX-MA96006"
Copy-Item "\\OITPHCSQL090ADM.va.gov\UPS_WORLDSHIPv26\" -Destination "C:\Temp\" -ToSession $Session -Recurse

AdobeAcroCleaner
$Session = New-PSSession -ComputerName "LEX-LT108049"
Copy-Item "\\va.gov\oit\ClientTech\Software\Software Packages\Adobe\AcroCleaner" -Destination "C:\Temp\" -ToSession $Session -Recurse

Copy CPRS
$Session = New-PSSession -ComputerName "lex-lt88076"
$Source ="\\v09.med.va.gov\apps\VA_Shortcuts\LEX\CPRSChart LEX.lnk"
$Dest =  "C:\Users\VHALEX \Desktop"

Copy-Item $Source -Destination "$Dest -ToSession $Session -Recurse




$Session = New-PSSession -ComputerName "lex-lt100336"
Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Drivers\Canon\DR-M160II\" -Destination "C:\Temp\" -ToSession $Session -Recurse



$Session = New-PSSession -ComputerName "LEX-WS105049"
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\McKesson\mckessen new (Change Healthcare Radiology)\ " -Destination "C:\Temp\" -ToSession $Session -Recurse




Turn ON RDP
Set-ItemProperty `HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\` -Name "fDenyTSConnections" -Value 0

BIOS UPDATE
$Session = New-PSSession -ComputerName "lex-KI****"
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BIOS\Dell 7440 1.15.0\" -Destination "C:\Temp\" -ToSession $Session -Recurse
Start-Process -Wait -FilePath "C:\Temp\Dell 7440 1.15.0.exe" -ArgumentList "/S" -PassThru



$Session = New-PSSession -ComputerName "lex-ws91053"
Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Win10 testing\iMed Win10 files\iMed 2017 installer\DiskSpd" -Destination "C:\Temp\DiskSpd" -ToSession $Session -Recurse


diskspd -d60 -c128M -t4 -o4 -b8k -L -Sh -w0 -r c:\disk-speed-test.dat


Turn ON RDP
Set-ItemProperty `HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\` -Name "fDenyTSConnections" -Value 0

BIOS UPDATE
$Session = New-PSSession -ComputerName "lex-KI****"
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BIOS\Dell 7440 1.15.0\" -Destination "C:\Temp\" -ToSession $Session -Recurse
Start-Process -Wait -FilePath "C:\Temp\Dell 7440 1.15.0.exe" -ArgumentList "/S" -PassThru




Restart-Computer -Force


Invoke-GPUpdate -Computer "CONTOSO\COMPUTER-02" -Target "User"