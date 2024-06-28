function Get-LoggedUser
{
    [CmdletBinding()]
    param
    (
        [string[]]$ComputerName 
    )
    foreach ($comp in $ComputerName)
    {
        if ((Test-NetConnection $comp -WarningAction SilentlyContinue).PingSucceeded -eq $true) 
            {  
                $output = @{'Computer' = $comp }
                $output.UserName = (Get-WmiObject -Class win32_computersystem -ComputerName $comp).UserName
            }
            else
            {
                $output = @{'Computer' = $comp }
                         $output.UserName = "offline"
            }
         [PSCustomObject]$output 
    }
}

$EE = Read-Host "Please enter the EE"
$computers = (Get-ADComputer -Filter "Name -like '*$EE'" -SearchBase 'OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov').Name

Get-LoggedUser $computers |ft -AutoSize