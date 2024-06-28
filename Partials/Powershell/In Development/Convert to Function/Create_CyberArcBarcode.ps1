<#
Sources:
https://audministrator.wordpress.com/2019/04/09/powershell-create-a-barcode-form/
https://stackoverflow.com/questions/24386845/powershell-how-do-i-extract-the-first-line-of-all-text-files-in-a-directory-in
https://stackoverflow.com/questions/51067918/print-pdfs-to-specific-printers-based-on-filename
https://www.isunshare.com/windows-10/2-ways-to-view-installed-fonts-in-windows-10.html#:~:text=1%20Way%201%3A%20Check%20them%20with%20run%20command..,to%20realize%20the%20same%20goal%3F%20%20More%20
#>


Function PrintPDF{
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.drawing
    
    $PrintPageHandler = {
        param([object]$sender, [System.Drawing.Printing.PrintPageEventArgs]$ev)
 
    $linesPerPage = 0
    $yPos = 0
    $count = 0
    $leftMargin = $ev.MarginBounds.Left
    $topMargin = $ev.MarginBounds.Top
    $line = $null
 
    $printFont = New-Object System.Drawing.Font("Libre Barcode 128 Text",30)
 
    # Calculate the number of lines per page.
    $linesPerPage = $ev.MarginBounds.Height / $printFont.GetHeight($ev.Graphics)
 
    # Print each line of the BarCode.
    $yPos = $topMargin + ($count * $printFont.GetHeight($ev.Graphics))
        write-host $yPos " " $count " " $linesPerPage
    $ev.Graphics.DrawString($oLabel.Text, $printFont, [System.Drawing.Brushes]::Black, $leftMargin, $yPos, (New-Object System.Drawing.StringFormat))
 
    # If more lines exist, print another page.
    if ($line -ne $null) 
      {
        $ev.HasMorePages = $true
      }
    else
      {
        $ev.HasMorePages = $false
      }
   }
 
    $pd = New-Object System.Drawing.Printing.PrintDocument
    $pd.PrinterSettings = New-Object System.Drawing.Printing.PrinterSettings
    $pd.PrinterSettings.PrinterName = '\\vhalexprt3.v09.med.va.gov\LEX-DPOITA058'
    $pd.PrinterSettings.PrintToFile = $false
    #$pd.PrinterSettings.PrintToFile = $true
 
    # https://social.technet.microsoft.com/Forums/scriptcenter/en-US/c7351021-800a-4ce9-bfa3-37b54e1750df/printing-a-windows-form?forum=winserverpowershell
    $pd.add_PrintPage($PrintPageHandler)
 
    #$pd.PrinterSettings.PrintFileName = "C:\Temp\Barcode.pdf"
     
    $pd.Print()
}


Function CreateForm {
 
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.drawing
  
    # Create a new Form Object
    $Form = New-Object System.Windows.Forms.Form
  
    # Create the size of your form 
    $Form.width = 1000
    $Form.height = 500
  
    # Set the name of the form 
    $Form.Text = ”This is a Barcode 39 Form”
  
    # Set the font of the text to be used within the form
    $Font = New-Object System.Drawing.Font("Arial",10)
    $Form.Font = $Font
  
    # Add and set the BarCode text and TTF Font
    #$oLabel = new-object System.Windows.Forms.Label
    #$oLabel.Location = new-object System.Drawing.Size(300,180) 
    #$oLabel.size = new-object System.Drawing.Size(600,80) 
     
    #$oLabel.Text = "*1234567*"
    #$oLabel.Font = New-Object System.Drawing.Font("CCode39",30)
     
    $Form.Controls.Add($oLabel)
    
    # Add a Print Button
    $oButton = New-Object Windows.Forms.Button
    $oButton.Text = "Print to PDF"
    $oButton.Top = 10
    $oButton.Left = 10
    $oButton.Width = 150
    $oButton.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right 
     
    $oButton.add_click({PrintPDF})
    $oButton.add_click({$oButton.Text = "PDF Created"})
     
    $Form.controls.add($oButton)
  
  
    $Form.Add_Shown({$Form.Activate()})
     
    #Show the Form
    #$Form.ShowDialog()| Out-Null
} 

# call the function 
CreateForm

$PassFile = "C:\Users\VHALEXKingR1\Desktop\VA Related\dailypass.txt" #Change to your password file
$loadfile = Get-Content $PassFile
$splitfile = $loadfile -split "Username:" -split "Password:"
$username=$splitfile[1]
$password=$splitfile[3]


$oLabel = new-object System.Windows.Forms.Label
    $oLabel.Location = new-object System.Drawing.Size(300,180) 
    $oLabel.size = new-object System.Drawing.Size(600,80) 
    $oLabel.Text = $password
    $oLabel.Font = New-Object System.Drawing.Font("Libre Barcode 128 Text",30)

PrintPDF($oLabel)





