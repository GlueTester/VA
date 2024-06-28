

#Sources https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/    https://stackoverflow.com/questions/28740320/how-do-i-check-if-a-powershell-module-is-installed
if (Get-Module -ListAvailable -Name activedirectory) {
    Import-Module activedirectory
    #$OUSearchScope = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
    #$FullPCName = Get-ADComputer -LDAPFilter "(name=*$EE)" -SearchBase $OUSearchScope | Select-Object -ExpandProperty Name
} 
else{
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $msgBody1 = "Hey! RSAT tools are NOT installed. What are you trying to pull here? I will install it (about 5-10 mins) But do you also want the full RSAT set (about 20min install)? It give you all RSAT tools and functions. "
    $msgTitle1 = "Do you want full set of tools?"
    $msgButton1 = "YesNo"
    $msgImage1 = "Question"
    $Result1 = [System.Windows.MessageBox]::Show($msgBody1,$msgTitle1,$msgButton1,$msgImage1)
    if ( ($result1).value__ -ne 7){ #-ne means not equal 7 is no 6 is yes
        Write-Host "Good choice, installing full RSAT set"
        Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
    }
    else{
        Write-Host "Ok just install the requiered"
        Get-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.* -Online #RSAT: Active Directory Domain Services and Lightweight Directory Services Tools
        Get-WindowsCapability -Name Rsat.CertificateServices.Tools* -Online #RSAT: Active Directory Certificate Services Tools 
        Get-WindowsCapability -Name Rsat.RemoteDesktop.Services.Tools* -Online #RSAT: Remote Desktop Services Tools   
        Get-WindowsCapability -Name Rsat.GroupPolicy.Management.Tools* -Online #RSAT: Group Policy Management Tools 
    }
    Write-Host "Oops, I killed your boot sector! Na, RSAT tools are installed now. Updating your help. Judging from our interaction so far, your gonna need it."
        Update-Help
    Write-Host "Done"
}
