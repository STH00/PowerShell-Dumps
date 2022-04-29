$PatternSID = 'S-1-5-21-\d+-\d+\-\d+\-\d+$'
$Profiles = Get-ChildItem Registry::HKEY_USERS | Where-Object {$_.PSChildName -match $PatternSID}

New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS

#Clear Portals
Foreach ($p in $Profiles) {
    
    $a,$b = $p.ToString().split('\')

    $path = "HKU:\" + $b + "\SOFTWARE\Palo Alto Networks\GlobalProtect\Settings\portal1.company.com"
    New-Item –Path $path –Value "" -Force
    
    $path = "HKU:\" + $b + "\SOFTWARE\Palo Alto Networks\GlobalProtect\Settings\portal2.company.com"
    New-Item –Path $path –Value "" -Force

}

#Set New Portal
Set-ItemProperty -Path "HKLM:\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup" -Name "Portal" -Value "newportal.company.com"

Remove-PSDrive -Name HKU