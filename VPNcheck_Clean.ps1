$LogPath = [regex]::escape("C:\temp\")
$LogFile = "GlobalProtectLog.txt"
$CurrentPath = (Get-Item .).FullName
$RegistryPath = "HKLM:\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup"
$PANGP = Get-NetAdapter -InterfaceDescription "PANGP*"

if ($PANGP.Status -eq "Up")
{
    Disable-NetAdapter -Name $PANGP.Name -Confirm:$False
    Start-Sleep -Seconds 15
}

try
{
    #Update portal if exists
	if ($valueExists = (Get-Item $RegistryPath -EA Ignore).Property -contains "Portal")
    {
        Set-ItemProperty -Path $RegistryPath -Name "Portal" -Value "vpn.company.com"
    }
    #Create new registry key for portal
	else {
        New-Item -Path $RegistryPath -Force
        New-ItemProperty -Path $RegistryPath -Name "Portal" -Value "vpn.company.com"
    }
    #Start MSI
	Start-Process $CurrentPath"\GlobalProtect64.msi" -wait -ArgumentList "/q"
}

catch
{
    #Create log directory
	if (!(Test-Path $LogPath))
    {
        New-Item -Path "C:\" -Name "temp" -ItemType "directory"
    }
    if (!(Test-Path $LogPath$LogFile))
    {
        New-Item -Path $LogPath$LogFile -ItemType "file"
    }

    Write-Host "Aborted " $LogFile " Returned:" $_ | Out-File $LogPath$LogFile

	#Disable misconfigured VPN
    if ($PANGP.Status -eq "Disabled")
    {
        Enable-NetAdapter -Name $PANGP.Name -Confirm:$False
    }

}