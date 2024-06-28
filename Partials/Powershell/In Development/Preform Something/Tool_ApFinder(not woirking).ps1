$Arplist = arp -a $address | Select-String '([0-9a-f]{2}-){5}[0-9a-f]{2}' | Select-Object -Expand Matches | Select-Object -Expand Value
$Mactofind = '01-00-5e-7f-ff-fb'
While (!$found){
    If ($Arplist -contains $Mactofind)
    {
        Write-Host "Found $Mactofind"
        arp -d

    }
    Else {
        write-host "Looking"
        arp -d
    }

}
