
$Runagin = "y"

While ($Runagin -eq "y") {
    cls #Clears screen
    $PC= Read-Host "Please enter PC Full name" #Grabs the name of the computer

    #Test to ensure computer is online, exits if not
    If (Test-Connection -BufferSize 32 -Count 1 -ComputerName $PC -Quiet) {
        Write-Host "The remote machine is Online"
        If (Test-Path "\\$PC\c$\temp\new\*"){
        Remove-Item -path "\\$PC\c$\temp\new"  -Recurse -Force
        Write-Host "Removed previosu new file"
        }
        Sleep 4
        Copy-Item -Recurse "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Support Files\PrinterSpooler_Files\" "\\$PC\c$\temp\new\"
        
        If (Test-Path "\\$PC\c$\temp\new\*"){
        Write-Host "Files have been copied to local folder"
        $Connection = New-PSSession -ComputerName $PC #Establish a presistant connection to remote machine
        Invoke-Command -Session $Connection  -ScriptBlock {
        #$SpoolerStat = Get-Service -Name Spooler | Where-Object {$_.Status -eq "Running"}
        If (Get-Service -Name Spooler | Where-Object {$_.Status -eq "Running"}){
           Write-Host "Spooler is running, Stopping Spooler now" 
           Stop-Service -Name Spooler -Force
           Sleep 2 #Wait for spooler to stop
           Stop-Service -Name Spooler -Force
               #Check if spooler stopped
               If (Get-Service -Name Spooler | Where-Object {$_.Status -eq "Running"}){
               Write-Host "Im having trouble stopping the spooler"
               }
               Else {
               Write-Host "Spooler Stopped" 
               Write-Host "Removing Spooler file"
               Remove-Item -path C:\Windows\System32\spool\prtprocs\x64\* -Recurse -Force
                   If (Test-Path -Path .\C:\Windows\System32\spool\prtprocs\x64\*){
                   Write-Host "Im Having trouble removing all the files"
                   }
                   Else {
                   Write-Host "Files have been removed" 
                   Write-Host "Adding New Spooler files fropm local temp folder"
                   Copy-Item -Recurse "C:\temp\new\*" "C:\Windows\System32\spool\prtprocs\x64\"
                       If (Test-Path -Path C:\Windows\System32\spool\prtprocs\x64\*){
                       Write-Host "Files Copied"
                       Write-Host "Starting Spooler"
                       Start-Service -Name Spooler
                          If (Get-Service -Name Spooler | Where-Object {$_.Status -eq "Running"}){
                           Write-Host "Spooler started back"
                           ls "C:\Windows\System32\spool\prtprocs\x64\"
                           }
                           Else {
                           Write-Host "I could NOT restart the spooler" 
                           }
                       Remove-Item -path "C:\temp\new"  -Recurse -Force 
        }
        Else {
            Write-Host "I could NOT copy the files" 
        }
                   }
         }
         }
        Else {
           Write-Host "Spooler was not running, continuing" 
           Write-Host "Removing Spooler files"
           Remove-Item -path C:\Windows\System32\spool\prtprocs\x64\* -Recurse -Force
           If (Test-Path -Path C:\Windows\System32\spool\prtprocs\x64\*){
              Write-Host "Im having trouble removing all the files"
              }
           Else {
              Write-Host "Files have been removed" 
              Write-Host "Adding New Spooler files"
              Copy-Item -Recurse "C:\temp\new\*" "C:\Windows\System32\spool\prtprocs\x64\"
              If (Test-Path -Path C:\Windows\System32\spool\prtprocs\x64\*){
                 Write-Host "Files Copied"
                 Write-Host "Starting Spooler"
                 Start-Service -Name Spooler
                    If (Get-Service -Name Spooler | Where-Object {$_.Status -eq "Running"}){
                        Write-Host "Spooler started back"
                        ls "C:\Windows\System32\spool\prtprocs\x64\"
                    }
                    Else {
                         Write-Host "I could NOT restart the spooler" 
                    }
               }
              Else {
                 Write-Host "I could NOT copy the files" 
              }
            }
            }
        }}
        Else{
        Write-Host "I could NOT copy the files"
        }
        }
    
    Else {
            Write-Host "The remote machine is Down"
    }



$Runagin = Read-Host "Do you need to run agin? (y/n)" #Grabs the name of the computer
}