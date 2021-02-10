$computers = Get-Content "D:\AD Bulk Move Script\List.txt"
$path      = "D:\AD Bulk Move Script\List.txt" 
 

$TargetOU   =  "OU=Quarantine,DC=test,DC=test,DC=edu"  
$countPC    = ($computers).count  
$server     = "test.test.edu"
 
ForEach( $computer in $computers){ 
    Get-ADComputer $computer -Server $server | 
    Move-ADObject -TargetPath $TargetOU
}