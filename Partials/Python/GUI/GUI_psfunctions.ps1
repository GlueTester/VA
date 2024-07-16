function Get_PCInfo($PCName, Stat){
    $PCInfo = Get-ADComputer $PCName -Properties Stat
    #$PCInfo = Get-ADComputer $PCName -Properties *
    #$rebootreason = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 1074} | Format-Table -wrap
    #Write-Host "System Name:" -fore White -nonewline; write-host $PCInfo.Name -fore Green
    #    if ($PCName.Enabled){
    #    Write-Host "System Enabled:" -fore White -nonewline; write-host $PCInfo.Enabled -fore Green
    #    }
    #    else{
    #        Write-Host "System Enabled:" -fore White -nonewline; write-host $PCInfo.Enabled -fore Red
   #     }
    return $PCInfo
}


#$PCINFO = Get_PCInfo LEX-LT110184
#Write-Host $PCINFO.Enabled