$remote_computer = "LEX-MA112388"
$module_source = "\\v09.med.va.gov\LEX\Service\IMS\+ Hardware Team\Scripts\Testing\DellBIOS\DellBIOSProvider"
$module_destination = "\\$remote_computer\c$\Program Files\WindowsPowerShell\Modules\DellBIOSProvider"
#$remote_bios_pwd = "password123"


#Copy the module to the remote computer’s Module directory
Copy-Item -Path $module_source -Destination $module_destination -Recurse


<#
Get BIOS settings
You can now use the Invoke-Command cmdlet to import the module on the remote machine and run commands. In the code below by using Get-Item on the DellSMBios provider made available by the module.
Notice that the module is imported and removed within each Invoke-Command ScriptBlock.
#>
Invoke-Command -ComputerName $remote_computer -ScriptBlock {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned }

Invoke-Command -ComputerName $remote_computer -ScriptBlock {
    Import-Module -Name "DellBIOSProvider"
    Get-Item -Path DellSMBios:\PowerManagement\* | Select-Object PSChildName,Description | Format-Table
    Remove-Module -Name "DellBIOSProvider" }

Invoke-Command -ComputerName $remote_computer -ScriptBlock {
    Import-Module -Name "DellBIOSProvider"
    Get-Item -Path DellSMBios:\PowerManagement\AcPwrRcvry
    Remove-Module -Name "DellBIOSProvider" }