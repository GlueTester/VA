
function Get_LastLogin($EE) {
$Computer = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'
    $pcinfo = Get-ADComputer $Computer -Properties *
    $rebootreason = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 1074} | Format-Table -wrap
    Write-Host "System Name:" -fore White -nonewline; write-host $Computer.Name -fore Green
    if ($Computer.Enabled){
    Write-Host "System Enabled:" -fore White -nonewline; write-host $Computer.Enabled -fore Green
    }
    else{
        Write-Host "System Enabled:" -fore White -nonewline; write-host $Computer.Enabled -fore Red
    }
    $yesno = Read-Host "Whould you like last reasons for reboot? y/n (Not working yet)"
    #the yes no to see reboot reason is only occuring locally and admin would requier remote via invoke
    if ($yesno -eq "y"){
    Write-host "Reboot Reason"
    $rebootreason
    }
    $yesno2 = Read-Host "Whould you like to Enter a PS Session? (Must be admin)"
    #the yes no to see reboot reason is only occuring locally and admin would requier remote via invoke
    if ($yesno2 -eq "y"){
    Enter-PSSession $Computer.Name
    }
}
$EE = Read-Host "What is the EE?"
Get_LastLogin($EE)

