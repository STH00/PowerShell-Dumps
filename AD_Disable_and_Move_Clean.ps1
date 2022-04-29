$Users = Get-Content "C:\Path\disable.csv"
$OU = "OU=Disabled,OU=Users,DC=Domain2,DC=Domain,DC=com"
$Server = "ad.server.com"


ForEach($User in $Users){ 
    $UserDN = (Get-ADUser -LDAPFilter "(mail=$User)" -Properties *).DistinguishedName
    Move-ADObject -Identity $UserDN -TargetPath $OU -Server $Server -PassThru | Disable-ADAccount
    Write-Host "Disabled $UserDN"
} 