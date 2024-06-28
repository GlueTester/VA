$EE= Read-Host "Please enter PC EE"

$Computer = Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov'| Select -ExpandProperty Name

$battery ="powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0"
$pluggedin= "powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0"

if (Test-Connection -Cn $Computer)
{
  Invoke-Command -ComputerName $Computer -ScriptBlock {powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0} # 0 at end "Do nothing" | 1 at end "Sleep" | 2 at end "Hibernate" | 3 at end "Shut down"
  
  Invoke-Command -ComputerName $Computer -ScriptBlock {powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0} # 0 at end "Do nothing" | 1 at end "Sleep" | 2 at end "Hibernate" | 3 at end "Shut down"
} 
else 
{
 "$Computer is not online"
}

#Sources: https://www.tenforums.com/tutorials/69762-how-change-default-lid-close-action-windows-10-a.html