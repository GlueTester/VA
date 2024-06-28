function get_cyberarkpass {
    param (
        #OptionalParameters
    )
<#   
start microsoft-edge:https://vahinwebcya310.aac.dva.va.gov/PasswordVault/v10/logon?returnUrl=%2F
$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('Password Vault')
Sleep 2
$wshell.SendKeys('{TAB}') #Tab Enter, Tab,Right Enter
$wshell.SendKeys('{ENTER}')
$wshell.SendKeys('{TAB}')
$wshell.SendKeys('{RIGHT}')
$wshell.SendKeys('{ENTER}')
$pass = Read-Host "Please enter daily pass"   --AsSecureString
#>
$pass ="[q7JI0k{fynO.\d"
 #SOURCE https://stackoverflow.com/questions/60780548/create-htpasswd-sha1-password-in-powershell
# Compute hash over password
$passwordBytes = [System.Text.Encoding]::ASCII.GetBytes($pass)
$sha256 = [System.Security.Cryptography.SHA256]::Create()
$hash = $sha256.ComputeHash($passwordBytes)
    
# Convert resulting bytes to base64
$hashedpasswd = [convert]::ToBase64String($hash)
    
# Generate htpasswd entry
"SHA256 password: ${hashedpasswd}"
$pass
}
