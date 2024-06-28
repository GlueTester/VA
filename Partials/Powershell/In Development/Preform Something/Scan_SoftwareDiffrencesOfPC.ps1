# New to fidn new image and gather all from it to compaire
# 
#
#
#


#Declare variables and imports
import-module activedirectory

Set-Location "C:\temp\scans\"
<#
do {
  if ($Finalfile -eq $null){
  }
  else{Write-Host "Last scan results saved: C:\temp\scans\$Finalfile " -fore green -nonewline}
  Write-Host "--Same Same --"
  Write-Host "1. Compare two systems"
  Write-host "2. Quit"
  $choice=Read-Host "Chose a number to continue"

  switch ($choice)
{
  1 {
 
    cls
 #>   
      #Write to log file
      $LogFile = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Logs\SameSame.log" 
      $SourcePC = $null
      $DesinationPC = $null
      $OldComputer = $null
      $NewComputer = $null
      $tempFile = "tester.txt"
      $FinalFileDir = "C:\temp\scans\"
      $Finalfile = "$SourcePC.csv"
      $OUSearchScope = 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'


      Function Get-Software  {

        [OutputType('System.Software.Inventory')]

        [Cmdletbinding()] 

        Param( 

        [Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)] 

        [String[]]$Computername=$env:COMPUTERNAME

        )         

        Begin {

        }

        Process  {     

        ForEach  ($Computer in  $Computername){ 

        If  (Test-Connection -ComputerName  $Computer -Count  1 -Quiet) {

        $Paths  = @("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall","SOFTWARE\\Wow6432node\\Microsoft\\Windows\\CurrentVersion\\Uninstall")         

        ForEach($Path in $Paths) { 

        Write-Verbose  "Checking Path: $Path"

        #  Create an instance of the Registry Object and open the HKLM base key 

        Try  { 

        $reg=[microsoft.win32.registrykey]::OpenRemoteBaseKey('LocalMachine',$Computer,'Registry64') 

        } Catch  { 

        Write-Error $_ 

        Continue 

        } 

        #  Drill down into the Uninstall key using the OpenSubKey Method 

        Try  {

        $regkey=$reg.OpenSubKey($Path)  

        # Retrieve an array of string that contain all the subkey names 

        $subkeys=$regkey.GetSubKeyNames()      

        # Open each Subkey and use GetValue Method to return the required  values for each 

        ForEach ($key in $subkeys){   

        Write-Verbose "Key: $Key"

        $thisKey=$Path+"\\"+$key 

        Try {  

        $thisSubKey=$reg.OpenSubKey($thisKey)   

        # Prevent Objects with empty DisplayName 

        $DisplayName =  $thisSubKey.getValue("DisplayName")

        If ($DisplayName  -AND $DisplayName  -notmatch '^Update  for|rollup|^Security Update|^Service Pack|^HotFix') {

        $Date = $thisSubKey.GetValue('InstallDate')

        If ($Date) {

        Try {

        $Date = [datetime]::ParseExact($Date, 'yyyyMMdd', $Null)

        } Catch{

        Write-Warning "$($Computer): $_ <$($Date)>"

        $Date = $Null

        }

        } 

        # Create New Object with empty Properties 

        $Publisher =  Try {

        $thisSubKey.GetValue('Publisher').Trim()

        } 

        Catch {

        $thisSubKey.GetValue('Publisher')

        }

        $Version = Try {

        #Some weirdness with trailing [char]0 on some strings

        $thisSubKey.GetValue('DisplayVersion').TrimEnd(([char[]](32,0)))

        } 

        Catch {

        $thisSubKey.GetValue('DisplayVersion')

        }

        $UninstallString =  Try {

        $thisSubKey.GetValue('UninstallString').Trim()

        } 

        Catch {

        $thisSubKey.GetValue('UninstallString')

        }

        $InstallLocation =  Try {

        $thisSubKey.GetValue('InstallLocation').Trim()

        } 

        Catch {

        $thisSubKey.GetValue('InstallLocation')

        }

        $InstallSource =  Try {

        $thisSubKey.GetValue('InstallSource').Trim()

        } 

        Catch {

        $thisSubKey.GetValue('InstallSource')

        }

        $HelpLink = Try {

        $thisSubKey.GetValue('HelpLink').Trim()

        } 

        Catch {

        $thisSubKey.GetValue('HelpLink')

        }

        $Object = [pscustomobject]@{

        Computername = $Computer

        DisplayName = $DisplayName

        Version  = $Version

        InstallDate = $Date

        Publisher = $Publisher

        UninstallString = $UninstallString

        InstallLocation = $InstallLocation

        InstallSource  = $InstallSource

        HelpLink = $thisSubKey.GetValue('HelpLink')

        EstimatedSizeMB = [decimal]([math]::Round(($thisSubKey.GetValue('EstimatedSize')*1024)/1MB,2))

        }

        $Object.pstypenames.insert(0,'System.Software.Inventory')

        Write-Output $Object

        }

        } Catch {

        Write-Warning "$Key : $_"

        }   

        }

        } Catch  {}   

        $reg.Close() 

        }                  

        } Else  {

        Write-Error  "$($Computer): unable to reach remote system!"

        }

        } 

        } 

      }  

      Function Resolve_EE  {
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
                          EasyRead "INFO" "yellow" "The partial name $EE could be found in normal OU. Searching 1 level higher." "white"
                          
                          $HostnameSearch_lvl2 = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope.Split(",", 2)[1] | Select-Object -ExpandProperty Name #Searches : OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                          if (!$HostnameSearch_lvl2) {
                              EasyRead "INFO" "yellow" "The partial name $EE could not be found. Searching 2 levels higher. Trying 3 levels higher" "white"
                              $HostnameSearch_lvl3 = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase $OUSearchScope.Split(",", 3)[2] | Select-Object -ExpandProperty Name #Searches : OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                              
                              if (!$HostnameSearch_lvl3) {
                                  $Hostname = $EE
                                  #$HostnameArray.Add($Hostname) > $null
                                  #$ADLocationArray.Add("Not Found") > $null
                                  EasyRead "FAIL" "red" "The partial name $EE could not be found. Searching 3 levels higher. Trying 4 levels higher" "white"
                                  #Write-Host "The EE [$EE] could not be located in OU: " $OUSearchScope.Split(",", 3)[2] -foreground Red #NEVER Found
                              }
                              else {
                                  $Hostname = $HostnameSearch_lvl3
                                  #$HostnameArray.Add($Hostname) > $null
                                  #$ADLocationArray.Add($OUSearchScope.Split(",", 3)[2]) > $null
                                  EasyRead "OK" "green" "The partial name $EE resolves to $Hostname" "white"
                                  #Write-Host "The EE  [$EE] resolves to [$Hostname] It was in OU:  $OUSearchScope.Split(",", 3)[2]" -foreground Green #Found in OU: OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                                  return $Hostname
                                  }
                          }
                          else {
                              $Hostname = $HostnameSearch_lvl2
                              #$HostnameArray.Add($Hostname) > $null
                              #$ADLocationArray.Add($OUSearchScope.Split(",", 2)[1]) > $null
                              EasyRead "OK" "green" "The partial name $EE resolves to $Hostname" "white"
                              # Write-Host "The EE  [$EE] resolves to [$Hostname] It was in OU: " $OUSearchScope.Split(",", 2)[1] -foreground Green #Found in OU: OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                              return $Hostname
                            }
                      }       
                      else {
                          $Hostname = $HostnameSearch_lvl1
                          #$HostnameArray.Add($Hostname) > $null
                          #$ADLocationArray.Add($OUSearchScope) > $null
                          EasyRead "OK" "green" "The partial name  $EE resolves to $Hostname" "white" #Found in : OU=Laptops,OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov
                          return $Hostname
                          }
                      
                      }
                #return $Hostname
              #Sources:
              #https://adamtheautomator.com/powershell-parameter/
      }

      Function Get_PCName($EE) {
        $PCName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'
        #$PCName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'DC=v09,DC=med,DC=va,DC=gov'
        return $PCName.Name
        }

      Function EasyRead{
        param(
            [string] $Status,
            [string] $StatusTextColor,
            [string] $Comment,
            [string] $CommentTextColor
        )
        switch ($Status.Trim()) {
            "" {  $Status = "      " }
            "INFO" {  $Status = " INFO " }
            "OK" { $Status = "  OK  "}
            "FAIL" { $Status = " FAIL "}
            Default {}
        }
          Write-Host "[ $Status ]" -fore $StatusTextColor -nonewline; Write-Host "      - $Comment " -fore $CommentTextColor

          <#
          Usage:
              EasyRead "OK" "green" "this is a test" "white"
          #>
      }



      #Gather EE from user and ensure they can be found in AD
      While ($SourcePC -eq $null){
        $OldComputer = Read-Host "Please enter OLD PC EE"
        EasyRead "" "yellow" "Searching for $OldComputer" "white"
          If ($OldComputer){
            $SourcePC = Resolve_EE ( $OldComputer )
            #$SourcePC = Get_PCName $OldComputer
            if ($SourcePC) {
              EasyRead "" "yellow" "Checking if $SourcePC is online" "white"
              
              if (test-connection $SourcePC -count 1 -quiet) { EasyRead "OK" "green" "$SourcePC is online" "white"} 
              else {EasyRead "FAIL" "red" "$SourcePC is offline, check another machine" "red"; $SourcePC = $null}
        
            }
            else {EasyRead "FAIL" "red" "Could not find the $OldComputer" "red"}
          }
        }

      While ($DesinationPC -eq $null){
        $NewComputer = Read-Host "Please enter New PC EE"
        EasyRead "" "yellow" "Searching for $NewComputer" "white"
        If ($NewComputer){
          $DesinationPC = Resolve_EE ( $NewComputer )
          #$DesinationPC = Get_PCName $NewComputer
          if ($DesinationPC) {
            EasyRead "" "yellow" "Checking if  $DesinationPC is online" "white"
            
            if (test-connection $DesinationPC -count 1 -quiet) { EasyRead "OK" "green" "$DesinationPC is online" "white"} 
            else {EasyRead "FAIL" "red" "$DesinationPC is offline, check another machine" "red"; $DesinationPC = $null}

          }
          else {EasyRead "FAIL" "red" "Could not find $NewComputer" "red"}
        }
      }

      filter leftside{
        #https://stackoverflow.com/questions/28342081/compare-object-left-or-right-side-only
        param(
                [Parameter(Position=0, Mandatory=$true,ValueFromPipeline = $true)]
                [ValidateNotNullOrEmpty()]
                [PSCustomObject]
                $obj
            )
        
            $obj|?{$_.sideindicator -eq '<='}
        
        }

      filter rightside{
        #https://stackoverflow.com/questions/28342081/compare-object-left-or-right-side-only
        param(
                [Parameter(Position=0, Mandatory=$true,ValueFromPipeline = $true)]
                [ValidateNotNullOrEmpty()]
                [PSCustomObject]
                $obj
            )
        
            $obj|?{$_.sideindicator -eq '=>'}
        
        }

      filter bothside{
        #https://stackoverflow.com/questions/28342081/compare-object-left-or-right-side-only
        param(
                [Parameter(Position=0, Mandatory=$true,ValueFromPipeline = $true)]
                [ValidateNotNullOrEmpty()]
                [PSCustomObject]
                $obj
            )
        
            $obj|?{$_.sideindicator -eq '=='}
        
        }



      #Scan the Systems to put application in a variable
      "$(get-date -format "yyyy-MM-dd HH:mm:ss"),$Env:UserName,Source:$SourcePC Destination:$DesinationPC" | out-file $LogFile -Append  
      $SourceList = (Get-Software $SourcePC | Select-Object -Property DisplayName)# >> $SourcePC".txt"
      EasyRead "INFO" "green" "Scanning $DesinationPC applications" "white"
      $DesinatioList = try { Get-Software $DesinationPC | Select-Object -Property DisplayName } #https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.4
        catch {
            Write-Host "An error occurred:"
            Write-Host $_.ScriptStackTrace
        }
          #Get-Software $DesinationPC | Select-Object -Property DisplayName
        

      #Compare list to creat a list of the diffrences
      $Source_Dest_Compare = Compare-Object -ReferenceObject ($SourceList.DisplayName| Sort DisplayName) -DifferenceObject ($DesinatioList.DisplayName| Sort DisplayName)| leftside | Select-Object -ExpandProperty InputObject


      #Declare application to ignore
      $Known_false = @(
        "1E Client x64",
        "ActivClient",
        "Adobe Acrobat Reader",
        "Adobe Refresh Manager",
        "Backup My Software Certificate",
        "BGInfo",
        "BigFix Client",
        "BigFix Remote Control - Target",
        "BlackBerry AtHoc Desktop Notifier",
        "CAPI2 Operations log",
        "Caradigm PEM",
        "Caradigm SSO and Context Management",
        "Cisco WebEx Document Loader",
        "Citrix Authentication Manager",
        "Citrix Screen Casting for Windows",
        "Citrix Web Helper",
        "Citrix Workspace 2203",
        "Citrix Workspace Inside",
        "Citrix Workspace(DV)",
        "Citrix Workspace(USB)",
        "CM",
        "Cofense Reporter",
        "Configuration Manager Client",
        "COVID 19 Desktop Shortcut",
        "CPRS Crypto Update",
        "CreateLogFolder1.0",
        "DefaultPackMSI",
        "ePas Signature Tools",
        "Exploit Guard Defaults",
        "Google Chrome",
        "IDEMIA Minidriver for PIV/CIV (64-bit)",
        "iMedConsent epad Update",
        "iMedConsent Signature Canvas 2016 (Elm)",
        "iMedConsent VA Workstation Components 2018",
        "Local Administrator Password Solution",
        "LogOffUser1.0_x64",
        "LynxClient",
        "MDOP MBAM",
        "Micro Focus  - R03 - Companion Package",
        "Micro Focus Reflection Cleanup",
        "Micro Focus Reflection Desktop Pro",
        "Micro Focus Reflection Desktop Pro",
        "Micro Focus Reflection DLL for 2FA",
        "Microsoft .NET Host - 6.0.28 (x64)",
        "Microsoft .NET Host - 6.0.28 (x86)",
        "Microsoft .NET Host FX Resolver - 6.0.28 (x64)",
        "Microsoft .NET Host FX Resolver - 6.0.28 (x86)",
        "Microsoft .NET Runtime - 6.0.28 (x64)",
        "Microsoft .NET Runtime - 6.0.28 (x86)",
        "Microsoft 365 Apps Fonts",
        "Microsoft 365 Apps for enterprise - en-us",
        "Microsoft Edge",
        "Microsoft Edge Update",
        "Microsoft Edge WebView2 Runtime",
        "Microsoft Intune Management Extension",
        "Microsoft OneDrive",
        "Microsoft Policy Platform",
        "Microsoft Search in Bing",
        "Microsoft Teams Meeting Add-in for Microsoft Office",
        "Microsoft Update Health Tools",
        "Microsoft Visual Basic for Applications 7.1 (x86)",
        "Microsoft Visual Basic for Applications 7.1 (x86) English",
        "Microsoft Visual C++ 2010  x64 Redistributable - 10.0.40219",
        "Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.30501",
        "Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.21005",
        "Microsoft Visual C++ 2013 Redistributable (x86) - 12.0.30501",
        "Microsoft Visual C++ 2013 x64 Additional Runtime - 12.0.21005",
        "Microsoft Visual C++ 2013 x64 Minimum Runtime - 12.0.21005",
        "Microsoft Visual C++ 2013 x86 Additional Runtime - 12.0.21005",
        "Microsoft Visual C++ 2013 x86 Minimum Runtime - 12.0.21005",
        "Microsoft Visual C++ 2015-2022 Redistributable (x64) - 14.36.32532",
        "Microsoft Visual C++ 2015-2022 Redistributable (x86) - 14.36.32532",
        "Microsoft Visual C++ 2022 X64 Additional Runtime - 14.36.32532",
        "Microsoft Visual C++ 2022 X64 Minimum Runtime - 14.36.32532",
        "Microsoft Visual C++ 2022 X86 Additional Runtime - 14.36.32532",
        "Microsoft Visual C++ 2022 X86 Minimum Runtime - 14.36.32532",
        "Microsoft Windows Desktop Runtime - 6.0.28 (x64)",
        "Microsoft Windows Desktop Runtime - 6.0.28 (x64)",
        "Microsoft Windows Desktop Runtime - 6.0.28 (x86)",
        "Microsoft Windows Desktop Runtime - 6.0.28 (x86)",
        "Netwrix PolicyPak Client-Side Extension",
        "Office 16 Click-to-Run Extensibility Component",
        "Office 16 Click-to-Run Extensibility Component 64-bit Registration",
        "Office 16 Click-to-Run Licensing Component",
        "Online Plug-in",
        "OrderComm",
        "PolicyPak License",
        "PowerShell 7.4.1.0-x64",
        "PowerShell 7-x64",
        "Publish My eMail Certs",
        "Remote Desktop",
        "SAFE Agent",
        "SafeNet Minidriver 10.8 R6",
        "Self-service Plug-in",
        "Teams Machine-Wide Installer",
        "TeamsBackgrounds",
        "Trellix Agent",
        "Trellix Agent",
        "Trellix Data Exchange Layer for TA",
        "Trellix Data Exchange Layer for TA",
        "Trellix Data Loss Prevention - Endpoint",
        "Trellix Endpoint Security Adaptive Threat Protection",
        "Trellix Endpoint Security Firewall",
        "Trellix Endpoint Security Platform",
        "Trellix Endpoint Security Threat Prevention",
        "Trellix Endpoint Security Web Control",
        "Trellix Solidifier",
        "Universal Imaging Utility - Live Version",
        "VA dTools Shared Computer Identifier 5.30 (Auto) - Shared",
        "VA dTools Shared Identifier - Office ProPlus - Shared",
        "VA Reflection Workspace Elevated Program",
        "VA TRM Software Removal",
        "VistA Imaging Clinical Capture",
        "VistA Imaging Clinical Display",
        "VistA Imaging Telereader",
        "Webex",
        "Windows 10 Feature Update Setup Priority",
        "Windows 10 SMT Preparation",
        "Windows Built-In Apps Management",
        "Windows Driver Package - IDEMIA (UMPass) SmartCard  (06/25/2021 1.2.8.438)",
        "WinVerifyTrust Signature Validation Mitigation"
        )


      # Compare $Source_Dest_Compare to $Known_false and only select ones that are not on $Source_Dest_Compare and not in $Known_false
      if ($Source_Dest_Compare){
      $Final = Compare-Object -ReferenceObject $Source_Dest_Compare -DifferenceObject $Known_false |leftside | Select-Object -ExpandProperty InputObject

      #Display the output in alabetical order


      $SourcePC | Out-File $tempFile -Append
      $Final | Sort-Object |  Out-File $tempFile -Append
      import-csv $tempFile -delimiter "`t" | export-csv $FinalFileDir$SourcePC.csv -NoType  #https://stackoverflow.com/questions/8970312/converting-txt-file-to-csv-in-powershell
      rm $tempFile

      #View in Powershell
      $Final | Sort-Object
      }
    
      else{
      EasyRead "OK" "green" "Found no special software on $SourcePC" "white"
      }


      #Sources
      #https://learn.microsoft.com/en-us/powershell/scripting/samples/sorting-objects?view=powershell-7.4
      #https://stackoverflow.com/questions/9518774/powershell-sort-array
      #


      #magice maker
      # $DesinatioList | Select-Object -ExpandProperty "DisplayName" | Sort-Object | Out-File corted.txt ; import-csv corted.txt -delimiter "`t" | export-csv corted.csv -Append -NoType ; rm corted.txt
      # 
 
 
      #   }
#}}until ($choice -eq 2) 