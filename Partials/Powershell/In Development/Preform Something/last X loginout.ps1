$ComputerStatsFile = "Y:\Public\LogonScripts\Lognoff$\machinestats\$Computer.log"
$MachineLastLogin = Get-Content -tail 1 $ComputerStatsFile


ForEach ($Computer in $OUComputerList) {
    $MachineLogFile = $MachineStatsDir+"$Computer.log"
        
    if ($MachineLogFile) {
    }
    $MachineLastLogin = Get-Content -tail 1 $ComputerStatsFile