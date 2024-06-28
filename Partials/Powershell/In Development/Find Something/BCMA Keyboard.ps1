pnputil /enum-devices /class "Keyboard"


$Session = New-PSSession -ComputerName $NewBCMA
Invoke-Command -Session $Session -ScriptBlock {pnputil /enum-devices /class "Keyboard"} #/driverid $DeviceID}
pnputil /enum-devices /class "BarcodeScanner"

