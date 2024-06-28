from PyQt5 import QtCore, QtGui, QtWidgets
import time
from dotenv import load_dotenv, set_key
import subprocess, sys
import os
from GUI_TechKing import *

envfile = "C:\\temp\\.env"

#if not os.path.exists(envfile):   #create if not exist https://stackoverflow.com/questions/35807605/create-a-file-if-it-doesnt-exist
#    open(".env", "x") close() # creates the file
if not os.path.exists(envfile):
    open(envfile, 'w')


def ResolveName(self, EE):# Def in classes / https://stackoverflow.com/questions/5615648/how-can-i-call-a-function-within-a-class
        load_dotenv(envfile)
        power_resolveEE = """
        $envfile = "C:\\temp\.env"
        $SearchType = $env:SearchType
        $ImportedEE = $env:EE
        $ImportedEE = "*"+$ImportedEE # This is to add the wild card to the front and not have to quote in the search
        if ( $ImportedEE -eq $null){
            write-host "EE is blank"
            write-host "ENV EE is $env:EE"
            write-host "imported EE is $ImportedEE"
            write-host "runing it agin"
            $ImportedEE = $env:EE
            write-host "EE is blank"
            write-host "ENV EE is $env:EE"
            write-host "imported EE is $ImportedEE"
            exit
        }
        #Sources https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/    https://stackoverflow.com/questions/28740320/how-do-i-check-if-a-powershell-module-is-installed
        if (Get-Module -ListAvailable -Name activedirectory) {
            Import-Module activedirectory
            If ($SearchType -eq "Quick"){
                $OUSearchScope = "OU=Windows 10, OU=Laptops ,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
            }
            Else{
                $OUSearchScope = "OU=Laptops, OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
                $HostnameSearch_lvl1 = Get-ADComputer -Filter * -SearchBase $OUSearchScope | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name #Searches : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                if (!$HostnameSearch_lvl1) {
                    Write-Host "The EE [$EE] could be found in OU: $OUSearchScope" -foreground Red
                    $HostnameSearch_lvl2 = Get-ADComputer -Filter * -SearchBase $OUSearchScope.Split(",", 2)[1] | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name #Searches : OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                    if (!$HostnameSearch_lvl2) {
                        Write-Host "The EE [$EE] could not be found in OU: " $OUSearchScope.Split(",", 2)[1] " Trying one level higher" -foreground Red
                        $HostnameSearch_lvl3 = Get-ADComputer -Filter * -SearchBase $OUSearchScope.Split(",", 3)[2] | Where-Object {$_.Name -like $ImportedEE} | Select-Object -ExpandProperty Name #Searches : OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                        			
                        if (!$HostnameSearch_lvl3) {
                            $Hostname = $ImportedEE
                            $HostnameArray.Add($Hostname) > $null
                            $ADLocationArray.Add("Not Found") > $null
                            Write-Host "The EE [$ImportedEE] could not be located in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Red #NEVER Found
                        }
                        else {
                            $Hostname = $HostnameSearch_lvl3
                            $HostnameArray.Add($Hostname) > $null
                            $ADLocationArray.Add($OUSearchScope.Split(",", 3)[2]) > $null
                            Write-Host "The EE  [$ImportedEE] resolves to [$Hostname] It was in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Green #Found in OU: OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                        }
                    }
                    else {
                        $Hostname = $HostnameSearch_lvl2
                        $HostnameArray.Add($Hostname) > $null
                        $ADLocationArray.Add($OUSearchScope.Split(",", 2)[1]) > $null
                        Write-Host "The EE  [$ImportedEE] resolves to [$Hostname] It was in OU: " $OUSearchScope.Split(",", 2)[1] -foreground Green #Found in OU: OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                    }
                }       
                else {
                    $Hostname = $HostnameSearch_lvl1
                    $HostnameArray.Add($Hostname) > $null
                    $ADLocationArray.Add($OUSearchScope) > $null
                    Write-Host "The EE  [$ImportedEE] resolves to [$Hostname]" -foreground Green #Found in : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
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
        echo "Hostname = \'$Hostname\'" | out-file -filepath $envfile -append -Encoding ASCII #Thsi writes it to the .env file
        """
        result = subprocess.run(["powershell.exe", "-Command", power_resolveEE]) 
        os.environ.pop(envfile, None)
        load_dotenv(envfile)
        _translate = QtCore.QCoreApplication.translate
        label_hostname.setText(os.getenv('Hostname'))
        Button_QuickSearch.setText("Quick Search")

def Quick_Search_clicked(self):
    self.Button_QuickSearch.setText("Searching")
    EE =(input_EE.text())
    SearchType="Quick"
    set_key(dotenv_path="C:\\temp\\.env", key_to_set="EE", value_to_set=EE) 
    set_key(dotenv_path="C:\\temp\\.env", key_to_set="SearchType", value_to_set=SearchType)
    ResolveName(EE)