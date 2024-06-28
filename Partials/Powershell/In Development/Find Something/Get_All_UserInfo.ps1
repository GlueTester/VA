clear
$LoginStatsDir = "\\v09.med.va.gov\LEX\Workgroup\Public\LogonScripts\Lognoff$\loginstats\"
$X=20


function Office365Check($SAMUsername) {
$userADinfo = get-aduser -Filter {samAccountName -eq $SAMUsername}  -Properties * #To see other properies run this line and then call $userADinfo
$userADemail= $userADinfo | Select-Object -ExpandProperty 'Emailaddress'
#$Useremail="Allyson.Gabbard@va.gov"
$OfficeLicenseURL='https://findme.webmail.va.gov/data/?'+$userADemail
$webrequest = Invoke-WebRequest -Uri "$OfficeLicenseURL"
#$r = Invoke-WebRequest -Uri "https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov"
#$h = $webrequest.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
$h = $webrequest.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
$s = $h -split "Display Name" -split "Mail" -split "User Principal Name" -split "Last Updated" -split "License Attribute Value" -split "Account Enabled"
$License= $s[5]
$LastUpdated= $s[4]
$AccountEnabled= $s[6]
Write-Host "Users License: $License
Last Update: $LastUpdated
AccountEnabled = $AccountEnabled
" -fore gray
}

$SAMUsername = Read-Host "What is the AD Name?"
#$SAMUsername = $textbox_EE.Text
$userinfo = get-aduser -Filter {samAccountName -eq $SAMUsername} -Properties *
write-host "Name: " -fore gray -nonewline; write-host $userinfo.Name -fore Green
write-host "Email: " -fore gray -nonewline; write-host $userinfo.UserPrincipalName -fore Green
write-host "Account Enabled: " -fore gray -nonewline; write-host $userinfo.Enabled -fore Green
write-host "Last Name: " -fore gray -nonewline; write-host $userinfo.Surname -fore Green
write-host "First Name: " -fore gray -nonewline; write-host $userinfo.GivenName -fore Green
write-host "Title: " -fore gray -nonewline; write-host $userinfo.Description -fore Green
write-host "AD Location: " -fore gray -nonewline; write-host $userinfo.DistinguishedName -fore Green;
write-host "`n"

Write-Host "Office 365 License Check..."-fore White
Office365Check($SAMUsername)
write-host "Last $X systems logged into " -fore White
$UserLogFile = $LoginStatsDir+"$SAMUsername.log"
if ($UserLogFile) {
$LastLogins = Get-Content -tail $X $UserLogFile
$LastLogins}

$CurrentDate = Get-Date -Format "yyyyMMdd"
$CurrentDate = $CurrentDate.ToString()
$SaveDir = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Scans\"

