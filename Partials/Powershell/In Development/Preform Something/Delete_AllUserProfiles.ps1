$PC = Read-Host "What is the Computer Name"
$AccountsToKeep = @('administrator','Public','default','DOMAIN\administrator')
Get-CimInstance -ComputerName $PC -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -notin $AccountsToKeep } | Remove-CimInstance

<#
$today = Get-Date
$deaddate = Get-Date "09-11-2023 00:00:00"
 If($today -gt $deaddate)
 { 
 Write-Host "Version is outdated, please find more current"
 }
 else
 {
    $PC = Read-Host "What is the Computer Name"
    $Adaccount = Read-Host "Enter AD Account Name example:'VHALEXKINGR1' of the profile to delete"
    Get-CimInstance -ComputerName $PC -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq $Adaccount } | Remove-CimInstance
    #LEX-MA95608
 }

 $profilescan = Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] } | Remove-CimInstance
 foreach( $profile in $profilescan) {
   Get-CimInstance -ComputerName $PC Get-CimInstance -Class Win32_UserProfile | Where-Object -eq $profile | Remove-CimInstance
 }

#>

# SIG # Begin signature block
# MIIFlAYJKoZIhvcNAQcCoIIFhTCCBYECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUVt9wdoO7zt1GSrXW4M2Z3Yk1
# J4mgggMiMIIDHjCCAgagAwIBAgIQYY58RGET4bxM3CLJi1801jANBgkqhkiG9w0B
# AQsFADAnMSUwIwYDVQQDDBxQb3dlclNoZWxsIENvZGUgU2lnbmluZyBDZXJ0MB4X
# DTIyMDQyODE1MTA1NVoXDTIzMDQyODE1MzA1NVowJzElMCMGA1UEAwwcUG93ZXJT
# aGVsbCBDb2RlIFNpZ25pbmcgQ2VydDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBALH2NRU73dbsZiRnJWnzJ7/GyxEUKdDqLfljiUk3wNAnwVUnairZT86T
# id+tz+0ZtLrbUYivhXHQ39lJWw2NLeLaz/X7pp8ROZd4GUCs9KUSC4yLry0ujreB
# tKU7Ty/GDV01yYMNGaTI5rY6MSfdg+gAfI2LRBPfyasLxWaiIOVyH+IcSI3jG0zt
# cYYqh7dxbdz4m3fNKHIwHs6/c+RIyurCJNfhYqR9fYizv9Yo0YYpyrB2VO+Zeu36
# b5ZjSjABwMEHw+40f4TKSUKvbAppn2WvjjsI4XJPFmwqktIETuY8W/bujR1dx5tv
# Vw98mpzho+iKcyIQ0LqWXCJG0CF1dyUCAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeA
# MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBT2zykFfl5oVvhSPp7MLEdC
# EPi0+jANBgkqhkiG9w0BAQsFAAOCAQEAZoNL/0YibfsPWWrkgIy+0mPmRac61h1o
# DScQ4VhpjL1mnjiukkeMXgLIksTy1UwUO+DT6cYLeb8RFRKlc55Yfmk/dVsdArwZ
# cF8QlvH7vlai/eOsXLaTJVvabzXspfY9JUig64TAM4783vEq/bSurYivNd1QsTdO
# EPWgsAAUs2GtjCqJJ80Mv6l75nMh6NBNT8S45kr7scvCdp0McT890I5XlV2biSz0
# ytbK4WHlMWG8jBbELcEK1qdjDixNgljJB8sPmBha6M4hAcILaRdJu6UU5LeBlL2z
# ucdktPFdfqYzE4CAj4S7AB52iLsLzPOzr43e5ba1XrZ1iFK6pLHWpTGCAdwwggHY
# AgEBMDswJzElMCMGA1UEAwwcUG93ZXJTaGVsbCBDb2RlIFNpZ25pbmcgQ2VydAIQ
# YY58RGET4bxM3CLJi1801jAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAig
# AoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgEL
# MQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUhcE5LtqQa8hL2FpcP7s2
# MpFa+2AwDQYJKoZIhvcNAQEBBQAEggEAZ4pZSfjibSugeRQqkcW3s95xdm6UqCu0
# xfW36Ri7jWSG9UEmFWM/1E5hSY1lVl8QYs2v3vzvLdL5S2jHU5eNgNjd4GJG3wrE
# TEHuM1FSeHC94TP6epLqS54kxTSi9MB34H12Ia6mwhmgq48wSs/mRuNCQ5Lx+6GA
# MOIVjbqL8fOeioqDOtIZr1yXvvrthSLX9JUxXcUrRipUF9zGByHakGKR6YsB73cq
# +1Agyhcrfkrh1/oPUTcbA/6ZVBtvQqOSJwvknaMHG80cg+JXZuKB6tVIoTa8uy8r
# zCJTOqeX7CyPKZqlxyi26OPrR0LrurdJWxJt6cpJwI8eVT5QOGT+xA==
# SIG # End signature block
