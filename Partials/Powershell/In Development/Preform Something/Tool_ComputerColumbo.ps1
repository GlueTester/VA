# Preqreqestits and explnation of script
# Open notepad and save it as anyname but as a .csv instead of .txt.
#    This is beucase excel can open csv files but like to save encoded as other formats like xls
# Now open the newly created csv file with excel and past the EE numbers in the A column.
# Save the file
#
#
# The Goal is to be able to locat computers and maybe other equipment that could not be found
#
# Created 9MARCH2023
#Last Updated: 27March2023
# Mainttained by Russell King
$HostnameArray = [System.Collections.ArrayList]@()
$ADLocationArray = [System.Collections.ArrayList]@()

#Functions
function Mount_YDrive {
            #net use
            If(Test-Path \\v09.med.va.gov\lex\Public)
            {
                if (((New-Object System.IO.DriveInfo("Y:")).DriveType -ne "NoRootDirectory")) 
                    {
                        Write-Host "Network Paths Mounted" -foreground green
                    }
                else
                    {
                        net use Y: \\v09.med.va.gov\lex\Public
                        Write-Host "Network Paths NOT mounted! Mounting now" -foreground red
                        Write-Host "Network Paths Mounted" -foreground green
                    }
            }
            else { 
                if (((New-Object System.IO.DriveInfo("Y:")).DriveType -ne "NoRootDirectory"))
                    {
                        net use Y: /delete
                        Write-Host "removing Y:, please rerun" -foreground red
                    }
            }
}
 function Resolve_EE {
 #Usage: 
 # Import-Csv -Path C:\Users\vhalexkingr1\Desktop\TemplateCSV.csv | Resolve_EE    will feed a files resultinto the function and run them all
 # Resolve_EE (*****)    replaceing he * with an EE will return jsu that system

            param (
                [Parameter(ValueFromPipelineByPropertyName)]
                [ValidateNotNullOrEmpty()]
                [string]$EE #,        
        
                #[Parameter(ValueFromPipelineByPropertyName)]
                #[ValidateNotNullOrEmpty()]
               # [string]$Serial 
            )
            process {
                <#
                ## Connect to the remote with some code here
                Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                    ## Do stuff to install the version of office on this computer
                    Start-Process -FilePath 'msiexec.exe' -ArgumentList 'C:\Setup\Office{0}.msi' -f $using:Version
                }
                #>
                #Write-Host "I am installing Office version [$EE] on computer [$Serial]"
                $HostnameSearch_lvl1 = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope| Select-Object -ExpandProperty Name #Searches : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                if (!$HostnameSearch_lvl1) {
                    Write-Host "The EE [$EE] could be found in OU: $OUSearchScope" -foreground Red
                    
                    $HostnameSearch_lvl2 = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope.Split(",", 2)[1] | Select-Object -ExpandProperty Name #Searches : OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                    if (!$HostnameSearch_lvl2) {
                        Write-Host "The EE [$EE] could not be found in OU: " $OUSearchScope.Split(",", 2)[1] " Trying one level higher" -foreground Red
                        $HostnameSearch_lvl3 = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope.Split(",", 3)[2] | Select-Object -ExpandProperty Name #Searches : OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                        
                        if (!$HostnameSearch_lvl3) {
                            $Hostname = $EE
                            $HostnameArray.Add($Hostname) > $null
                            $ADLocationArray.Add("Not Found") > $null
                            Write-Host "The EE [$EE] could not be located in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Red #NEVER Found
                        }
                        else {
                            $Hostname = $HostnameSearch_lvl3
                            $HostnameArray.Add($Hostname) > $null
                            $ADLocationArray.Add($OUSearchScope.Split(",", 3)[2]) > $null
                            Write-Host "The EE  [$EE] resolves to [$Hostname] It was in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Green #Found in OU: OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                        }
                    }
                    else {
                        $Hostname = $HostnameSearch_lvl2
                        $HostnameArray.Add($Hostname) > $null
                        $ADLocationArray.Add($OUSearchScope.Split(",", 2)[1]) > $null
                        Write-Host "The EE  [$EE] resolves to [$Hostname] It was in OU: " $OUSearchScope.Split(",", 2)[1] -foreground Green #Found in OU: OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                    }
                }       
                else {
                    $Hostname = $HostnameSearch_lvl1
                    $HostnameArray.Add($Hostname) > $null
                    $ADLocationArray.Add($OUSearchScope) > $null
                    Write-Host "The EE  [$EE] resolves to [$Hostname]" -foreground Green #Found in : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                }
          }
        #Sources:
        #https://adamtheautomator.com/powershell-parameter/
}

function Copy_Files {
            param (
                [Parameter(ValueFromPipelineByPropertyName)]
                [ValidateNotNullOrEmpty()]
                [string]$EE,
        
                [Parameter(Mandatory)]
                [string]$OUSearchScope
                
            )
        $Session = New-PSSession -ComputerName "lex-lt88076"
        $Source ="\\v09.med.va.gov\apps\VA_Shortcuts\LEX\CPRSChart LEX.lnk"
        $Dest =  "C:\Users\VHALEX \Desktop"
        
        Copy-Item $Source -Destination "$Dest -ToSession $Session -Recurse"
}



#Declairdd variables (changeable per use)
$Filelocation = New-Object -TypeName System.Windows.Forms.OpenFileDialog
$Filelocation.ShowDialog()
#$MachineStatsDir = "Y:\Public\LogonScripts\Lognoff$\machinestats\"
#$MachineLogFile = "$MachineStatsDir\$ComputerName.log"
    
                            #$list = Get-Content -Path $Filelocation.Filename
 
                            
#Check for mounted Y drive
Mount_YDrive
    
#Resolve EE's to Hostnames
#Import-Csv -Path C:\Users\vhalexkingr1\Desktop\TemplateCSV.csv | Resolve_EE
 
Resolve_EE (95991)
#$HostnameArray
#$ADLocationArray

#$MaxLen=[Math]::Max($HostnameArray.Length, $ADLocationArray.Length)



    
    <#
    #Write-Host "Started Pinging.."
    foreach( $EE in $list) {
        $ComputerName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope| Select-Object -ExpandProperty Name
        $MachineLogFile = "$MachineStatsDir\$ComputerName.log"
    
        if ($ComputerName) {
        #$MachineStatsDir = "Y:\Public\LogonScripts\Lognoff$\machinestats\$ComputerName.log"
        $LastLogin = Get-Content -tail 1 $MachineLogFile #| Select-String -Pattern "$SamAccount"
        }
    
       if (!$ComputerName) { 
         Write-host $EE "NOT in AD OU that was searched"
       }
    
       elseif (test-connection $ComputerName -count 1 -quiet) {
           Write-host $ComputerName "Ping succeeded. $LastLogin" -foreground green
           
    
        } else {
             Write-host $Computer "Ping failed. $LastLogin" -foreground red
        }
    }
    #>
    
    
    
    
    