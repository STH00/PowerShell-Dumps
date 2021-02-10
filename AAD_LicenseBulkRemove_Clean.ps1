# Uncomment on first run
#Import-Module MSOnline
#$UserCredential = Get-Credential
#Connect-MsolService -Credential $UserCredential

#Get License Sku for the tenant
Get-MsolAccountSku

#license to be removed
$skuId = "test:FLOW_FREE"

#add here the group with license assignment to be processed
$LicensedGroup = "Microsoft 365 A1"

#Get the group Object ID
$groupId = (Get-MsolGroup -SearchString $LicensedGroup).ObjectId

$license = GetUserLicense $user $skuId


#Returns the license object corresponding to the skuId. Returns NULL if not found
function GetUserLicense
{
    Param([Microsoft.Online.Administration.User]$user, [string]$skuId, [Guid]$groupId)
    #we look for the specific license SKU in all licenses assigned to the user
    foreach($license in $user.Licenses)
    {
        if ($license.AccountSkuId -ieq $skuId)
        {
            return $license
        }
    }
    return $null
}
#You can then process all members in the group if the result of staging is OK
Get-MsolGroupMember -All -GroupObjectId $groupId | 
    #get full info about each user in the group
    Get-MsolUser -ObjectId {$_.ObjectId} | 
    Foreach { 
        $user = $_;
        $operationResult = "";
        #check if Direct license exists on the user
        if (UserHasLicenseAssignedDirectly $user $skuId)
        {
                #remove the direct license from user
                Set-MsolUserLicense -ObjectId $user.ObjectId -RemoveLicenses $skuId
                $operationResult = "Removed direct license from user."   

        
        }
        else
        {
            $operationResult = "User has no direct license to remove. Skipping."
        }
        #format output
        New-Object Object | 
                    Add-Member -NotePropertyName UserId -NotePropertyValue $user.ObjectId -PassThru |
                    Add-Member -NotePropertyName OperationResult -NotePropertyValue $operationResult -PassThru 
    } | Format-Table