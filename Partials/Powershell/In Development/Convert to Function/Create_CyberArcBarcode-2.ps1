<#
Sources:
https://audministrator.wordpress.com/2019/04/09/powershell-create-a-barcode-form/
https://stackoverflow.com/questions/24386845/powershell-how-do-i-extract-the-first-line-of-all-text-files-in-a-directory-in
https://stackoverflow.com/questions/51067918/print-pdfs-to-specific-printers-based-on-filename
https://www.isunshare.com/windows-10/2-ways-to-view-installed-fonts-in-windows-10.html#:~:text=1%20Way%201%3A%20Check%20them%20with%20run%20command..,to%20realize%20the%20same%20goal%3F%20%20More%20
#>

<#
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
#>


$PassFile = "C:\Users\VHALEXKingR1\Desktop\VA Related\dailypass.txt" #Change to your password file
$loadfile = Get-Content $PassFile -Raw
$splitfile = $loadfile -split "Username:" -split "Password:"
$username=$splitfile[1]
#$password=$splitfile[3]
#write-host $password
$password = "test"

function Get-Code128String {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text
    )

    # Code 128 encoding logic here

    return $Code128String
}

$barcodeString = Get-Code128String -Text $password

$font = New-Object System.Drawing.Font("Libre Barcode 128 Text", 12)
Write-Host $barcodeString -ForegroundColor White -BackgroundColor Black -Font $font






