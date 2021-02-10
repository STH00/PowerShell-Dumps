$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation"

New-ItemProperty -Path $registryPath -Name "Logo" -Value "C:\Windows\\OEM\OEM.bmp" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "Manufacturer" -Value "My Community College" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "SupportHours" -Value "8:15 a.m. to 5:00 p.m. / Mon-Fri" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "SupportPhone" -Value "(555) 555-5555" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "SupportURL" -Value "https://college.edu/support/helpdesk/" -PropertyType String -Force | Out-Null
