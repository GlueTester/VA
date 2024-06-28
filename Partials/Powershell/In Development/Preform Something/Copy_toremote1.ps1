$Session = New-PSSession -ComputerName "lex-lt104742"
Copy-Item "\\v09.med.va.gov\lex\Service\IMS\Software\Med Display 4.0.0.11" -Destination "C:\Temp\" -ToSession $Session -Recurse

<#
foreach ($computer in Get-Contest X:\mysupercomputernamelist.txt){
    $destination = "\\$computer\c$"
    copy-item -Path <SOURCEFOLDER> -Destination $destination
    }

#>