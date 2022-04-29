$source = 'C:\Windows\Collective\Profile\*'
$dest = 'C:\Users'

Copy-Item $source -Destination $dest -Recurse


$dest = 'C:\Users\Mandatory.v6'
$acl = Get-ACL $dest
$accessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$acl.AddAccessRule($accessRule)
Set-Acl $dest $acl

Get-ChildItem $dest -Recurse -Force | Set-Acl -AclObject $acl

$dest = 'C:\Users\Mandatory.v6\NTUSER.MAN'
$acl = Get-ACL $dest
$accessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","FullControl","Allow")
$acl.AddAccessRule($accessRule)
Set-Acl $dest $acl