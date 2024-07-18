function Get_PCInfo($PCName, $Stat){
    $PCInfo = Get-ADComputer $PCName -Properties $Stat
    #$PCInfo = Get-ADComputer $PCName -Properties DistinguishedName | Select-Object -ExpandProperty DistinguishedName
    return $PCInfo
}





#Sources
#https://stackoverflow.com/questions/8365537/checking-for-a-range-in-powershell
#https://learn.microsoft.com/en-us/powershell/module/dhcpserver/get-dhcpserverv4scope?view=windowsserver2022-ps
#https://4sysops.com/archives/analyze-dhcp-server-with-powershell/#:~:text=You%20can%20enumerate%20them%20using%20Get-DhcpServerv4Scope.%20If%2C%20for,%3D%20%28Get-DhcpServerInDC%29.DnsName%20%24dhcps%20%7C%20foreach%20%7BGet-DhcpServerv4Scope%20-ComputerName%20%24_%7D
#https://stackoverflow.com/questions/8097354/how-do-i-capture-the-output-into-a-variable-from-an-external-process-in-powershe

function Test-IpAddressInRange {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)][ipaddress]$from,
        [Parameter(Position = 1, Mandatory = $true)][ipaddress]$to,
        [Parameter(Position = 2, Mandatory = $true)][ipaddress]$target
    )
    $f=$from.GetAddressBytes()|%{"{0:000}" -f $_}   | & {$ofs='-';"$input"}
    $t=$to.GetAddressBytes()|%{"{0:000}" -f $_}   | & {$ofs='-';"$input"}
    $tg=$target.GetAddressBytes()|%{"{0:000}" -f $_}   | & {$ofs='-';"$input"}
    return ($f -le $tg) -and ($t -ge $tg)
}

function vlanname($Target){
    $VLANList = Get-DhcpServerv4Scope -ComputerName oitlexdhp01.va.gov | Select-Object Name,StartRange,EndRange
    $i = 0
    foreach ($i in $VLANList){
        $StartRange = $i.StartRange.IPAddressToString
        $EndRange = $i.EndRange.IPAddressToString
        $a = Test-IpAddressInRange $StartRange $EndRange $Target
        if ($a -eq "True"){
            #return $a
            return $i.name
            write-host $i.name
        #$i = $i + 1
        }
    }
}

