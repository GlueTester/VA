<###>
#
# This will grab the newest versio nof the Mule_RDP script
#
#
# Created 24Aug2023
# Mainttained by Russell King
# Version: 0.11
#>

#Provide to end tech

#Variables
$Version = "v.11"
$ScriptPath = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Mule1_RDP\$Version\"
$Script = "Mule1_RDP_$Version.ps1"

#Create C:\temp if it doesnt exist
$path = "C:\temp"
if(Test-Path -Path $path){  
  #If path exist, do nothing 
}
else{
    New-Item -Path $path -ItemType Directory    
}

#Replace or create Mule1_RDP scripts in tempfolder
$Tempdir = "C:\temp\"
$AnyRDPscript = "Mule1_RDP*.ps1"
if (Test-Path $Tempdir$AnyRDPscript) {
  Remove-Item $Tempdir$AnyRDPscript
  Copy-Item $ScriptPath$Script -Destination $Tempdir$Script
}
else{
  Copy-Item $ScriptPath$Script -Destination $Tempdir$Script
}

#Make The shortcut on the desktop
$Desktop = [Environment]::GetFolderPath("Desktop")
$AnyLinkfile = "Mule1_RDP*.lnk"
if (Test-Path "$Desktop\$AnyLinkfile") {
  Remove-Item "$Desktop\$AnyLinkfile"
  Copy-Item $ScriptPath"Mule1_RDP*.lnk" -Destination $Desktop
}
else{
  Copy-Item $ScriptPath"Mule1_RDP*.lnk" -Destination $Desktop
}