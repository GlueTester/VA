<#Connect to GitHub Runner and Azure Powershell
 
•	Run from GitHub Action Runner after hours (vac30opsacs211.va.gov)
•	Google search for "Invoke-FslShrinkDisk" for details
•	Launch Powershell ***AS ADMINISTRATOR***
o	Connect-AzAccount
•	Login with NEMA account
o	Change subscription
•	Set-AzContext -SubscriptionName "ACS-MAP-INTERNAL"
 
 
Generate list of profiles that are older than 90 days
 
•	Read list of AVD profile shares
o	$shares = get-content C:\Users\VHAMOUBYRDN0\Documents\AVD_Volumes.txt
•	Declare array of results to work with for Old profiles
o	$EXPIREDprofiles = @()
•	Get profiles not accessed in the past 90 days
#>

Foreach ($share in $shares)
{
$profiles_expired = Get-ChildItem -Path $share -Filter *.vhdx -Recurse -File | where {($_.LastAccessTime -le (Get-Date).AddDays(-90))}
$EXPIREDprofiles += $profiles_expired
$Progress = [math]::round(([array]::IndexOf($Shares,$Share)/($Shares.Count/100)),2)
write-progress -activity "Working" -status "$Progress% Complete:" -percentcomplete $Progress
}
 
•	Export results to csv file
o	$EXPIREDprofiles | select FullName, LastWriteTime, @{Name="GB";Expression={ "{0:N0}" -f ($_.Length / 1GB) }} | Export-CSV C:\Users\VHAMOUBYRDN0\Documents\###DATE###_AVD_Storage_Maintenance\###DATE###_AVD_EXPIRED_Profiles.csv
 
 
Delete expired profiles
 
Foreach ($item in $EXPIREDprofiles)
{
Remove-Item -Path $item.FullName
}
 
 
Delete empty volumes
 
•	Create variable of AVD volumes
o	$Dir = Get-Content C:\Users\VHAMOUBYRDN0\Documents\AVD_Volumes.txt
•	Go through each volume to verify it has no subfiles or subfolders
 
Foreach ($item in $Dir)
{
(Get-ChildItem $item -Recurse | ? {$_.PSIsContainer -eq $True}) | ? {$_.GetFileSystemInfos().Count -eq 0} | Select FullName | Format-Table -AutoSize | Out-File -Append C:\Users\VHAMOUBYRDN0\Documents\###DATE###_AVD_Storage_Maintenance\###DATE###_Empty_Directories.txt
}
 
•	Manually remove headings, dashes, and spaces from Empty_Directories.txt
•	Create variable of empty directories
o	$EmptyFolders = Get-Content C:\Users\VHAMOUBYRDN0\Documents\###DATE###_Empty_Directories.txt
•	Remove empty directories
o	foreach ($folder in $EmptyFolders) {Remove-Item $folder}
 
 
Generate list of current profiles to have whitespace reclaimed
 
•	Declare array of results to work with for Active profiles
o	$TARGETprofiles = @()
•	Get profiles recently accessed
 
Foreach ($share in $shares)
{
$profiles_target = Get-ChildItem -Path $share -Filter *.vhdx -Recurse -File |where {($_.LastAccessTime -ge (Get-Date).AddDays(-30))}
$TARGETprofiles += $profiles_target
$Progress = [math]::round(([array]::IndexOf($Shares,$Share)/($Shares.Count/100)),2)
write-progress -activity "Working" -status "$Progress% Complete:" -percentcomplete $Progress
}
 
•	Export results to csv file
o	$TARGETprofiles | select DirectoryName, LastWriteTime, @{Name="MB";Expression={ "{0:N0}" -f ($_.Length / 1MB) }} | Export-CSV C:\Users\VHAMOUBYRDN0\Documents\###FOLDER###\###DATE###_AVD_Target_Profiles.csv
•	Loop through target list and clean up whitespace
 
ForEach ($item in $TARGETprofiles)
{
.\invoke-fslshrinkdisk.ps1 -Path $Item.DirectoryName -LogFilePath "C:\Users\VHAMOUBYRDN0\Documents\###DATE###_AVD_Storage_Maintenance\Profile_Cleanup_Log.csv"
}
