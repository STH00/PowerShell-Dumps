$configDirectory = 'C:\Users\Mandatory.v6\AppData\Roaming\Sage\Estimating 18.12\'
$configFile = 'C:\Users\Mandatory.v6\AppData\Roaming\Sage\Estimating 18.12\ActiveSystemInfo.xml'

$configToFile = @"
<?xml version="1.0" encoding="utf-8"?>
<EstimatingSystemInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <ServerInstance>localhost\SAGE_ESTIMATING</ServerInstance>
  <EstimatesDatabase>SageDB</EstimatesDatabase>
  <LicensingMode>0</LicensingMode>
  <LicenseServer>test</LicenseServer>
  <LicenseServerPort>48650</LicenseServerPort>
</EstimatingSystemInfo>
"@

if (! (Test-Path $configDirectory ) )
    {
#        Write-Host '###Sage config folder doesn''t exist###';

        New-Item -ItemType directory -Path $configDirectory;

    }
if (Test-Path $configFile )
    {
#        Write-Host '###Deleting config file###';        
        Remove-Item $configFile
    }

#Write-Host '###Creating Sage config file###';
Set-Content -Path $configFile -Value $configToFile
