###########################Prompt User for Computer name Input
<#
TESTINGSILENCED $RemoteComputer = Read-Host -Prompt 'Input your computer  name'
TESTINGSILENCED Enter-PSSession $RemoteComputer
#>

###########################Grab Wireless NIC Model
<#
TESTINGSILENCED #$search = Get-WmiObject Win32_PnPSignedDriver -computer $RemoteComputer | select devicename | where {$_.devicename -ilike "*Intel(R)*Wireless*" -or $_.devicename -ilike "killer(r)*"} | where {$_.devicename -notlike "*Bluetooth*"} | where {$_.devicename -notlike "*Manage*"}
#>
 
#((((((AD CRALWING Part 1 Start))))))#
<#
$Doamin = Get-ADUser -Filter * -SearchScope Subtree -SearchBase "OU=Test,OU=Computers,OU=jack,DC=Corp,DC=jill,DC=com"
foreach ($Computer in $Domain) {
#>  
#((((((AD CRALWING Part 1 End))))))#


###############DEBUGGING ONLY#####################
$search = Get-WmiObject Win32_PnPSignedDriver | select devicename | where {$_.devicename -ilike "*Intel(R)*Wireless*" -or $_.devicename -ilike "killer(r)*"} | where {$_.devicename -notlike "*Bluetooth*"} | where {$_.devicename -notlike "*Manage*"}
###############DEBUGGING ONLY#####################

############################Search computer for wireless NIC cards that start with Intel.. and dont have Bluethooth
$result_split = $search -split "devicename=" ##Splits the string after "devicename=" the remaingn part of the string becomes $WirelessModel
$split_trim = $result_split.trim("@{").trim("}") #The @{} are trimmed from the variable
$Wireless_Model = $split_trim[1]

###############DEBUGGING ONLY#####################
#$Wireless_Model ='intel(r) wi-fi 6 xc201'
$Remote_Computer="LEX-LT1834"   #TESTINGALCTIVE
###############DEBUGGING ONLY#####################

  
$Logfile = 'T:\SoftwareLibrary\Standard\SomersetWifidrivers\IntelWiFiAlpha\WifiAdapterChanges.csv'
##############################Declare the groups and fill them with content
$19group = "intel(r) dual band wireless-ac 7265",
           "intel(r) dual band wireless-n 7265",
           "intel(r) wireless-n 7265",
           "intel(r) dual band wireless-ac 3168",
           "intel(r) dual band wireless-ac 3165"
$20group = "intel(r) dual band wireless-n 8260",
           "intel(r) dual band wireless-ac 8260",
           "intel(r) dual band wireless-ac 4165",
           "intel(r) dual band wireless-ac 8265",
           "intel(r) dual band wireless-ac 8275",
           "killer(r) wireless-ac 1435"
$21group = "intel(r) wi-fi 6 ax201",
           "intel(r) wireless-ac 9560 160MHz",
           "intel(r) wireless-ac 9461",
           "intel(r) wireless-ac 9462",
           "intel(r) wi-fi 6 ax101",
           "killer(r) wireless-ac 1550",
           "killer(r) wi-fi 6 ax1650",
           "intel(r) wireless-ac 9260",
           "intel(r) wireless-ac 9270",
           "intel(r) wireless-ac 9162",
           "intel(r) wi-fi 6 ax200",
           "killer(r) wi-fi 6 ax1650"

  If ($19group  -ilike $Wireless_Model)  {  
      $New_Driver = "netwtw04.inf"
      #>>>>>>>>>>>>>>>>>>>>>>>>>>START DRIVER IDENTIFY<<<<<<<<<<<<<<<<<<<<<<<<<#      
      Get-WmiObject Win32_PnPSignedDriver | 
      Where-Object {$_.devicename -eq $Wireless_Model} |
      ForEach-Object {
         if ($_.InfName -eq $New_Driver) {  
             Write-Output "Version is Current"
           } 
         else {
              $OriginalDriver = $_.InfName
              #Start-Process -FilePath "\\servername\share\share\Dell\Drivers\Dell 3630\Network Card\setup.exe" -ArgumentList '/s' -Wait -NoNewWindow
              #pnputil.exe /add-driver T:\SoftwareLibrary\Standard\SomersetWifidrivers\IntelWiFiAlpha\netwtw04.inf /install
              Echo "I would install here"  }}
       #>>>>>>>>>>>>>>>>>>>>>>>>>>END DRIVER IDENTIFY<<<<<<<<<<<<<<<<<<<<<<<<<#
 
      New-Object -TypeName PSCustomObject -Property @{
        Computer = $Remote_Computer
        NIC = $Wireless_Model
        AppliedDriver = $New_Driver
        OriginalDriver = $OriginalDriver
        Date = Date
                } | Export-Csv -Path $Logfile -NoTypeInformation -Append
	    
    }  
	
  ElseIf ($20group  -ilike $Wireless_Model)  {
      $New_Driver = "netwtw06.inf"
      #>>>>>>>>>>>>>>>>>>>>>>>>>>START DRIVER IDENTIFY<<<<<<<<<<<<<<<<<<<<<<<<<#      
      Get-WmiObject Win32_PnPSignedDriver | 
      Where-Object {$_.devicename -eq $Wireless_Model} |
      ForEach-Object {
         if ($_.InfName -eq $New_Driver) {  
             Write-Output "Version is Current"
           } 
         else {
              $OriginalDriver = $_.InfName
              #Start-Process -FilePath "\\servername\share\share\Dell\Drivers\Dell 3630\Network Card\setup.exe" -ArgumentList '/s' -Wait -NoNewWindow
              #pnputil.exe /add-driver T:\SoftwareLibrary\Standard\SomersetWifidrivers\IntelWiFiAlpha\netwtw04.inf /install
              Echo "I would install here"  }}
       #>>>>>>>>>>>>>>>>>>>>>>>>>>END DRIVER IDENTIFY<<<<<<<<<<<<<<<<<<<<<<<<<#
 
      New-Object -TypeName PSCustomObject -Property @{
        Computer = $Remote_Computer
        NIC = $Wireless_Model
        AppliedDriver = $New_Driver
        OriginalDriver = $OriginalDriver
        Date = Date
                } | Export-Csv -Path $Logfile -NoTypeInformation -Append
	    }  
  ElseIf ($21group  -ilike $Wireless_Model)  {
      $New_Driver = "netwtw08.inf"
      #>>>>>>>>>>>>>>>>>>>>>>>>>>START DRIVER IDENTIFY<<<<<<<<<<<<<<<<<<<<<<<<<#      
      Get-WmiObject Win32_PnPSignedDriver | 
      Where-Object {$_.devicename -eq $Wireless_Model} |
      ForEach-Object {
         if ($_.InfName -eq $New_Driver) {  
             Write-Output "Version is Current"
           } 
         else {
              $OriginalDriver = $_.InfName
              #Start-Process -FilePath "\\servername\share\share\Dell\Drivers\Dell 3630\Network Card\setup.exe" -ArgumentList '/s' -Wait -NoNewWindow
              #pnputil.exe /add-driver T:\SoftwareLibrary\Standard\SomersetWifidrivers\IntelWiFiAlpha\netwtw08.inf /install
              Echo "I would install here"  }}
       #>>>>>>>>>>>>>>>>>>>>>>>>>>END DRIVER IDENTIFY<<<<<<<<<<<<<<<<<<<<<<<<<#
 
      New-Object -TypeName PSCustomObject -Property @{
        Computer = $Remote_Computer
        NIC = $Wireless_Model
        AppliedDriver = $New_Driver
        OriginalDriver = $OriginalDriver
        Date = Date
                } | Export-Csv -Path $Logfile -NoTypeInformation -Append
	   }    
  Else {
      $New_Driver = "Not on List"
      New-Object -TypeName PSCustomObject -Property @{
        Computer = $Remote_Computer
        NIC = $Wireless_Model
        AppliedDriver = $New_Driver
        } | Export-Csv -Path $Logfile -NoTypeInformation -Append
  }

###############DEBUGGING ONLY#####################
<#
Import-Csv -Path $Logfile
#>
###############DEBUGGING ONLY#####################

#((((((AD CRALWING Part 2 Start))))))#
<#
}
#>
#((((((AD CRALWING Part 2 End))))))#