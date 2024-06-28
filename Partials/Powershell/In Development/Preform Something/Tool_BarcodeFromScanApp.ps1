# Prepend the 2-line header to the existing file content
# and save it back to the same file
# Adjust the encoding as needed.
$TimeFilename = ((Get-Date).ToString("MMddyyyy_HHMMss")+"_scan.txt")


function Open-File([string] $initialDirectory){
 
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.FileName = "Barcode*"
    $OpenFileDialog.filter = "CSV File (*.csv)| *.csv"
    $OpenFileDialog.ShowDialog() |  Out-Null

    return $OpenFileDialog.filename

} 
function Save-Folder([string] $initialDirectory){
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $directoryName = $dialog.SelectedPath
        
        return $directoryName
    }
}


$SourceFile = Open-File $env:USERPROFILE+"\Desktop"     
$SaveFolder = Save-Folder $env:USERPROFILE+"\Desktop" 
$SaveFile = $SaveFolder + "\" + $TimeFilename
$TempFile = "C:\temp\temp.txt"

@'
Barcode Type,Scan Result,Time,Date

'@ + (Get-Content -Raw $SourceFile) | Set-Content $SaveFile -NoNewline -Encoding utf8 #changes encoding to CSV for importing
(Import-CSV $SaveFile)| Select-Object -ExpandProperty "Scan Result"| Select-Object -Skip 2|Set-Content $TempFile -Encoding utf8 #Selects the Scan Result column and skips first two lines then save that to itself overwriting the wholething
$Count = Get-Content $TempFile | Measure-Object –Line | Select-Object -ExpandProperty Lines # Counts number of lines which are entrys 
Get-content $TempFile | ForEach-Object {$_ +  "`n"} |Set-Content $SaveFile -Encoding utf8 #place spaces in entries
Add-Content $SaveFile "***END***^$Count" #Adds END to the last line
@("ENNX", "ID") +  (Get-Content $SaveFile) | Set-Content $SaveFile #Adds ENNX and ID to the top

Remove-Item $SourceFile
Remove-Item $TempFile

