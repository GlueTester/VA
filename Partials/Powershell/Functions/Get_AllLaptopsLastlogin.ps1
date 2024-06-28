    <# The logical process: 

#> 
function Get-SamAccountInfo{
    param(
        [string] $SamAccount
    )
    try {
        
        $SamUserInfo= Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue -Properties Title | Select-Object GivenName,SurName,UserPrincipalName,Title
        #$SamEmail= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue).UserPrincipalName
        #$SamTitle= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue -Properties Title).Title
        #$SamFirstName= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue).GivenName
        #$SamLastName= (Get-ADUser -Identity "$SamAccount" -ErrorAction SilentlyContinue).Surname
        return $SamUserInfo

    }
     catch {
      Write-Output $_.Exception.Message
    }
   
}
    function IsIpAddressInRange { 
        <#
        Source: 
            https://stackoverflow.com/questions/8365537/checking-for-a-range-in-powershell
        Usage
            PS> IsIpAddressInRange "192.168.0.5" "192.168.0.10" "192.168.0.20"
            False
            PS> IsIpAddressInRange "192.168.0.15" "192.168.0.10" "192.168.0.20"
            True
        Explain:
            First variabl is thing to check
            Secone variable is beggingin of range
            Third variable is end of range
        #>
        param(
                [string] $ipAddress,
                [string] $fromAddress,
                [string] $toAddress
            )
        
            $ip = [system.net.ipaddress]::Parse($ipAddress).GetAddressBytes()
            [array]::Reverse($ip)
            $ip = [system.BitConverter]::ToUInt32($ip, 0)
        
            $from = [system.net.ipaddress]::Parse($fromAddress).GetAddressBytes()
            [array]::Reverse($from)
            $from = [system.BitConverter]::ToUInt32($from, 0)
        
            $to = [system.net.ipaddress]::Parse($toAddress).GetAddressBytes()
            [array]::Reverse($to)
            $to = [system.BitConverter]::ToUInt32($to, 0)
        
            $from -le $ip -and $ip -le $to
        }

    function EasyRead{
        param(
            [string] $Status,
            [string] $StatusTextColor,
            [string] $Comment,
            [string] $CommentTextColor
        )
        switch ($Status.Trim()) {
            "" {  $Status = "     " }
            "OK" { $Status = " OK  "}
            "FAIL" { $Status = " FAIL "}
            Default {}
        }
        Write-Host "[ $Status ]" -fore $StatusTextColor -nonewline; Write-Host "      - $Comment " -fore $CommentTextColor
    
        <#
        Usage:
            EasyRead "OK" "green" "this is a test" "white"
        #>
    }
        

    $MachineStatsDir = "\\v09.med.va.gov\LEX\Workgroup\Public\LogonScripts\Lognoff$\machinestats\"
    $LogDir = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Scans\Logins\"
    $NoLogDir = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Scans\NoLogins\"
    $OUtoSearch = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"    #OU to scan
    $ComputerList=(Get-ADComputer -Filter 'Name -like "LEX-LT*"' -SearchBase $OUtoSearch -Properties Name| Select-Object Name).Name
    $CurrentDate = Get-Date -Format "yyyyMMdd"
    $CurrentDate = $CurrentDate.ToString()
    $tailcount = 1 #Number oentries to search back for each computer
    
    $Header = "System,Last IP,Time,Date,Email"
    Set-Content "$LogDir\LTLogins_$CurrentDate.csv" -Value $Header
    #Add-Content -Path "$LogDir\LTLogins_$CurrentDate.csv" -Value $Data
    #    $obj | Export-CSV -NoTypeInformation -Path "$LogDir\LTLogins_$CurrentDate.csv"
    
    
    clear #Clears screen, cleanup
    EasyRead "   " "white" "Checking For List Of LTs in $OUtoSearch" "white" #Displays output so user know its started
   
    #Ensure a computer list is retrived befor contiuneing
    If ($ComputerList){
        $ComputerListCount = $ComputerList.Count
        EasyRead "OK" "green" "Found $ComputerListCount Laptops Total" "white" 
        
        # Each computer found that was in the OU, run this below code
        ForEach ($Computer in $ComputerList) {
            $PCLogStatsFile = $MachineStatsDir+"$Computer.log" #Take machine stats dir and join computer name to end
            $MostRecent= $null   #clear varaible for loop
            if (Test-Path $PCLogStatsFile){
                $LastXLogEntrys = Get-Content -tail $tailcount $PCLogStatsFile 
                ForEach ($X in $LastXLogEntrys){
                    $parts = $X.split(' ')
                    $LastIP = $parts[3].Trim("IP=").Trim() #grabs IP from log
                    $LastDate = $X.split('@ ')[1]
                    $LastDate = $LastDate -replace "^ ", "0" #if timestamp is befor noon this removes the space and adds a 0
                    $LastLoginTime = $LastDate.split('.')[0]
                    $LastLoginDayofWeek = $LastDate.split('.')[1]
                    $LastLoginDate = $LastDate.split(' ')[2]
                    $SamAccount = $parts[0]
                    $ResolvedUserInfo = Get-SamAccountInfo($SamAccount)
                    #Source: https://stackoverflow.com/questions/41426931/replace-first-character-in-string#:~:text=This%20happens%20as%20String.Replace%20%28%29%20will%20replace%20all,Like%20so%2C%20%24_.mobile%20%3D%20%24_.mobile%20-replace%20%22%5E0%22%2C%20%22%2B46%22


                    #Search the IP to see if is contains 10.74, if not then log it
                    $SamUserInfo.UserPrincipalName
                    $MostRecent = "$Computer,$LastIP,$LastLoginTime,$LastLoginDate,"+$ResolvedUserInfo.UserPrincipalName
                    $MostRecent | Out-File "$LogDir\LTLogins_$CurrentDate.csv" -Append

                        
                }
                    
            }
            
            else {
                EasyRead "FAIL" "red" "$Computer  - No log file ever created!" "white"
                $Content = "$Computer,No log file ever created"
                $Content | Out-File "$NoLogDir\NoLogins_$CurrentDate.csv" -Append
            }
            
                if ($MostRecent){
                $MostRecent
        }  
        }
    }
    else {
        EasyRead "FAIL" "red" "Can NOT find computers in $OUtoSearch" "white"<# Action when all if and elseif conditions are false #>
    }
