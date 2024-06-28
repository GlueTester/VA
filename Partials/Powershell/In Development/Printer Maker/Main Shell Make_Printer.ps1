<#
Promtpt for current IP and EE
Dropdown of allowed printer types

Info need to grab remotelu
 Serial
 MAC
 Model

Info push remotley
    Customer Asset Tag: EE
    Lcoation:
    Device Name*:
    HostName:



$user = 'admin'
$pass = '47587188'

$pair = "$($user):$($pass)"

$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))

$basicAuthValue = "Basic $encodedCreds"

$Headers = @{
    Authorization = $basicAuthValue
}


[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'

$URL = 'https://10.74.40.10/'
$User = 'admin'
$Pass = '47587188'

$SecPass = ConvertTo-SecureString $Pass -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential($User, $SecPass)

$Cert = get-x509 $Cert64
set-SSLCertificate $Cert

Invoke-RestMethod -Uri $URL -Credential $Cred
#nvoke-WebRequest -SkipCertificateCheck -Uri 'https://10.74.40.239/connectivity/index.html#hashLogin' -Headers $Headers

#Source: https://stackoverflow.com/questions/27951561/use-invoke-webrequest-with-a-username-and-password-for-basic-authentication-on-t
#Source 2: https://stackoverflow.com/questions/56257442/trusting-self-signed-certificate-in-invoke-webrequest-call
#>


# Import necessary libraries
Add-Type -AssemblyName System.Web
Add-Type -AssemblyName System.Net.Http

# Define printer web page URL
$printerUrl = "https://10.74.40.10/home/index.html"

# Define static username and password
$username = "admin"
$password = "47587188"

# Convert password to secure string
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force

# Create a credential object
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Create an HttpWebRequest object
$webRequest = [System.Net.HttpWebRequest]::Create($printerUrl)
$webRequest.Credentials = $credential
$webRequest.Method = "GET"

# Ignore SSL certificate errors
$webRequest.ServerCertificateValidationCallback = { $true }

# Send the request and get the response
try {
    $webResponse = $webRequest.GetResponse()
    $stream = $webResponse.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($stream)
    $webpage = $reader.ReadToEnd()
} catch {
    Write-Host "Error occurred: $_"
    exit
} finally {
    if ($webResponse -ne $null) { $webResponse.Close() }
    if ($reader -ne $null) { $reader.Close() }
}

# Extract desired data using regular expressions or any other method
# For example, scraping the title of the webpage
$title = [System.Web.HttpUtility]::HtmlDecode([regex]::Match($webpage, "<title>(.*?)</title>").Groups[1].Value)

# Output the scraped data
Write-Output "Title of the printer's web page: $title"
