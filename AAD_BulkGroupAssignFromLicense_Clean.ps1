#Get License Sku for the tenant
Get-MsolAccountSku

#license to be removed
$skuId = "test:STANDARDWOFFPACK_IW_FACULTY"

#add here the group with license assignment to be processed
$GroupName = "Microsoft 365 A1"

#Get the group Object ID
$groupId = (Get-MsolGroup -SearchString $LicensedGroup).ObjectId


Get-MsolUser -All | Where-Object {($_.licenses).AccountSkuId -match $skuId} | 
                Foreach {
                        $user = $_;
                        $operationResult = "";

                        Add-AzureADGroupMember -ObjectId $groupId -RefObjectId $user.ObjectId
                        Write-Host "Added to group"

                        New-Object Object | 
                        Add-Member -NotePropertyName UserId -NotePropertyValue $user.ObjectId -PassThru |
                        Add-Member -NotePropertyName OperationResult -NotePropertyValue $operationResult -PassThru 

                } | Format-Table