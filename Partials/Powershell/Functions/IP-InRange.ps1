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

