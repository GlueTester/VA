
$path = "C:\Users\VHALEXKingR1\Desktop\VA Related\dailypass.txt"

function Read-File($line){
    $read_line = Get-Content $path | Select -First $line
    return $read_line
    
}
Read-File(1)