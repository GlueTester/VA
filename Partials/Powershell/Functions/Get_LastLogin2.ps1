function Get_LastLogin($EE) {
$Computer = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'

 

    $pcinfo = Get-ADComputer $Computer.Name -Properties lastlogontimestamp | ` 
              Select-Object @{Name="Computer";Expression={$_.Name}}, ` 
             @{Name="Lastlogon";Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}

 

    $lastuserlogoninfo = Get-WmiObject -Class Win32_UserProfile -ComputerName $computer.name -Credential $credential | Select-Object -First 1
    $SecIdentifier = New-Object System.Security.Principal.SecurityIdentifier($lastuserlogoninfo.SID)
    $username = $SecIdentifier.Translate([System.Security.Principal.NTAccount])

    $SAMUsername = $username.Value.split("\")[1]
    $userinfo = get-aduser -Filter {samAccountName -eq $SAMUsername} -Properties *
    #Write-Host 
    Write-Host "System Name:" -fore White -nonewline; write-host $pcinfo.Computer -fore Green
    Write-Host "SAM Account:" -fore White -nonewline; write-host $SAMUsername -fore Green
    Write-Host "Last Logon:" -fore White -nonewline; write-host $pcinfo.Lastlogon -fore Green
    Write-Host "-------------User Information-------------"
    write-host "Name: " -fore White -nonewline; write-host $userinfo.Name -fore Green
    write-host "Email: " -fore White -nonewline; write-host $userinfo.UserPrincipalName -fore Green
    write-host "Account Enabled: " -fore White -nonewline; write-host $userinfo.Enabled -fore Green
    write-host "Last Name: " -fore White -nonewline; write-host $userinfo.Surname -fore Green
    write-host "First Name: " -fore White -nonewline; write-host $userinfo.GivenName -fore Green
    write-host "Title: " -fore White -nonewline; write-host $userinfo.Title -fore Green

}
$EE = Read-Host "What is the EE?"
Get_LastLogin($EE)

