#list all that match a name
Get-WmiObject -Class Win32_Product | Where-Object Name -Match TOSHIBA | Format-Table

#List everything
Get-WmiObject -Class Win32_Product | Format-Table

#List All by name
Get-WmiObject -Class Win32_Product | Select Name| Format-Table



function Uninstall-Program($Package) {

    $Command = foreach ($i in (0..($Package.Meta.Attributes.Keys.Count - 1))) {
        if ($Package.Meta.Attributes.Keys[$i] -eq 'UninstallString') {
            $Package.Meta.Attributes.Values[$i]
        }  
    }

    Invoke-Expression $Command
}

$Package = Get-Package "*PaperStream*"
Uninstall-Program $Package