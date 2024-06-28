
$PC = Read-Host "What is the Computer Name"
$PC = "$PC.V09.MED.VA.GOV"
$global:OnlineUser = $null

function UsersActive($PC)
    {
    $Users = query user /server:$PC | ForEach-Object {
        (($_.trim() -replace ">" -replace "(?m)^([A-Za-z0-9]{3,})\s+(\d{1,2}\s+\w+)", '$1  none  $2' -replace "\s{2,}", "," -replace "none", $null))
        } | ConvertFrom-Csv
    $OnlineUser = $Users.USERNAME
    return $OnlineUser
    }

$global:OnlineUser = UsersActive($PC)


if ($OnlineUser){
   $yesno = Read-Host "Whould you like force user $OnlineUser off and remove the profile? y/n"
   if ($yesno -eq "y"){
      while ($OnlineUser){
      Write-Host "Logging off user: $OnlineUser"
      Logoff console /Server:$PC
      Write-host "Checking if user logged off now"
      $global:OnlineUser = UsersActive($PC)
      Write-host "Users successfully logged off"
      Write-host "Removing all Profiles"
      $AccountsToKeep = @('administrator','Public','default','DOMAIN\administrator')
      Get-CimInstance -ComputerName $PC -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -notin $AccountsToKeep } | Remove-CimInstance 
      }
      Write-host "Done"
    }
}
else{
    Write-Host "Removing All profiles"
    Get-CimInstance -ComputerName $PC -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -notin $AccountsToKeep } | Remove-CimInstance 
}




#Sources
#https://stackoverflow.com/questions/23219718/powershell-script-to-see-currently-logged-in-users-domain-and-machine-status
#https://superuser.com/questions/1186568/powershell-get-active-logged-in-user-in-local-machine
#https://www.techepages.com/how-to-force-logoff-a-user-in-powershell/#:~:text=In%20this%20Powershell%20tutorial%2C%20we%20have%20seen%20that,one%20or%20all%20users%20connected%20to%20the%20system
#https://community.spiceworks.com/topic/2203753-if-read-host-value-is-empty-repeat-the-same-question-until-value-is-not-null#:~:text=Try%20this%20for%20each%20of%20your%20variables.%20Powershell,and%20it%20will%20work%20most%20of%20the%20time.
#https://stackoverflow.com/questions/12535419/setting-a-global-powershell-variable-from-a-function-where-the-global-variable-n#:~:text=You%20can%20use%20the%20Set-Variable%20cmdlet.%20Passing%20%24global%3Avar3,%24b%29%20-Scope%20Global%20%7D%20foo%201%202%20var1



#Logoff $Computer -u $Users.USERNAME
#Below is boroowed but not used
<#
$Users = query user /server:$Computer 2>&1
$Users = $Users | ForEach-Object {
    (($_.trim() -replace ">" -replace "(?m)^([A-Za-z0-9]{3,})\s+(\d{1,2}\s+\w+)", '$1  none  $2' -replace "\s{2,}", "," -replace "none", $null))
} | ConvertFrom-Csv

foreach ($User in $Users)
{
    [PSCustomObject]@{
        ComputerName = $Computer
        Username = $User.USERNAME
        SessionState = $User.STATE.Replace("Disc", "Disconnected")
        SessionType = $($User.SESSIONNAME -Replace '#', '' -Replace "[0-9]+", "")
        
        $yesno = Read-Host "Whould you like force user $Username off and remove the profile? y/n"
        if ($yesno -eq "y"){
            Write-host "I would remove $Username"
            }
    }
         
}
#>


