<###>
#
# I created this script to read a file I call "Day Pass"
# In the "DayPass" file I have saved my Admin username and password from CyberArc for the day. Acutally it rotates every 48 hours at 7pm
# The script will connect to Mule 1 using the recored creditals.
#
# Created 23Aug2023
# Mainttained by Russell King
# Version: 1.0
#>

#Provide to end tech
#Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Mule1_RDP\*.lnk" -Destination "$Home\Desktop\Mule1_RDP.lnk" ; Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Mule1_RDP\*.ps1" -Destination "C:\temp\Mule1_RDP.ps1"


#Create C:\temp if it doesnt exist
$path = "C:\temp"
if(Test-Path -Path $path){
       
}
else{
    New-Item -Path $path -ItemType Directory
     
}

#Ensures you have most current version
if ("C:\temp\Mule1_RDP*.ps1"){
    Remove-Item "C:\temp\Mule1_RDP*.ps1"
}
Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Mule1_RDP\*.ps1" -Destination "C:\temp\" -Recurse

#Copy the Shorcut to Desktop
Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Mule1_RDP\*.lnk" -Destination "$Home\Desktop\Mule1_RDP.lnk" 

#Here we are selecting where to read the DayPassFile from
Add-Type -AssemblyName System.Windows.Forms
$Filelocation = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$Filelocation.ShowDialog()
$PassFile = $Filelocation.Filename

# To use a static location for your file, just comment lines 36-39 and uncomment this one
#$PassFile= "C:\Users\Desktop\dailypass.txt"

#Write to log file
$LogFile = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Logs\Admin_RDP.log" 

$loadfile = Get-Content $PassFile
$splitfile = $loadfile -split "Username:" -split "Password:"
$username=$splitfile[1]
$password=$splitfile[3]

if ($password){
    #Now save the user and pass to the windows keychain
    cmdkey /generic:vhalexmul01a /user:$username /pass:$password
    
    #Now connet
    mstsc.exe /v:vhalexmul01a
    
    }

if ($username){
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$username,Success" | out-file $LogFile -Append
    }
else{
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Fail" | out-file $LogFile -Append
    }