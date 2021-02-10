$ErrorActionPreference = "SilentlyContinue"
$SecondsToWait = 1200
$strQuery = "Select InstanceID from Win32_PowerPlan where IsActive = 'true'"
$PowerPlanInstanceID = (Get-WmiObject -Query $strQuery -Namespace root\cimv2\power).InstanceID.ToString()
$RegEx = [RegEx]"{(.*?)}$"
$GUID = $RegEx.Match($PowerPlanInstanceID).Groups[1].Value
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0\DefaultPowerSchemeValues\$GUID"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0\DefaultPowerSchemeValues\$GUID" -Name "AcSettingIndex" -Value "$SecondsToWait" -Type "DWORD" -Force