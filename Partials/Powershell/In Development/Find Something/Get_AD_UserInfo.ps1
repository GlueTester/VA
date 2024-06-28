$SAMUsername = Read-Host "What is the AD Name?"
$userinfo = get-aduser -Filter {samAccountName -eq $SAMUsername} -Properties *
write-host "Name: " -fore White -nonewline; write-host $userinfo.Name -fore Green
write-host "Email: " -fore White -nonewline; write-host $userinfo.UserPrincipalName -fore Green
write-host "Account Enabled: " -fore White -nonewline; write-host $userinfo.Enabled -fore Green
write-host "Last Name: " -fore White -nonewline; write-host $userinfo.Surname -fore Green
write-host "First Name: " -fore White -nonewline; write-host $userinfo.GivenName -fore Green
write-host "Title: " -fore White -nonewline; write-host $userinfo.Description -fore Green
write-host "AD Location: " -fore White -nonewline; write-host $userinfo.DistinguishedName -fore Green


