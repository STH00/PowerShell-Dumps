#AD Server
$Server = 'dc1.dc2.com'

#Account Prefixes
$Site1AcctPath = 'OU=GuestSite1,OU=GuestUsers,DC=dc1,DC=dc2,DC=com'
$Site2AcctPath = 'OU=GuestSite2,OU=GuestUsers,DC=dc1,DC=dc2,DC=com'
$Site3AcctPath =  'OU=GuestSite3,OU=GuestUsers,DC=dc1,DC=dc2,DC=com'

#File Paths
$Site1FilePath = '\\Path1\Site1guestAccts_'+(Get-Date -Format MM-dd-yyyy)+'.csv'
$Site2FilePath = '\\Path1\Site2guestAccts_'+(Get-Date -Format MM-dd-yyyy)+'.csv'
$Site3FilePath = '\\Path1\Site3guestAccts_'+(Get-Date -Format MM-dd-yyyy)+'.csv'
$Folder = '\\Path1\'
$Archive = '\\Path1\Archive'

#Password Prefixes
$PassPrefixes = 'Computer','Monitor','Chair','Desk','Keyboard','Mouse','Door','Window','Book','Cupcake'

#Return format
$ReturnInfo = '' | Select-Object -Property AccountName, Password, GuestName, Workstation, Date, Time, EmployeeName




function ResetPassword{
    param (
        [Parameter(Mandatory = $True, Position = 0)]
        [string]$ADpath,
        [Parameter(Mandatory = $True, Position = 1)]
        [string]$FilePath
    )
    $Users = Get-ADUser -Filter * -Properties Name -searchBase $ADpath -Server $Server | Select -expand Name
    

    foreach($u in $Users) {
        $RandomPassNum = Get-Random -Minimum 10000 -Maximum 99999
        $PasswordPrefix = $PassPrefixes | Get-Random
        $Password = $PasswordPrefix+$RandomPassNum

        Write-Host 'User: '$u
        Write-Host 'Password: '$Password

        Set-ADAccountPassword -Identity $u -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -Server $Server
        Set-ADUser -Identity $u -CannotChangePassword $True -PasswordNeverExpires $True -Server $Server
        
        $ReturnInfo.AccountName = $u
        $ReturnInfo.Password = $Password
    
        if(Test-Path $FilePath)
            {
                $ReturnInfo | Select-Object * | Export-Csv -Path $FilePath -NoTypeInformation -Append
            }else{
                $ReturnInfo | Select-Object * | Export-Csv -Path $FilePath -NoTypeInformation           
            }
    }
}


Get-ChildItem -Path $Folder -Recurse -File | Move-Item -Destination $Archive -Force

ResetPassword $Site1AcctPath $Site1FilePath
ResetPassword $Site2AcctPath $Site2FilePath
ResetPassword $Site3AcctPath $Site3FilePath