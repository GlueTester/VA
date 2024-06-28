#To move correctly we will need to known the following and have it passed to the function 
#   system_type ("Workstations" "Laptops")
#   location ("Lexington" "Berea"  "Hazard" "Morehead" "Somerset" "Vet Center")
#   chars  ("LT" "MA" "SP" "SD")

ONLY FLAW IS WS does not exist in worksations they drop in win 10


function MoveToCorrectOU{
    param($system_type, $location, $chars, $unmoved_PC) #passes the inputs to functions

    $base_lex_ou = "OU=Lexington (LEX),OU=VISN09,DC=v09,DC=med,DC=va,DC=gov"
    $base_lex_type_ou = "OU=Windows 10,OU=$system_type,$base_lex_ou"
    $base_lex_type_cboc_ou = "OU=CBOC,$base_lex_type_ou"


    try { 
        #determine if system is specialty i.e. CBOC,KIOSK,etc 
        if ($location -eq "Lexington"){$target_path = "OU=$chars,$base_lex_type_ou"} #Lexington means it in NOT a CBOC
        else {$target_path = "OU=$location,$base_lex_type_cboc_ou"}
        }    
    catch {
        Write-Host "An error occurred:"
        Write-Host $_
    }

    Write-Host "target_path= $target_path"
    #Write-Host "Move-ADObject"$unmoved_PC" -TargetPath $target_path"
    Get-ADComputer “$unmoved_PC” |Move-ADObject -TargetPath $target_path -Verbose
    
}
#For Testing I have it prompt me and check the output
$system_type= Read-Host -Prompt "Enter system type"
$location= Read-Host -Prompt "Enter system location"
$chars= Read-Host -Prompt "Enter system chars"
$unmoved_PC= Read-Host -Prompt "Enter unmoved_PC"
MoveToCorrectOU $system_type $location $chars $unmoved_PC


                                            