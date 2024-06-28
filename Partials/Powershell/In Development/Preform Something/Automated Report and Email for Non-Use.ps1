# The logical process: 
#       1.Find all systems in OU that are LT (save as an array)
#       2.Ping system (save array if reply and no reply) [save to reply and non reply list]
#       3.Find last logged in user of each system, extracter SAMS account and date
#       5.Gather information about SAM account
#       6.Email user policy letter
#       7.Send list of EE emails send and not found to IMS
#       8.Save log information to log dirs (in seperate and aggrugates list)




function Get-LastLogin{
##
$LTList_Array = @()
$NewComputerDomainName = Get-ADComputer -Filter "Name -like '*$NewEE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov' | Select -ExpandProperty Name
$NewMachineStatsDir= "Y:\Public\LogonScripts\Lognoff$\machinestats\$NewComputerDomainName.log"
$NewMachineLogSearch = Get-Content -tail 1 $NewMachineStatsDir | Select-String -Pattern "$SamAccount" #https://www.techepages.com/how-to-get-the-last-line-of-a-file-using-powershell/#:~:text=The%20command%20to%20fetch%20the%20last%20line%20of,sample.txt%20from%20under%20d%3Atest_folder_1%2C%20the%20command%20will%20become%3A

Write-Host $NewComputerDomainName
Write-Host $NewMachineStatsDir
Write-Host $NewMachineLogSearch

$SamAccount =$SamAccount[0] #MANUALK IMOUT BECUSE USING TECH

}

function Get-SamAccountInfo{
#$GetUserInfo= Get-ADUser -Identity "$SamAccount"-Properties Title | Select-Object Title,GivenName,SurName
$GetEmail= (Get-ADUser -Identity "$SamAccount").UserPrincipalName
$GetTitle= (Get-ADUser -Identity "$SamAccount"-Properties Title).Title
$GetFirstName= (Get-ADUser -Identity "$SamAccount").GivenName
$GetLastName= (Get-ADUser -Identity "$SamAccount").Surname
}



function AccountInfo{
	$site=Read-Host "Please choise information you have about user"
	Switch ($site)
	{
		S {$Choseninfo="SAMS Account"}
		N {$Choseninfo="Firstname Lastname"}
		}
    return $Chosensite
}



#[CmdletBinding()]
#PARAM (
#[Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
#[String[]]$ComputerName = $env:ComputerName
#)

$MachineStatsDir = "\\v09.med.va.gov\LEX\Workgroup\Public\LogonScripts\Lognoff$\machinestats\"
$SaveDir = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Scans\"
$OU = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"    #OU to scan
$OUComputerList=(Get-ADComputer -Filter 'Name -like "LEX-LT*"' -SearchBase $OU -Properties Name| Select-Object Name).Name
$CurrentDate = Get-Date -Format "yyyyMMdd"
$CurrentDate = $CurrentDate.ToString()




#Takes each computer foudn in OU and runs the following code:
ForEach ($Computer in $OUComputerList) {
    $MachineLogFile = $MachineStatsDir+"$Computer.log"
        
    if ($MachineLogFile) {
    #$MachineStatsDir = "Y:\Public\LogonScripts\Lognoff$\machinestats\$ComputerName.log"
    $LastLogin = Get-Content -tail 1 $MachineLogFile 
    $parts = $LastLogin.split(' ')
    $SAMSACC = $parts[0];$IP = $parts[3].Trim("IP=");$LastDate = $parts[8]
    $Join =  $Computer+','+$SAMSACC+','+$IP+','+$LastDate
    $Join | Out-File "$SaveDir\PCScan_$CurrentDate.csv" -Append
    }
        
    if (!$Computer) { 
    Write-host $EE "NO in log file for $Computer"
    }
        
    elseif (test-connection $Computer -count 1 -quiet) {
    Write-host $Computer "Ping succeeded. $LastLogin" -foreground green
               
        
    } else {
    Write-host $Computer "Ping failed. $LastLogin" -foreground red
    }

    #$Computer | export-csv -Path "$SaveDir\PCScan_$CurrentDate.csv" -NoTypeInformation -Append | Select-Object -Skip 1 #testsed to here and not gettign right field

    





$ComputerStatsFile = "Y:\Public\LogonScripts\Lognoff$\machinestats\$Computer.log"
$MachineLastLogin = Get-Content -tail 1 $ComputerStatsFile  | Select-String -Pattern "$SamAccount" #https://www.techepages.com/how-to-get-the-last-line-of-a-file-using-powershell/#:~:text=The%20command%20to%20fetch%20the%20last%20line%20of,sample.txt%20from%20under%20d%3Atest_folder_1%2C%20the%20command%20will%20become%3A

Write-Host $NewComputerDomainName
Write-Host $NewMachineStatsDir
Write-Host $NewMachineLogSearch

$SamAccount =$SamAccount[0] #unsure herer Comment was(MANUALK IMOUT BECUSE USING TECH)
} #End ForEach Computer





#EMAIL STEP
function Email-IMS{

    #create COM object named Outlook
    $Outlook = New-Object -ComObject Outlook.Application 
    
    #create Outlook MailItem named Mail using CreateItem() method
    $Mail = $Outlook.CreateItem(0)
    
    #add properties as desired
    $Mail.To='russelltking@gmail.com' #testing
    #$Mail.To='vhalex.imsmobile@va.gov' #actual
    $Mail.Subject="'Laptop $Status EE:$EE"
    if ($Status -notmatch "New"){
        $Mail.Body=(
        "Type Of Deplyment: $Status
        New EE: $NewEE
        Old EE: $OldEE 
    
        Full name: $ComputerDomainName
        User Name: $GetFirstName $GetLastName
        User Email: $GetEmail
        User SAM Account Name: $SamAccount
    
        Did user Log in New Machine: $UserLoggedinNewmachine 
        Did user Log in Old Machine: $UserLoggedinOldmachine
        Last Login New Machine: $NewMachineLogSearch 
        Last Login Old Machine: $OldMachineLogSearch
        
        Deployed By:$env:UserName")
    }
    else
    {
        $Mail.Body=("Type Of Deplyment: $Status `n
        New EE: $NewEE
        Full name: $ComputerDomainName `n 
        User Name: $GetFirstName $GetLastName `n
        User Email: $GetEmail `n
        User SAM Account Name: $SamAccount `n
        Did user Log in New Machine: $UserLoggedinNewmachine `n 
        Last Login New Machine: $NewMachineLogSearch")
    }
    #********https://stackoverflow.com/questions/33751194/powershell-email-how-to-add-new-line-in-email-body
    
    
    #send message
        #$Mail.Send()
    Write-Host $Mail.To
    Write-Host $Mail.Subject
    Write-Host $Mail.Body
    
    #quit and cleanup
    $Outlook.Quit()# [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Outlook) | Out-Null
    $Mail.Body=""
    }









#####NOTES
###find user in log file
#$MachineLogSearch = Select-String -Path $MachineStatsDir -Pattern "VHALEXCHRISR"                #********************https://stackoverflow.com/questions/41871147/find-specific-string-in-textfile
##$MachineLogSearch = Get-Content -tail 1 $MachineStatsDir | Select-String -Pattern "$SamAccount" #https://www.techepages.com/how-to-get-the-last-line-of-a-file-using-powershell/#:~:text=The%20command%20to%20fetch%20the%20last%20line%20of,sample.txt%20from%20under%20d%3Atest_folder_1%2C%20the%20command%20will%20become%3A


####----------------Email the inputs------------------------#########


