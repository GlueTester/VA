
<#
Usage 
PS C:\Users\OITLEXKINGR10> Office365Check("VHALEXTratcF")
Users License: LICENSED
Last Update: 4/19/2023 3:04:51 AM
AccountEnabled = True



#Sources
Calling website and formating table: https://stackoverflow.com/questions/38880325/how-to-select-html-attribute-values-with-powershell
Splitting : https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-7.3

Methodology
    #Source: https://stackoverflow.com/questions/68694696/scrape-webpage-using-powershell
    $request = Invoke-WebRequest -Uri 'https://www.kucoin.com/_api/currency/prices?base=USD&targets='
    $json = $request.Content | ConvertFrom-Json
    $json.data
    #Revision 1
    $request = Invoke-WebRequest -Uri 'https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov'
    $json = $request.Content | ConvertFrom-Json
    $json.data

    #Source: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-json?view=powershell-7.3
    # Ensures that Invoke-WebRequest uses TLS 1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $j = Invoke-WebRequest 'https://api.github.com/repos/PowerShell/PowerShell/issues' | ConvertFrom-Json    
    #Revision 1
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $k = Invoke-WebRequest 'https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov' | ConvertFrom-Json
    #Method 1 seemed better

    #Source: https://pipe.how/invoke-webscrape/
    $HTML = Invoke-RestMethod 'https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov'
    $HTML -match 'tr><td class= tableBold>License Attribute Value</td><td>UNLICENSED</td>'
    #Tabel data need from this result: <tr><td class= tableBold>License Attribute Value</td><td>UNLICENSED</td></tr><tr><td class= tableBold>Account Enabled</td><td>True</td></tr><tr></tr>


    #Working
    $r = Invoke-WebRequest -Uri "https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov" #get the page and save is a $r
    $h = $r.ParsedHtml.body.getElementsByTagName('table')  #this showed me all the tables and elements
    #I the found something uniqe about the table I wanted. For me this was "uniqieNumber"
    $h = $r.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}
    #now I want to just selets the "textContent" element and expand it out so i have no header
    $h = $r.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
    #now to split it up
    $h -split "Display Name"
    #ok now every slit I want
    $h -split "Display Name" -split "Mail" -split "User Principal Name" -split "Last Updated" -split "License Attribute Value" -split "Account Enabled"
    #Now make the whole thing an varaibale (actually an array) so I call call each prices?base
    $trimmed = $h -split "Display Name" -split "Mail" -split "User Principal Name" -split "Last Updated" -split "License Attribute Value" -split "Account Enabled"
    #now test
    $trimmed[5]
    #I know know the user has UNLICENSED as the License Attribute Value as its the 5th element in the array
#>

# The $SAMUsername and Office365Check($SAMUsername) at the end are for when not in use in a larger program

$SAMUsername = Read-Host "SAM ADname?"
function Office365Check($SAMUsername) {
$userADinfo = get-aduser -Filter {samAccountName -eq $SAMUsername}  -Properties * #To see other properies run this line and then call $userADinfo
$userADemail= $userADinfo | Select-Object -ExpandProperty 'Emailaddress'
#$Useremail="Allyson.Gabbard@va.gov"
$OfficeLicenseURL='https://findme.webmail.va.gov/data/?'+$userADemail
$webrequest = Invoke-WebRequest -Uri "$OfficeLicenseURL"
$r = Invoke-WebRequest -Uri "https://findme.webmail.va.gov/data/?Allyson.Gabbard@va.gov"
$h = $webrequest.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
$h = $webrequest.ParsedHtml.body.getElementsByTagName('table')| Where {$_.uniqueNumber -eq '1'}|Select-Object textContent
$s = $h -split "Display Name" -split "Mail" -split "User Principal Name" -split "Last Updated" -split "License Attribute Value" -split "Account Enabled"
$License= $s[5]
$LastUpdated= $s[4]
$AccountEnabled= $s[6]

Write-Host "Users License: $License
Last Update: $LastUpdated
AccountEnabled = $AccountEnabled
"
}

Office365Check($SAMUsername)