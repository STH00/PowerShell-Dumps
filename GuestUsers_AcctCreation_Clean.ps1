$AcctNumber = 00
$Password = 'VerySecurePlainTextPassword'
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

$Path = 'OU=Site1,OU=Guests,DC=dc2,DC=dc1,DC=com'
$Server = 'dc2.dc1.com'

while($AcctNumber -lt 50){

    $AcctNumber = (1 + $AcctNumber).ToString('00')
    $Name = 'Guests'+$AcctNumber
    New-ADUser -Name $Name -CannotChangePassword $true -ChangePasswordAtLogon $false -AccountPassword $SecurePassword -Enabled $true -OtherAttributes @{'givenName'='Guest';'displayName'='Guest';'userPrincipalName'=$Name+'@dc2.dc1.com'} -Path $Path -Server $Server
}

