$CVSFile =Import-Csv -Path "C:\Users\VHALEXKingR1\Desktop\App Shortcuts.csv"
$DestinationPath =$CVSFile.DestPath
$SourcePath = $CVSFile.SourcePath
$TargetURL = $CVSFile.TargetURL
for($i = 0; $i -lt $CVSFile.length; $i++){ 

$ShortcutLocation = "C:\Users\VHALEXKingR1\Desktop\$($DestinationPath[$i])"
$SourceFileLocation = $TargetURL[$i]

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
$Shortcut.TargetPath = $SourceFileLocation
$Shortcut.Save()
}