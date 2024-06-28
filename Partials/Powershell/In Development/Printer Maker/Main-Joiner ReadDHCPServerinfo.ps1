
$dhcpserver="oitlexdhp01.va.gov"
$PrintServers = "vhalexprt1.v09.med.va.gov","vhalexprt3.v09.med.va.gov","vhalexprt4.v09.med.va.gov"



do {
    Write-Host "Printer Master"
    Write-Host "1. Setup New Printer (Need IP)"
    Write-host "2. Lookup Info about printer (need EE or Partial Name)"
    Write-host "3. Quit"
    $choice=Read-Host "Chose a number to continue"

    switch ($choice)
{
        1 {
            $PrinterIp = Read-Host "What is the Printer IP?"
            Get-SNMPPrinterInfo $PrinterIp
            #Split Printer IP into first threee octeets
            $ScopeId = $PrinterIp.Split(".",4) ; $ScopeId = $ScopeId[0]+"."+$ScopeId[1]+"."+$ScopeId[2]+".0"

            #Grab Info from DHCP server 
            $PrinterMAC = (Get-DhcpServerv4Lease –ComputerName $dhcpserver –ScopeId $ScopeId).where({$_.IPAddress -in $PrinterIp})|Select-Object -ExpandProperty ClientId
            $PrinterHostname =  (Get-DhcpServerv4Lease –ComputerName $dhcpserver –ScopeId $ScopeId).where({$_.IPAddress -in $PrinterIp})|Select-Object -ExpandProperty HostName
            $PrinterModel = Get-SNMPPrinterInfo $PrinterHostname|Select-Object -ExpandProperty Model


            #Get SNMP info
            $SystemDescription = Get-SNMPPrinterInfo $PrinterHostname | Select-Object -ExpandProperty SystemDescription
            #Split SystemDescription by spaces to get SystemDescription "Xerox VersaLink B400"
            $SystemMakeModelSeries = $SystemDescription.Split(";",2) 

            #Now Split result "Xerox VersaLink B400" to each be an instance 
            $MakeModelSeries = $SystemMakeModelSeries.Split(" ",3)

            #Now seperate them out
            $Make = $MakeModelSeries[0]
            $Model = $MakeModelSeries[2]
            $Series = $MakeModelSeries[1]

            #Grab Printer

            Write-Host "MAC:      $PrinterMAC"
            Write-Host "Hostname: $PrinterHostname"
            Write-Host "Make:     $Make"
            Write-Host "Model:    $Model"
            Write-Host "Series:   $Series"
        
        
        
        
        } #'10.74.182.31'
        2 {
            $PrinterHostname = Read-Host "What is the Printer EE (or partial name)?"
            PrintServerInfo $PrinterHostname
            $PrintServerInfoResutls = PrintServerInfo $PrinterHostname #userinput of name
            Write-Host "$PrintServerInfoResutls"
            $PrintServer = $PrintServerInfoResutls.Computername
            $PrinterName = $PrintServerInfoResutls.Name
            Write-Host $PrinterName
        }

    }  } until ($choice -eq 3) 



#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################


#Search Print server for info
function PrintServerInfo {
    param (
        [string[]]$PrinterHostname
    )

    process {
        foreach ($i in $PrintServers) {
                try {
                    $result = (get-printer -ComputerName $i |  Where-Object {($_.Name -like '*'+$PrinterHostname+'*')})

                } catch {
                    $result = $null
                }

                if ($result) {
                    #Write-Host "they wern not null but: $result"
                    # get the ip address
                    $PrintServer = $result.Computername
                    $PrinterName = $result.Name
                    return
                }else {

                }
        }
    }
}





function Get-SNMPPrinterInfo {
    param (
        [string[]]$printers
    )

    begin {
        $snmp = New-Object -ComObject olePrn.OleSNMP
        $ping = New-Object System.Net.NetworkInformation.Ping
    }

    process {
        foreach ($printer in $printers) {
            try {
                $result = $ping.Send($printer)
            } catch {
                $result = $null
            }

            if ($result.Status -eq 'Success') {
                # get the ip address
                $printerip = $result.Address.ToString()
            
                # OPEN SNMP CONNECTION TO PRINTER
                $snmp.open($printerip, 'R03SNMPPRT', 2, 3000)

                # MODEL
                try { $model = $snmp.Get('.1.3.6.1.2.1.25.3.2.1.3.1') } catch { $model = $null }

                # IF IT HAS A MODEL NAME...
                if ($model) {
                
                    # DESCRIPTION
                    try { $sysdescr0 = $snmp.Get('.1.3.6.1.2.1.1.1.0') } catch { $sysdescr0 = $null }

                    # COLOR
                    # might want to check on this one
                    try { if ($snmp.Get('.1.3.6.1.2.1.43.11.1.1.6.1.2') -match 'Toner|Cartridge') { $color = 'Yes' } else { $color = 'No' } } catch { $color = 'No' }

                    # TRAYS
                    try { $trays = $($snmp.GetTree('.1.3.6.1.2.1.43.8.2.1.13') | ? {$_ -notlike 'print*'}) -join ';' } catch { $trays = $null }

                    # COMMENT
                    try { $comment = $snmp.Get('.1.3.6.1.2.1.1.6.0') } catch { $comment = $null }

                    ##### FEATURES, NAME
                    $features = $null
                    $name = $null
                    switch -Regex ($model) {
                        '^sharp' {
                            try { $features = $($snmp.GetTree('.1.3.6.1.4.1.2385.1.1.3.2.1.3') | ? {$_ -notlike '.*'}) -join ';' } catch { $features = $null }
                            try { $name = $snmp.Get('.1.3.6.1.4.1.1536.1.3.5.4.2.0').toupper() } catch { $name = $null }
                        }
                        '^canon' {
                            try { $name = $snmp.Gettree('.1.3.6.1.4.1.1602.1.3.3.1.1.2.1.1.10.134') | ? {$_ -notlike '.*'} | select -f 1 | % {$_.toupper()} } catch { $name = $null }
                        }
                        '^zebra' {
                            try { $name = $snmp.Get('.1.3.6.1.4.1.10642.1.4.0').toupper() } catch { $name = $null }
                        }
                        '^lexmark' {
                            try { $name = $snmp.Get('.1.3.6.1.4.1.641.1.5.7.6.0').toupper() } catch { $name = $null }
                        }
                        '^ricoh' {
                            try { $name = $snmp.Get('.1.3.6.1.4.1.367.3.2.1.7.3.5.1.1.2.1.1').toupper() } catch { $name = $null }
                        }
                        '^hp' {
                            try { $name = $snmp.Get('.1.3.6.1.4.1.11.2.4.3.5.46.0').toupper() } catch { $name = $null }
                        }
                        default {
                            #'features', 'name' | % {Clear-Variable $_}
                            $features = $null
                            $name = $null
                        }
                    }
                    #if ($model -like 'SHARP*') {}
                
                    # ADDRESS
                    try { $addr = ($snmp.Gettree('.1.3.6.1.2.1.4.20.1.1') | ? {$_ -match '(?:[^\.]{1,3}\.){3}[^\.]{1,3}$' -and $_ -notmatch '127\.0\.0\.1'} | % {$ip = $_.split('.'); "$($ip[-4]).$($ip[-3]).$($ip[-2]).$($ip[-1])"}) -join ';' } catch { $addr = $null }

                    [pscustomobject]@{
                        Machine = $printer
                        IP = $printerip
                        Name = $name
                        Model = $model
                        Comment = $comment
                        Color = $color
                        Trays = $trays
                        Features = $features
                        SystemDescription = $sysdescr0
                        Addresses = $addr
                    }
                }
                $snmp.Close()
            } else {
                Write-Warning "Machine '$printer' may be offline."
            }
        }
    }
}

#Sources
#https://www.progress.com/blogs/create-microsoft-dhcp-lease-inventory-script
#https://stackoverflow.com/questions/57217630/retrieve-a-clients-ip-address-with-its-mac-address-via-the-dhcp-server-in-a-pow
#https://github.com/gangstanthony/PowerShell/blob/master/Get-SNMPPrinterInfo.ps1
#



