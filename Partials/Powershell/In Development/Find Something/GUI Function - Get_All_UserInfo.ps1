	#TODO: Place custom script here
	$LoginStatsDir = "\\v09.med.va.gov\LEX\Workgroup\Public\LogonScripts\Lognoff$\loginstats\"
	$X = 20
	function Office365Check($SAMUsername)
	{
		$userADinfo = get-aduser -Filter { samAccountName -eq $SAMUsername } -Properties * #To see other properies run this line and then call $userADinfo
		$userADemail = $userADinfo | Select-Object -ExpandProperty 'Emailaddress'
		$OfficeLicenseURL = 'https://findme.webmail.va.gov/data/?' + $userADemail
		$webrequest = Invoke-WebRequest -Uri "$OfficeLicenseURL"
		$h = $webrequest.ParsedHtml.body.getElementsByTagName('table') | Where { $_.uniqueNumber -eq '1' } | Select-Object textContent
		$s = $h -split "Display Name" -split "Mail" -split "User Principal Name" -split "Last Updated" -split "License Attribute Value" -split "Account Enabled"
		$OfficeLicense = $s[5]
		$OfficeLastUpdated = $s[4]
		$OfficeAccountEnabled = $s[6]
		$OfficeAccStatus.Text = $OfficeAccountEnabled
		#return $PCName.Name
	}
	
	#$SAMUsername = Read-Host "What is the AD Name?"
	$SAMUsername = $textbox_EE.Text
	$userinfo = get-aduser -Filter { samAccountName -eq $SAMUsername } -Properties *
	#write-host "Name: " -fore gray -nonewline; write-host $userinfo.Name -fore Green
	#write-host "Email: " -fore gray -nonewline; write-host $userinfo.UserPrincipalName -fore Green
	#write-host "Account Enabled: " -fore gray -nonewline; write-host $userinfo.Enabled -fore Green
	#write-host "Last Name: " -fore gray -nonewline; write-host $userinfo.Surname -fore Green
	#write-host "First Name: " -fore gray -nonewline; write-host $userinfo.GivenName -fore Green
	#write-host "Title: " -fore gray -nonewline; write-host $userinfo.Description -fore Green
	#write-host "AD Location: " -fore gray -nonewline; write-host $userinfo.DistinguishedName -fore Green;
	#write-host "`n"
	
	$textbox_FullName.Text = "$userinfo.Surname $userinfo.GivenName"
	$textbox_Title.Text = $userinfo.Description
	$textbox_UserEmail.Text = $userinfo.UserPrincipalName
	
	#Change Enabled/Disabled Text for user
	if ($userinfo.Enabled -eq "Enabled") { $labelEnabledDisabled.Text = "Enabled" }
	elseif ($userinfo.Enabled -eq "Disabled") { $labelEnabledDisabled.Text = "Disabled" }
	
	Office365Check($SAMUsername)
	$UserLogFile = $LoginStatsDir + "$SAMUsername.log"
	if ($UserLogFile) { $LastLogins = Get-Content -tail $X $UserLogFile }
	
	$CurrentDate = Get-Date -Format "yyyyMMdd"
	$CurrentDate = $CurrentDate.ToString()
	$SaveDir = "\\v09.med.va.gov\lex\Service\IMS\+ Hardware Team\Testing\Scans\"