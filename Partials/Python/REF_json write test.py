import json #used to call or jsob file that ahs allth powershell commands
#https://www.programiz.com/python-programming/json

tempdir = "C:\\temp\\"
jsonfile = tempdir+"PowerShellScripts.json"#'Partials/Python/PowerShellScripts.json'
jsonfile_pass = "$jsonfile = \"C:\\temp\\PowerShellScripts.json\""
SearchType = "$SearchType = \"Basic\""
vars_to_PS = SearchType+"\n"+jsonfile_pass

power_shell_resolve_EE = {"ResolveHostname" :vars_to_PS+"""
    $json = Get-Content $jsonfile | Out-String | ConvertFrom-Json
    $EE = $json.EE
    $ImportedEE = $EE
    if ( $ImportedEE -eq $null){
        write-host "EE is blank, ENV EE is $EE"
        exit
    }
    $ImportedEE = "*"+$ImportedEE # This is to add the wild card to the front and not have to quote in the search
    #Sources https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/    https://stackoverflow.com/questions/28740320/how-do-i-check-if-a-powershell-module-is-installed
    if (Get-Module -ListAvailable -Name activedirectory) {
        Import-Module activedirectory
        If ($SearchType -eq "Quick"){
            $OUSearchScope = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
        }
        Else{
            $OUSearchScope = "OU=Laptops, OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
            $HostnameSearch_lvl1 = Get-ADComputer -Filter * -SearchBase $OUSearchScope | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name #Searches : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
            if (!$HostnameSearch_lvl1) {
                Write-Host "The EE $ImportedEE could be found in OU: $OUSearchScope" -foreground Red
                $HostnameSearch_lvl2 = Get-ADComputer -Filter * -SearchBase $OUSearchScope.Split(",", 2)[1] | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name #Searches : OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                if (!$HostnameSearch_lvl2) {
                    Write-Host "The EE $ImportedEE could not be found in OU: " $OUSearchScope.Split(",", 2)[1] " Trying one level higher" -foreground Red
                    $HostnameSearch_lvl3 = Get-ADComputer -Filter * -SearchBase $OUSearchScope.Split(",", 3)[2] | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name #Searches : OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                                
                    if (!$HostnameSearch_lvl3) {
                        $Hostname = $ImportedEE
                        #$HostnameArray.Add($Hostname) > $null
                        #$ADLocationArray.Add("Not Found") > $null
                        Write-Host "Extended search found $ImportedEE could not be located in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Red #NEVER Found
                    }
                    else {
                        $Hostname = $HostnameSearch_lvl3
                        #$HostnameArray.Add($Hostname) > $null
                        #$ADLocationArray.Add($OUSearchScope.Split(",", 3)[2]) > $null
                        Write-Host "Extended search found $ImportedEE resolves to $Hostname It was in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Green #Found in OU: OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                    }
                }
                else {
                    $Hostname = $HostnameSearch_lvl2
                    #$HostnameArray.Add($Hostname) > $null
                    #$ADLocationArray.Add($OUSearchScope.Split(",", 2)[1]) > $null
                    Write-Host "Extended search found $ImportedEE resolves to $Hostname It was in OU: " $OUSearchScope.Split(",", 2)[1] -foreground Green #Found in OU: OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                }
            }       
            else {
                $Hostname = $HostnameSearch_lvl1
                #$HostnameArray.Add($Hostname) > $null
                #$ADLocationArray.Add($OUSearchScope) > $null
                Write-Host "Extended search found $ImportedEE resolves to $Hostname" -foreground Green #Found in : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
            }
            
            #Sources:
            #https://adamtheautomator.com/powershell-parameter/
        }
        $Hostname = Get-ADComputer -Filter * -SearchBase $OUSearchScope | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name
    } 
    else{
        Add-Type -AssemblyName PresentationCore,PresentationFramework
        $msgBody1 = "Hey! RSAT tools are NOT installed. What are you trying to pull here? I will install it (about 5-10 mins) But do you also want the full RSAT set (about 20min install)? It give you all RSAT tools and functions. "
        $msgTitle1 = "Do you want full set of tools?"
        $msgButton1 = "YesNo"
        $msgImage1 = "Question"
        $Result1 = [System.Windows.MessageBox]::Show($msgBody1,$msgTitle1,$msgButton1,$msgImage1)
        if ( ($result1).value__ -ne 7){ #-ne means not equal 7 is no 6 is yes
            Write-Host "Good choice, installing full RSAT set"
            Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
        }
        else{
            Write-Host "Ok just install the requiered"
            Get-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.* -Online #RSAT: Active Directory Domain Services and Lightweight Directory Services Tools
            Get-WindowsCapability -Name Rsat.CertificateServices.Tools* -Online #RSAT: Active Directory Certificate Services Tools 
            Get-WindowsCapability -Name Rsat.RemoteDesktop.Services.Tools* -Online #RSAT: Remote Desktop Services Tools   
            Get-WindowsCapability -Name Rsat.GroupPolicy.Management.Tools* -Online #RSAT: Group Policy Management Tools 
        }
        Write-Host "Oops, I killed your boot sector! Na, RSAT tools are installed now. Updating your help. Judging from our interaction so far, your gonna need it."
            Update-Help
        Write-Host "Done"
    }
    $json | Add-Member -Type NoteProperty -Name 'Hostname' -Value \"$Hostname\"
    $json | ConvertTo-Json | Set-Content $jsonfile
    #echo "Hostname = \'$Hostname\'" | out-file -filepath $jsonfile -append -Encoding ASCII #Thsi writes it to the local var json file file
    """}

with open(jsonfile, 'w') as f:
  json.dump(power_shell_resolve_EE , f)

#with open(jsonfile, 'r') as f:
#  data = json.load(f)
#print(data)
#print(data)
