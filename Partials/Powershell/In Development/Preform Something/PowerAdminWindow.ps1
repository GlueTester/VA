
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


#Here we are selecting where to read the DayPassFile from
Add-Type -AssemblyName System.Windows.Forms
$Filelocation = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$Filelocation.ShowDialog()
$PassFile = $Filelocation.Filename
$PassFileDir= (Get-Item $Filelocation.Filename ).DirectoryName
$LogFile = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Logs\PowerShell.log" 
Write-Host "Selecting daypassfile:" $PassFile

$loadfile = Get-Content $PassFile
$splitfile = $loadfile -split "Username:" -split "Password:"
$username=$splitfile[1]
$password=$splitfile[3]






if ($password){
    #Now save the user and pass to the windows keychain
    #cmdkey /generic:powershell /user:$username /pass:$password
    
    $Secure_String_Pwd = ConvertTo-SecureString $password -AsPlainText -Force
    $encpwd = ConvertFrom-SecureString $Secure_String_Pwd
    #$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
    #$psCred = Get-StoredCredential -Target "CGSPS1"
    $reguser = whoami
    ntrights.exe +r SeImpersonatePrivilege -u $reguser

    $cred = new-object System.Management.Automation.PSCredential "VHA09\$username",$Secure_String_Pwd 
    Start-Process PowerShell -Cred $cred -ArgumentList '-noexit','-File', '\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\One Note Scripts\Slow_Check.ps1'

       
    #$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
    #Import-Module MSOnline
    #Connect-MSolService -Credential $psCred
    #$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection 
    #Import-PSSession $Session -AllowClobber -DisableNameChecking
   

    #Now connet
    #Start-Process C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe -verb runas /generic:powershell
    
    #Now remove the user and pass from the keychain
    #cmdkey /delete:vhalexmul01a
    }

if ($username){
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$username,Success" | out-file $LogFile -Append
    }
else{
    "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Fail" | out-file $LogFile -Append
    }
