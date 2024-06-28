$PrinterName = Read-Host "Printer Name?"
 $printsearch = [System.Collections.ArrayList]@()
 $PrintServers = "vhalexprt1.v09.med.va.gov","vhalexprt3.v09.med.va.gov","vhalexprt4.v09.med.va.gov"
  foreach ($i in $PrintServers){
($result = (get-printer -ComputerName $i |  Where-Object {($_.Name -like '*'+$PrinterName+'*')}) |  ForEach-Object { '{0}, {1}, {2}' -f $_.Name, $_.ComputerName, $_.PortName }) -join [environment]::NewLine} 


#EXPANDING ON THIS######################
#Techs need IP or hostname
#User will supply an EE
# Datbases had been used to corilate between these but
# I was able to locate what I thought the printer was (using nearby room numbers of printer on the print server)
    #I then open the web port and looked at details to see serial number
    #With serial number I serached vista and got EE
    # I now have vailated the correct IP from EE



########GRAB all stuff from printer server###########
# Get-Printer -ComputerName "vhalexprt1" | Format-List Name,ComputerName,PortName,DriverName,Location,Comment




###Change Comments of printer###READY
<#
$PrinterName = Read-Host "Printer Name?"
$Printer = (get-printer -ComputerName "vhalexprt4.v09.med.va.gov" |  Where-Object {($_.Name -like $PrinterName)})
$PrinterSerial = "7HB306353"
$PrinterMAC = "9c:93:4e:f4:29:3c"
$PrinterEE = "112515"
$Printer.Comment = "S/N: $PrinterSerial
MAC: $PrinterMAC
EE: $PrinterEE"
Set-Printer -InputObject $Printer
#>
###Change Comments of printer###READY






 #note yet formating well 
 #|Format-Table -Property $.Name, $.ComputerName  #https://stackoverflow.com/questions/66457093/how-to-expand-multiple-properties-when-output-contains-value1-xxx-value1-yy

 #$arrayID = $printsearch.Add($result)
 



<#
			$PrinterName = Read-Host "Printer Name?"
			$printsearch = [System.Collections.ArrayList]@()
			$PrintServers = "vhalexprt1.v09.med.va.gov","vhalexprt3.v09.med.va.gov","vhalexprt4.v09.med.va.gov"
			 foreach ($i in $PrintServers){
 ($result = (get-printer -ComputerName $i |  Where-Object {($_.Name -like '*'+$PrinterName+'*')}) |  ForEach-Object { '{0}, {1}, {2}' -f $_.Name, $_.ComputerName, $_.PortName }) -join [environment]::NewLine}




 
#$Useremail="Allyson.Gabbard@va.gov"
$CUPSURL='https://10.205.151.16:631/printers/?QUERY'+$PrinterName
$webrequest = Invoke-WebRequest -Uri "$CUPSURL"
$r = Invoke-WebRequest -Uri "https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov"
$h = $webrequest.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
$h = $webrequest.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
$s = $h -split "Display Name" -split "Mail" -split "User Principal Name" -split "Last Updated" -split "License Attribute Value" -split "Account Enabled"
$License= $s[5]
$LastUpdated= $s[4]
$AccountEnabled= $s[6]

Write-Host "Users License: $License
Last Update: $LastUpdated
AccountEnabled = $AccountEnabled
"
}

Office365Check($SAMUsername)


###------------
add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
            return true;
        }
 }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy


$Known = Read-Host "Printer Name?"
$printsearch = [System.Collections.ArrayList]@()
$PrintServers = "vhalexprt1.v09.med.va.gov","vhalexprt3.v09.med.va.gov","vhalexprt4.v09.med.va.gov"
foreach ($i in $PrintServers){
     $result = (get-printer -ComputerName $i |  Where-Object {($_.Name -like '*'+$Known+'*')})
     $arrayID = $printsearch.Add($result)
}

$PrinterName= $printsearch | Select-Object -ExpandProperty 'Name'
$CUPSURL='https://10.205.151.16:631/printers/?QUERY'+$PrinterName
$webrequest = Invoke-RestMethod "$CUPSURL" 1
$HTML -match '<TBODY>'


VHALEXARMSTS
#>