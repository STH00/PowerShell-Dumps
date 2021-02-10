#Enter how many days ago the accounts have been created
$PreviouDays=30
#Export file location
$FilePath="C:\users\test\Desktop\AD_Report.csv"


$DateCutOff=(Get-Date).AddDays(-$PreviouDays)
Get-ADUser -Filter * -Properties displayName, Name, whenCreated | Where {$_.whenCreated -gt $DateCutOff} | Select-Object displayName, Name, whenCreated | Export-CSV -Path $FilePath -NoTypeInformation
