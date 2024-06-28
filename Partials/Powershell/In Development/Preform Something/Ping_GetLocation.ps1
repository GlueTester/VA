# Preqreqestits and explnation of script
# The script uses a CVS file to supply a list of EEs. It does not use headers and only looks
# in what would be Column A if viewing in excel.
# 
#
#
# Created 24JULY2023
# Mainttained by Russell King

param([switch] $help )
if ($help)
{
    write-host "This is help for this program. It does nothing. Hope that helps."
}
else
{
   


function Mount-Y_Drive {
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
    
    function Save-ReplyFile([string] $initialDirectory){
    
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
        $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
        $OpenFileDialog.initialDirectory = $initialDirectory
        $OpenFileDialog.filter = "Found Results File (*.csv)| *.csv"
        $OpenFileDialog.ShowDialog() |  Out-Null
        return $OpenFileDialog.filename
    
    }
    
    function Save-OfflineFile([string] $initialDirectory){
    
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
        $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
        $OpenFileDialog.initialDirectory = $initialDirectory
        $OpenFileDialog.filter = "Offline Computers File (*.csv)| *.csv"
        $OpenFileDialog.ShowDialog() |  Out-Null
        return $OpenFileDialog.filename
    }
    
    function Open-SourceFile([string] $initialDirectory){
    
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
        $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
        $OpenFileDialog.initialDirectory = $initialDirectory
        $OpenFileDialog.filter = "Source File (*.csv)| *.csv"
        $OpenFileDialog.ShowDialog() |  Out-Null
    
        return $OpenFileDialog.filename
    } 

    function Install-Package(){

    }
    
    $OUSearchScope = 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'
    
    $OpenFile=Open-SourceFile "$env:USERPROFILE\Dekstop" 
    $ReplyFile=Save-ReplyFile "$env:USERPROFILE\Dekstop"
    "Computer Name,IP"| Set-Content $ReplyFile #Out-File $ReplyFile
    $OfflineFile=Save-OfflineFile "$env:USERPROFILE\Dekstop"
    "Computer Name,Status"| Set-Content $OfflineFile
    
    $list = Get-Content -Path $OpenFile
    
    Write-Host "Starting Ping"
   foreach( $EE in $list) {
        $ComputerName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope| Select-Object -ExpandProperty Name
        
    
        if ($ComputerName) {
        } #If the computer name is not NULL or empty
    
       if (!$ComputerName) { 
         Write-host $EE "NOT in AD OU that was searched" | Out-File $OfflineFile -append
         ("$EE,NOT in AD OU that was searched") |  Out-File $OfflineFile -append
       }
       # If computer name is empty
       elseif (test-connection $ComputerName -count 1 -quiet) {
            $IP = test-connection $ComputerName -count 1 | Select-Object -ExpandProperty IPV4Address | Select-Object -ExpandProperty IPAddressToString
             if (!$IP) {
                ("$ComputerName,Offline") | Out-File $OfflineFile -append 
                Write-host $ComputerName "Computer is Offline" -foreground red
                }
             else{
                ("$ComputerName,$IP") | Out-File $ReplyFile -append #Save the vaule of the variables to the ReplyFile with append so as to add to not overright
                 Write-host $ComputerName "IP:$IP " -foreground green #Displays in powershell window for user to see
                 }
    
        } else {
             Write-host $ComputerName "Computer Offline. " -foreground red
             ("$ComputerName,Offline") | Out-File $OfflineFile -append 
        }
    }
    
    
    Write-Host "Done"
}