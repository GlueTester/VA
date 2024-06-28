function EnableRemoting {
    param (
        $NewBCMA
    )
    try {

        $null = Invoke-Command -ComputerName $NewBCMA -ScriptBlock { ; } -ErrorAction Stop
        Write-Host "[  OK  ]" -fore green -nonewline; write-host "      - Remoting is enabled on $NewBCMA" -fore white
    
    } catch {
    
        Write-Host "[NOTICE!]" -fore DarkYellow -nonewline; write-host "     - Remoting is NOT enabled on $NewBCMA, enableing now" -fore white
        #Enable-PSRemoting -Force -SkipNetworkProfileCheck
        $SessionArgs = @{
            ComputerName  = "LEX-WS90571"
         
            SessionOption = New-CimSessionOption -Protocol Dcom
        }
        $MethodArgs = @{
            ClassName     = 'Win32_Process'
            MethodName    = 'Create'
            CimSession    = New-CimSession @SessionArgs
            Arguments     = @{
                CommandLine = "powershell Start-Process powershell -ArgumentList 'Enable-PSRemoting -Force'"
            }
        }
        Invoke-CimMethod @MethodArgs
    
    } 
}

function BMCASetup {
    param (
        $NewBCMA
    )
    Write-Host "[ INFO ]" -fore green -nonewline; Write-Host "      - Checking if Power Shell Remoting is enabled" -fore white
    EnableRemoting($NewBCMA)
    $Session = New-PSSession -ComputerName $NewBCMA

    #Copying Files to MedCart
    try {
        Write-Host "[ INFO ]" -fore green -nonewline; write-host "      - Coping Install Files" -fore white 
        Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BCMA Howard Cart" -Destination "C:\Temp\BCMA" -ToSession $Session -Recurse
        Write-Host "[ INFO ]" -fore green -nonewline; write-host "      - Coping XML Files" -fore white 
        Copy-Item "\\v09.med.va.gov\lex\Service\OI&T\SoftwareLibrary\Standard\BCMA Howard Cart\Med Display 4.0.0.11\Installer\x64\*.xml" -Destination "C:\Users\Public\Desktop\" -ToSession $Session -Recurse
        Write-Host "[  OK  ]" -fore green -nonewline; write-host "      - Copied Files" -fore white 
    } catch {
        Write-Host "[FAILED]" -fore red -nonewline; write-host "      - I was unable to copy the files!" -fore white   
    }

   
    #Replacing SmartCard Drivers
    Write-Host "[ INFO ]" -fore green -nonewline; Write-Host "      - Installing Smart Card Drivers" -fore white
    try{
        Invoke-Command -Session $Session -ScriptBlock {pnputil /add-driver "C:\Temp\BCMA\SCR3xx_driver_ver_4.67\SCR3XX.inf" /install} #/driverid $DeviceID}
        Write-Host "[  OK  ]" -fore green -nonewline; Write-Host "      - Smart Card Drivers Installed" -fore white
    } catch{
        Write-Host "[FAILED]" -fore red -nonewline; write-host "      - Could not install Smart Card Drivers" -fore white 
    }

    #Restarting Computer to Complete
    Write-Host "[ INFO ]" -fore green -nonewline; Write-Host "      - Restarting Computer" -fore white
    try{
        Restart-Computer -ComputerName $NewBCMA -Force
        Write-Host "[  OK  ]" -fore green -nonewline; Write-Host "      - Cart is now setup!" -fore white
    } catch{
        Write-Host "[FAILED]" -fore red -nonewline; write-host "      - Could not restart computer, please restart by hand" -fore white 
    }
    


    #Installing MedDisplay after reboot
    Write-Host "[ INFO ]" -fore green -nonewline; write-host "      - Waiting For system to come online"

    do {
        Write-Host "[OFFLINE]" -fore Yellow -nonewline; write-host "      - Waiting For system to come online"
        sleep 2
        } until (Test-Connection $NewBCMA -Quiet)
    
        
    
        if (Test-Connection $NewBCMA -Quiet) { 
            Write-Host "[ONLINE]" -fore green -nonewline; write-host "      - System online"
            Write-Host "[ INFO ]" -fore green -nonewline; write-host "      - Installing MedDisplay" -fore white
            try {
                Invoke-Command -Session $Session -ScriptBlock {msiexec /i "C:\Temp\BCMA\Med Display 4.0.0.11\MedDisplay.msi" /qn}
                Write-Host "[  OK  ]" -fore green -nonewline; Write-Host "      - MedDisplay Insatlled" -fore white
            } catch{
                Write-Host "[FAILED]" -fore red -nonewline; write-host "      - Could not install MedDisplay" -fore white  
            }
        }


}


Clear-Host
$EE = Read-Host "Please enter EE of BCMA Cart to setup" #Grabs the name of the computer
$NewBCMA = Get-ADComputer -Filter "Name -like '*MA*$EE'" -SearchBase 'OU=OSD Staging,OU=Test Lab,DC=v09,DC=med,DC=va,DC=gov'| Select-Object -ExpandProperty Name

#Move MA to correct OU
if ($NewBCMA) {
    Write-Host "[  OK  ]" -fore green -nonewline; Write-Host "      - Found $NewBCMA in OSD Staging" -fore white
    Set-ADComputer -Identity "CN=$NewBCMA,OU=OSD Staging,OU=Test Lab,DC=v09,DC=med,DC=va,DC=gov" -Description "BCMA Cart" #Set the description prior to the move
    Move-ADObject -Identity "CN=$NewBCMA,OU=OSD Staging,OU=Test Lab,DC=v09,DC=med,DC=va,DC=gov" -TargetPath "OU=Workstations,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"  #Move computer to correct OU 
    BMCASetup($NewBCMA)
}else {
    Write-Host "[NOTICE!]" -fore DarkYellow -nonewline; Write-Host "     - New BCMA is not in OSD Staging, checking VISN09/Lexington (LEX)/Workstations" -fore white
    $NewBCMA = Get-ADComputer -Filter "Name -like '*MA*$EE'" -SearchBase 'OU=Workstations,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'| Select-Object -ExpandProperty Name
    if ($NewBCMA) {
        Write-Host "[  OK  ]" -fore green -nonewline; Write-Host "      - Found $NewBCMA in VISN09/Lexington (LEX)/Workstations/Windows 10/MA" -fore white
        BMCASetup($NewBCMA)
    }else {
        Write-Host "[FAILED]" -fore red -nonewline; Write-Host "      - Cant find system please ensure EE is correct and it is in OSD Stageing or Win10 MA OU"-fore white
    }
}