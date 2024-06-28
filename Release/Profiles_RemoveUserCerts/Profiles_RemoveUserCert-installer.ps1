<###>
#
# This will grab the newest versio nof the Remove Users script
#
#
# Created 04DEC2023
# Mainttained by Russell King
# Version: 0.10
#>

#Provide to end tech

#Variables
$ScriptName="Profiles_RemoveUserCerts"
$Version = "v.10"
$ScriptPath = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Profiles_RemoveUserCerts\$Version\"
$Script = $ScriptName+"_"+$Version+".ps1"

#Create C:\temp if it doesnt exist
$path = "C:\temp"
if(Test-Path -Path $path){  
  #If path exist, do nothing 
}else{
    New-Item -Path $path -ItemType Directory    
}

#Replace or create scripts in tempfolder
$Tempdir = "C:\temp\"
if (Test-Path "$Tempdir\$ScriptName*") {
  Remove-Item "$Tempdir\$ScriptName*"
  Copy-Item $ScriptPath$Script -Destination "$Tempdir\$Script"
}else{
  Copy-Item $ScriptPath$Script -Destination "$Tempdir\$Script"
}

#Make The shortcut on the desktop
$Desktop = [Environment]::GetFolderPath("Desktop")
$Linkfile = "$ScriptName*.lnk"
if (Test-Path "$Desktop\$Linkfile") {
  Remove-Item "$Desktop\$Linkfile"
  $LinkFile = "$ScriptPath$ScriptName"+"_$Version.lnk"
  Copy-Item $LinkFile -Destination $Desktop
}else{
  $LinkFile = "$ScriptPath$ScriptName"+"_$Version.lnk"
  Copy-Item $LinkFile -Destination $Desktop
}