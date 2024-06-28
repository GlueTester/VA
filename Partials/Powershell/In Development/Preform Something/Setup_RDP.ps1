Add-Type -AssemblyName System.Windows.Forms
Function Show-MsgBox ($Text,$Title="",[Windows.Forms.MessageBoxButtons]$Button = "OK",[Windows.Forms.MessageBoxIcon]$Icon="Information"){
[Windows.Forms.MessageBox]::Show("$Text", "$Title", [Windows.Forms.MessageBoxButtons]::$Button, $Icon) | ?{(!($_ -eq "OK"))}
}

If((Show-MsgBox -Title 'Confirm File' -Text 'Please make.TXT file with Username on line 1 and CyberArc Daily Pass on line 2. Example:

OILEXKINGR10
63248BFN()#231fgfkyWC

 Have you made this file yet?' -Button YesNo -Icon Warning) -eq 'No'){Exit}


#Copy-Item "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Scripts\Releases\Admin_RDP" -Destination $PassFileDir