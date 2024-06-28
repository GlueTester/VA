#$scheduleObject = New-Object -ComObject schedule.service
#$scheduleObject.connect()
#$rootFolder = $scheduleObject.GetFolder("\VA")
#$rootFolder.CreateFolder("dTools")
#Source: https://devblogs.microsoft.com/scripting/use-powershell-to-create-scheduled-tasks-folders/

$PC = Read-Host "What is the Computer Name"
$Session = New-PSSession -ComputerName $PC
Invoke-Command -ComputerName $Computer -ScriptBlock {$scheduleObject = New-Object -ComObject schedule.service ; $scheduleObject.connect() $rootFolder = $scheduleObject.GetFolder("\VA") ; $rootFolder.CreateFolder("dTools")} 