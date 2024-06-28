Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::OK
$MessageboxTitle = "Clear User Certs"
$Messageboxbody = "Cleared other user certificates"
$MessageIcon = [System.Windows.MessageBoxImage]::Information
$userName = $env:UserName #Find Current user SAM account
$userinfo = get-aduser -Filter {samAccountName -eq $userName} -Properties * #Use SAM Account to fidn info in Active Directory
$cleanedname = $userinfo.extensionAttribute11.Replace(' ','*') #Grab the filed with full name and replace spaces with *
gci cert:\CurrentUser\My | where { $_.Subject -notlike "*$cleanedname*" } | where {$_.Subject -notlike '*O=Adobe*Systems*'} | foreach { Remove-Item $_.PSPath } #list all certs filter out current user and Adobe, then delete any remaining
[System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)

<#
Sources
[Replaceing] (https://lazyadmin.nl/powershell/powershell-replace/)
[get current user] (https://community.spiceworks.com/topic/2292690-powershell-to-delete-user-certificate)
[other stuff](https://superuser.com/questions/1331103/delete-windows-personals-certificate-from-command-line)
[more resources](https://stackoverflow.com/questions/30173347/delete-the-current-user-certificate-for-all-users)

#> 