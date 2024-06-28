#Source: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-7.3
#https://stackoverflow.com/questions/28071270/powershell-textbox-securestring#:~:text=and%20then%20convert%20the%20text%20to%20a%20secure,stores%20the%20entered%20password%20as%20a%20secure%20string%3A




#$cred = Get-Credential

#$Credential = Get-Credential
$admin_UserName = "OITLEXKINGR10"
#$Credential.Password = Read-Host -AsSecureString



#$secure_password = Read-Host -AsSecureString
#$encrypted_password = ConvertFrom-SecureString -SecureString $Secure


#$Credential.Password = $Secure2 = ConvertTo-SecureString -String $Encrypted
#$Secure2

#start notepad -credential $Credential

#https://github.com/MicrosoftDocs/PowerShell-Docs/blob/main/reference/docs-conceptual/learn/deep-dives/add-credentials-to-powershell-functions.md
#$secpass = Get-Credential -UserName OITLEXKINGR10 -Message 'Enter Password'
$secure_password = Read-Host -AsSecureString

$Cred = New-Object System.Management.Automation.PSCredential ($admin_UserName, $secure_password)
$Credential = $Cred
function Run-Elevated {
    param(
        #$ComputerName,
        #$Path,
        #$Name,
        #$Value,
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential = [System.Management.Automation.PSCredential]::Empty
    )
    $null = Invoke-Command -Credential $Credential -ScriptBlock {Start-Process notepad runAs} 
}

Run-Elevated