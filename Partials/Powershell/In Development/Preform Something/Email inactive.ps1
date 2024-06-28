#
#Created adn maintained by Russell King 19DEC2023
#Purpose: 
#   Find all system in AD that have not bee usedin X days
#   Check login stats to see last Y users that logged into system
#   Email each of thoese users the templat in $Mail.Body with system information
#Tunables: 
#   For Testing (outpu tto just local screen)
#       Place comment on line $Mail.Send() this was line XX at time of writeing.
#   For Internal testing (Output to defined email):   
#       
#   For Actual (email each user)
#

$Testing = Read-Host "Please enter 0 for real, 1 for testing" #0 is actual last user email, 1 is local screen only
$CustomEmail = "nullemail"
if ($Testing -match 1){
    $CustomEmail = Read-Host "Please enter full email to send all emails to"
    }
import-module activedirectory 
$logdate = Get-Date -format yyyyMMdd
$logfile = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Scans\"+$logdate+".csv"
$LoginThreshold = 15 #amount of log entries to grab from end of log file
$DaysInactive = 45 #thresold to sort out computer from AD by login 
$time = (Get-Date).Adddays(-($DaysInactive)) #defines current day adn subtracts DaysInactive variable
 
# Change this line to the specific OU that you want to search
$searchOU = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"


#FUNCTIONS
function Get-SamAccountInfo($SamAccount){
    try {
        
        $SamUserInfo= Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue -Properties Title | Select-Object Title,GivenName,SurName
        $SamEmail= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue).UserPrincipalName
        $SamTitle= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue -Properties Title).Title
        $SamFirstName= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue).GivenName
        $SamLastName= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue).Surname
        return $SamEmail

    }
     catch {
      Write-Output $_.Exception.Message
    }
}


#EMAIL STEP
function Email_User($UserEmail){
    
    #create COM object named Outlook
    $Outlook = New-Object -ComObject Outlook.Application 
    
    #create Outlook MailItem named Mail using CreateItem() method
    $Mail = $Outlook.CreateItem(0)
    #This will sent this email if no flag have be throwing changeding the variable $Status to anything other than "Vaild"
    if ($Status -match "Vaild"){
        switch ($Testing)
        {
            0 {$Mail.To = $UserEmail }
            1 {$Mail.To = $CustomEmail }
        }

        if ($Testing -match 0){
         $Mail.To= $UserEmail
        } 
        $Mail.Subject="Inactive VA System $Hostname"
        $Mail.Body=("
System Name: $Hostname
EE:          $EE

    You are receiving this email because the system listed above has not been logged into since $Stamp. All VA network assets must be logged into at least once every 45 days or the asset will be terminated. As such, this email servers as a reminder and is being sent to you because you are amoung the last user account(s) to have logged into the asset. Logging into the machine before $LastDay will stop the Termination process from occurring.

    If not logged into by immediately and the termination process completes due to non-use, the following will need to be provided by your supervisor before a new asset can be deployed/issued:
        Explanation:
            Reason for non-use-
            Justification for new asset:
            Business reason/need for asset-
            How many users will be using the asset-
            Expected amount of usage in hours per day for the new asset-
            Will this asset be logged into at a minimum once every 45 days going forward to avoid termination again-
            ServiceNow/YourIT ticket submitted requesting new asset and Request ticket number=
    
    Should you have any concerns or questions, please contact:
                        Joshua Mulholland x5820 (Bowling Site Supervisor)
                        Daniel Lewis x2468 (Sousley site Supervisor)
        
Thank You
Area Lexington OIT
        ")
        }
    
    
    else #This is the email sent if the $Status variable is anything other than "Vaild"
    {
        $Mail.To = $CustomEmail 
        $Mail.Subject="Report - Inactive System Scan Fault: $EE : $Status"
        $Mail.Body=("Hostname:$Hostname `n
        Status:  $Status")
    }
    
    
    
    #send message
    #
    if ($Testing -match 0){
        Write-Host $Mail.To
        Write-Host $Mail.Subject
        $Mail.Send()
    }
    
    if ($Testing -match 1){
        Write-Host $Mail.To
        Write-Host $Mail.Subject
        Write-Host $Mail.Body
    }
    
    #quit and cleanup
    #$Outlook.Quit()# [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Outlook) | Out-Null
    #$Mail.Body=""
    }

function LastXUsers($HostName){
    if ($ComputerStatsFile = "\\v09.med.va.gov\LEX\Workgroup\Public\LogonScripts\Lognoff$\machinestats\$HostName.log") {
        try {
            $File = Get-Content -tail $LoginThreshold $ComputerStatsFile -ErrorAction SilentlyContinue
            #Source #https://stackoverflow.com/questions/24044226/powershell-remove-text-after-first-instance-of-special-character
            $Trim = $File -replace '(.+?) .+','$1' #trims to just last X logins loginsouts
            $LastUsers= $trim | Select-Object -uniq
            foreach ($SamAccount in $LastUsers){
                $UserEmail = Get-SamAccountInfo($SamAccount) #Gets user in from from AD and reports back the user email
                If ($UserEmail -imatch "@"){
                $Status = "Vaild"
                #$TimeRemaining = 45-
                Email_User($UserEmail) #Calls Email_User Fuction and passes the eamil variable to it
                }
                else {
                    Write-Host $UserEmail   
                    $Status = "No user email for $SamAccount"
                }
            }
            
        }
        catch {
        Write-Output $_.Exception.Message
        }
    }
    else {
        #Write-Host "$HostName has no log file"
        $Status = "$HostName has no log file"
    }}


# Get all AD computers with LastLogon less than our time
$ADScan = Get-ADComputer -SearchBase $searchOU -Filter {LastLogon -lt $time -and enabled -eq $true} -Properties LastLogon, description|select-object Name,DistinguishedName, description, enabled,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.LastLogon)}}
$ADScan | export-csv $logfile -notypeinformation

#return $LastUsers
For ($i = 0; $i -lt $ADScan.Count; $i++){
    $HostName = $ADScan.Name[$i]
    $EE = $ADScan.Name[$i] -split '(?=\d)',2 ;$EE =$EE[1]
    $Stamp = $ADScan.Stamp[$i]
    $LastDay = ($Stamp).AddDays(45)
    switch -Wildcard ($HostName){
    "LEX-WS*" {"$HostName :" ; LastXUsers($HostName) }
    "LEX-LT*" {"$HostName :" ; LastXUsers($HostName) }
    "LEX-MA*" {"$HostName :" ; LastXUsers($HostName) }
    "LEX-SP*" {"$HostName :" ; LastXUsers($HostName) }
    Default {
        #""
    }

    }

}




#### Sources
<#
https://stackoverflow.com/questions/13318382/how-do-i-dynamically-add-elements-to-arrays-in-powershell
https://shellgeek.com/get-aduser-erroraction/#:~:text=If%20you%20use%20the%20Get-ADUser%20ErrorAction%20parameter%20in,%7B%20Write-Output%20-Verbose%20%22User%20does%20not%20exist%21%22%20%7D
https://www.bing.com/search?pglt=161&q=powershell+if+variabel+doesnt+not+contain&cvid=29f4e54ea2794ae8886eab9d11b06218&aqs=edge..69i57.11629j0j1&FORM=ANNAB1&PC=U531
https://stackoverflow.com/questions/27970441/powershell-string-does-not-contain
https://stackoverflow.com/questions/26063495/powershell-split-string-at-first-occurrence-of-a-number
*https://stackoverflow.com/questions/33751194/powershell-email-how-to-add-new-line-in-email-body
#>



####Non Used fragments
<#

$ComputerStatsFile = "W:\Public\LogonScripts\Lognoff$\machinestats\$Computer.log"
$MachineLastLogin = Get-Content -tail 5 $ComputerStatsFile  | Select-String -Pattern "$SamAccount"
https://stackoverflow.com/questions/60637210/powershell-foreach-on-two-arrays



Foreach ($HostName in $ADScan.Name){
    $EE = $EE = $HostName -split '(?=\d)',2 ;$EE =$EE[1]
    $Stamp = $ADScan.Stamp[$HostName]
    Write-Host "$EE and $Stamp"
    switch -Wildcard ($HostName){
    "LEX-WS*" {"$HostName :" ; LastXUsers($HostName,$Stamp) }
    "LEX-LT*" {"$HostName :" ; LastXUsers($HostName,$Stamp) }
    "LEX-MA*" {"$HostName :" ; LastXUsers($HostName,$Stamp) }
    "LEX-SP*" {"$HostName :" ; LastXUsers($HostName,$Stamp) }
    Default {
        #""
    }

    }

}

#>