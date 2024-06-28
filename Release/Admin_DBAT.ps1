<###>
#
# I created this script to read a file I call "Day Pass"
# In the "DayPass" file I have saved my Admin username and password from CyberArc for the day. Acutally it rotates every 48 hours at 7pm
# The script will connect to Mule 1 using the recored creditals.
#
# Created 17Aug2023
# Mainttained by Russell King
# Version: 1.0
#>

<#
#Here we are selecting where to read the DayPassFile from
Add-Type -AssemblyName System.Windows.Forms
$Filelocation = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$Filelocation.ShowDialog()
$PassFile = $Filelocation.Filename
$PassFileDir= (Get-Item $Filelocation.Filename ).DirectoryName
$LogFile = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Logs\DBAT.log" 
Write-Host "Selecting daypassfile:" $PassFile



$loadfile = Get-Content $PassFile
$splitfile = $loadfile -split "Username:" -split "Password:"
$username=$splitfile[1]
$password=$splitfile[3]

if ($password){
    #Now save the user and pass to the windows keychain
    #cmdkey /generic:dbat /user:$username /pass:$password
    $credential = New-Object System.Management.Automation.PSCredential ($username, $password)

    #Now connet
    $programPath = "\\vha.med.va.gov\cs\Production\Tools\VA\dBAT\dBAT.exe"
    Start-Process $programPath -Credential $credential -Verb runas
    
    #Now remove the user and pass from the keychain
    #cmdkey /delete:vhalexmul01a
    }

if ($username){
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$username,Success" | out-file $LogFile -Append
    }
else{
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Fail" | out-file $LogFile -Append
    }
#>

<#
Sources:
https://stackoverflow.com/questions/58538063/can-powershell-interact-with-rdp-prompts
https://stackoverflow.com/questions/32381042/powershell-prompt-for-would-you-like-to-continue
https://adamtheautomator.com/powershell-grep/
https://stackoverflow.com/questions/2085744/how-do-i-get-the-current-username-in-windows-powershell
https://www.script-example.com/en-powershell-logging
https://stackoverflow.com/questions/12503871/removing-path-and-extension-from-filename-in-powershell
#>




Add-Type -AssemblyName System.Windows.Forms
$Filelocation = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$Filelocation.ShowDialog()
$PassFile = $Filelocation.Filename
$PassFileDir= (Get-Item $Filelocation.Filename ).DirectoryName
$LogFile = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Logs\DBAT.log" 
Write-Host "Selecting daypassfile:" $PassFile



$loadfile = Get-Content $PassFile
$splitfile = $loadfile -split "Username:" -split "Password:"
$username=$splitfile[1]
#$password = $splitfile[3].ToString()
$password= "QI1TxblN=4Qv4mJ"
$password= ConvertTo-SecureString -String $password -AsPlainText -Force

#$credential = New-Object System.Management.Automation.PSCredential ($username, $password)
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
    #Now connet
    $programPath = "\\vha.med.va.gov\cs\Production\Tools\VA\dBAT\dBAT.exe"
    Start-Process %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -Credential $credential -Verb RunAs

    powershell.exe.exe /v:vhalexmul01a
    #$User = "Domain01\User01"
    #$PWord = ConvertTo-SecureString -String "P@sSwOrd" -AsPlainText -Force
    #$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $PWord
    

cmdkey /generic:dbat /user:$username /pass:$password

    #Now remove the user and pass from the keychain
    #cmdkey /delete:vhalexmul01a
    }

if ($username){
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$username,Success" | out-file $LogFile -Append
    }
else{
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Fail" | out-file $LogFile -Append
