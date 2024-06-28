
$global:RebootReason = $null
$global:UpdateHistory = $null
$global:PCName = $null
$global:PCInfo= $null
$exit= 2

function Get_PCName($EE) {
    $PCName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'
    #$PCName = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'DC=v09,DC=med,DC=va,DC=gov'
    return $PCName.Name
    }

function Get_PCInfo($PCName){
    $PCInfo = Get-ADComputer $PCName -Properties *
    #$rebootreason = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 1074} | Format-Table -wrap
    Write-Host "System Name:" -fore White -nonewline; write-host $PCInfo.Name -fore Green
        if ($PCName.Enabled){
        Write-Host "System Enabled:" -fore White -nonewline; write-host $PCInfo.Enabled -fore Green
        }
        else{
            Write-Host "System Enabled:" -fore White -nonewline; write-host $PCInfo.Enabled -fore Red
        }
    #return $PCName
}

function Get_RebootReason($PCName){
  IF ($PCName){
  $RebootReason = Get-WinEvent -FilterHashtable @{logname = 'System'; id = 1074} -ComputerName $PCName | Format-Table -wrap}
  else {
    write-host "no pcname"
  }
  return $RebootReason
}


function WindowsUpdates($PCName) {

    Invoke-Command -ComputerName $PCName -Scriptblock { 
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
            $history = $session.QueryHistory("",0,25) | ForEach-Object {
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
            Get-WuaHistory | Format-Table 

                }
            }
function Menu($PCName) {
    $on = 1
    While ($on -eq 1){
    Write-Host "Please selection action number" -ForegroundColor Blue -BackgroundColor white
    Write-Host "1." -ForegroundColor Blue -BackgroundColor White -NoNewline ; Write-Host " Reboot Reason" 
    Write-Host "2." -ForegroundColor Blue -BackgroundColor White -NoNewline ; Write-Host " Update History" 
    Write-Host "3." -ForegroundColor Blue -BackgroundColor White -NoNewline ; Write-Host " Remove All Profiles" 
    Write-Host "4." -ForegroundColor Blue -BackgroundColor White -NoNewline ; Write-Host " New Search" 
    Write-Host "5." -ForegroundColor Blue -BackgroundColor White -NoNewline ; Write-Host " Exit" 
    $Choice = Read-Host "Please select your action: "
    
    switch ($Choice)
            {
            1 {"Reboot Reasons" ; Get_RebootReason($PCName)}
            2 {"Update History" ; WindowsUpdates($PCName)}
            3 {"Remove All Profiles" }
            4 {"New Search" ; $on = 0 }
            5 {"Exit" ; exit }
            Default {"No matches"}
            }
    }
    }

While (1){
    clear
    $EE = Read-Host "Please enter the EE"
    $PCName = Get_PCName($EE)
    Get_PCInfo($PCName)
    Menu($PCName)
}




