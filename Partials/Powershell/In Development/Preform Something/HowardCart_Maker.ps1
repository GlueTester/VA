#Setup name and connection
$EE = Read-Host "What Cart EE"
$PC = "LEX-MA$EE"
$Session = New-PSSession -ComputerName $PC

#Move in AD

#Run Fix it script
#Run fizit script
#Put name in text file <---WHY?
#Write-host $PC | "out-file  \\v09.med.va.gov\lex\IMS\+ Hardware Team\Scripts\Testing\Files\PCList.txt" -Append

#Run EndBCMA script (Run as admin) <---WHY?
#  "\\v09.med.va.gov\lex\IMS\+ Hardware Team\Scripts\Testing\Files\EndBCMA.cmd"

#Copy the Cart tools
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BCMA Howard Cart\" -Destination "C:\Temp\" -ToSession $Session -Recurse

#Copy Wireless fodler to root of C:
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BCMA Howard Cart\Wireless\" -Destination "C:\" -ToSession $Session -Recurse


#Chaneg driverts for smartcard
if (pnputil /enum-devices /instanceid "SWD\ScDeviceEnum\2_Broadcom_Corp_Contacted_SmartCard_0"){
    pnputil /add-driver "C:\temp\BCMA Howard Cart\SCR3xx_driver_ver_4.67\SCR3XX.inf" /install /instanceid "SWD\ScDeviceEnum\2_Broadcom_Corp_Contacted_SmartCard_0"
}




• Open Cart USB to Serial folder. 
		○ Located in c:\temp 
• Run CDM21224_Setup (As admin) 
•


#Copy Wifi Tool to public desktop
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BCMA Howard Cart\Wireless\WiFiTool.lnk" -Destination "C:\Users\Public\Desktop\" -ToSession $Session -Recurse


• Double click on “Wifi Tool” that should now be on the desktop.  
• Click “pause” twice. 
• Click “Show Netsh” 
• Save document and close “Wifi Tool”. 


#Copy the Setup files files to Public Desktop
Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BCMA Howard Cart\Med Display 4.0.0.11\Installer\x64\*.*" -Destination "C:\Users\Public\Desktop\" -ToSession $Session -Recurse



○ Look up machine in dbat to confirm Baseline and Tier 3/4 are correct.  

Start-Process "C:\temp\BCMA Howard Cart\Med Display 4.0.0.11\MedDisplay.msi"



#Sources
#https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/pnputil-examples
#https://learn.microsoft.com/en-us/answers/questions/1290865/change-a-driver-via-powershell-or-cmd
