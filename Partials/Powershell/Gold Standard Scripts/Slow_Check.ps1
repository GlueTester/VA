##################################################
#  Linux top equivalent in PowerShell
#  Run this from an elevated promt, it will ask EE and remote into mahcine
##################################################





  #Sources https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/    https://stackoverflow.com/questions/28740320/how-do-i-check-if-a-powershell-module-is-installed
  $username = whoami
  $LogDir = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Logs\"
 

  if (Get-Module -ListAvailable -Name activedirectory) {
      Import-Module activedirectory
      #$OUSearchScope = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
      #$FullPCName = Get-ADComputer -LDAPFilter "(name=*$EE)" -SearchBase $OUSearchScope | Select-Object -ExpandProperty Name
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
  
  do {
    Write-Host "--Slow Checker--"
    Write-Host "1. Scan System"
    Write-host "2. Quit"
    $choice=Read-Host "Chose a number to continue"

    switch ($choice)
{
 1 {
        $LogFile = $LogDir+"Slow_Check.log"
        if ($username){
          "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Success" | out-file $LogFile -Append
          }
        else{
          $username = $username.split('\')[1].ToUpper()
          "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Fail" | out-file $LogFile -Append
          }



        function Get_PCName($EE) {
          $PCName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'
          #$PCName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'DC=v09,DC=med,DC=va,DC=gov'
          return $PCName.Name
          }
        function Get_PCInfo($PCName){
          $PCInfo = Get-ADComputer $PCName -Properties *
          Write-Host "System Name:" -fore White -nonewline; write-host $PCInfo.Name -fore Green
              if ($PCInfo.Enabled){
              Write-Host "System Enabled:" -fore White -nonewline; write-host $PCInfo.Enabled -fore Green
              }
              else{
                  Write-Host "System Enabled:" -fore White -nonewline; write-host $PCInfo.Enabled -fore Red
              }
          #return $PCName
        }
        
        $EE = Read-Host "Please enter the EE"
        $PCName = Get_PCName($EE)
        #Write-Host $PCName
        Get_PCInfo($PCName)
        Write-Host "Connecting to machine"
        Invoke-Command -ComputerName $PCName -ScriptBlock {
          $count = 0 
          $global:PCName = $null
          $global:PCInfo= $null
      
      
      
      
      
      
          if ($args[0] -eq $null) {
              $SortCol = "Memory"
            } else {
              $SortCol = $args[0]
            }
            
            if ($args[1] -eq $null) {
              $Top = 30
            } else {
              $Top = $args[1]
            }
            
            
            
            
          function myTopFunc ([string]$SortCol = "Memory", [int]$Top = 30) {
            ## Check user level of PowerShell
            if (
              ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
              ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
            )
            {
              $procTbl = get-process -IncludeUserName | select ID, Name, UserName, Description, MainWindowTitle
            } else {
              $procTbl = get-process | select ID, Name, Description, MainWindowTitle
            }
          
            Get-Counter `
              '\Process(*)\ID Process',`
              '\Process(*)\% Processor Time',`
              '\Process(*)\Working Set - Private'`
              -ea SilentlyContinue |
            foreach CounterSamples |
            where InstanceName -notin "_total","memory compression" |
            group { $_.Path.Split("\\")[3] } |
            foreach {
              $procIndex = [array]::indexof($procTbl.ID, [Int32]$_.Group[0].CookedValue)
              [pscustomobject]@{
                Name = $_.Group[0].InstanceName;
                ID = $_.Group[0].CookedValue;
                User = $procTbl.UserName[$procIndex]
                CPU = if($_.Group[0].InstanceName -eq "idle") {
                  $_.Group[1].CookedValue / $LogicalProcessors
                  } else {
                  $_.Group[1].CookedValue
                };
                Memory = $_.Group[2].CookedValue / 1KB;
                Description = $procTbl.Description[$procIndex];
                Title = $procTbl.MainWindowTitle[$procIndex];
              }
            } |
            sort -des $SortCol |
            select -f $Top @(
              "Name", "ID", "User",
              @{ n = "CPU"; e = { ("{0:N1}%" -f $_.CPU) } },
              @{ n = "Memory"; e = { ("{0:N0} K" -f $_.Memory) } },
              "Description", "Title"
            ) | ft -a
          }
          
      
          
        
          # Convert Wua History ResultCode to a Name # 0, and 5 are not used for history # See https://msdn.microsoft.com/en-us/library/windows/desktop/aa387095(v=vs.85).aspx
        #usuage ######################## Get-WuaHistory | Format-Table
        function Convert-WuaResultCodeToName
        {
        param( [Parameter(Mandatory=$true)]
        [int] $ResultCode
        )
        $Result = $ResultCode
        switch($ResultCode)
        {
        2
        {
        $Result = "Succeeded"
        }
        3
        {
        $Result = "Succeeded With Errors"
        }
        4
        {
        $Result = "Failed"
        }
        }
        return $Result
        }
        function Get-WuaHistory
        {
        # Get a WUA Session
        $session = (New-Object -ComObject 'Microsoft.Update.Session')
        # Query the latest 1000 History starting with the first recordp
        $history = $session.QueryHistory("",0,20) | ForEach-Object {
        $Result = Convert-WuaResultCodeToName -ResultCode $_.ResultCode
        # Make the properties hidden in com properties visible.
        $_ | Add-Member -MemberType NoteProperty -Value $Result -Name Result
        $Product = $_.Categories | Where-Object {$_.Type -eq 'Product'} | Select-Object -First 1 -ExpandProperty Name
        $_ | Add-Member -MemberType NoteProperty -Value $_.UpdateIdentity.UpdateId -Name UpdateId
        $_ | Add-Member -MemberType NoteProperty -Value $_.UpdateIdentity.RevisionNumber -Name RevisionNumber
        $_ | Add-Member -MemberType NoteProperty -Value $Product -Name Product -PassThru
        Write-Output $_
        }
        #Remove null records and only return the fields we want
        $history |
        Where-Object {![String]::IsNullOrWhiteSpace($_.title)} |
        Select-Object Result, Date, Title, SupportUrl, Product, UpdateId, RevisionNumber
        }
      
        function Get-RamCPUStats{
          $totalRam = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).Sum
          while($count -le 5) {
              $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
              $cpuTime = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
              $availMem = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
              $date + ' > CPU: ' + $cpuTime.ToString("#,0.000") + '%, Avail. Mem.: ' + $availMem.ToString("N0") + 'MB (' + (104857600 * $availMem / $totalRam).ToString("#,0.0") + '%)'
              Start-Sleep -s 2
              $count += 1
          }
          }
      
        $LogicalProcessors = (Get-WmiObject -class Win32_processor -Property NumberOfLogicalProcessors).NumberOfLogicalProcessors;
        write-host ""
        write-host ""
        write-host "Running Processes (Takes a minute to load)"
        write-host "--------------------------------------"
        myTopFunc -SortCol $SortCol -top $Top
        write-host ""
        write-host ""
        write-host "Windows Updates"
        write-host "--------------------------------------"
        Get-WuaHistory | Format-Table 


        #Find free space of C:, if its less than 50GB the turn text red
        write-host "Hard Drive Space"
        write-host "--------------------------------------"
        $HDDFree = Get-CimInstance -ClassName Win32_LogicalDisk -Filter 'DeviceId = "C:"' | Select-Object -Property DeviceID,@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB) }} 
        if ($HDDFree.'FreeSpace (GB)' -lt 50){
            Write-Host "FreeSpace (GB) C: " -fore White -nonewline; write-host $HDDFree.'FreeSpace (GB)' -fore Red
            }
        else{
            Write-Host "FreeSpace (GB) C: " -fore White -nonewline; write-host $HDDFree.'FreeSpace (GB)' -fore Green
        }
        write-host ""
        write-host ""
        write-host "CPU Information"
        write-host "--------------------------------------"
        Get-RamCPUStats
        write-host ""
        write-host ""
        write-host "Restart Reasons"
        write-host "--------------------------------------"
        $rebootreason = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 1074} |Select-Object -First 20 | Format-Table TimeCreated,Message -wrap
        $rebootreason
        
      }
    }
    }  } until ($choice -eq 2) 

    
<#      $rerun = Read-Host "Run Agin? (Y/N)"
      if ($rerun.ToUpper() = "Y"){
        
      }
      else {
        $i=0
        write-host "i is: $i"
        Exit-PSSession
      }
  }

  #>

  # Maybe better indicator
  #Get-EventLog -LogName system -Source user32 | Format-Table TimeGenerated,Message


  #Select seems to allow more controll that Format Table
  # Get-EventLog -LogName system -Source user32 | Select TimeGenerated,Message | sort TimeGenerated