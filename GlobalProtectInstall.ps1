$LogPath = [regex]::escape("C:\temp\")
$LogFile = "GlobalProtectLog.txt"
$CurrentPath = (Get-Item .).FullName
$RegistryPath = "HKLM:\SOFTWARE\Palo Alto Networks\GlobalProtect\PanSetup"
$PANGP = Get-NetAdapter -InterfaceDescription "PANGP*"
$Exec = "C:\Program Files\Palo Alto Networks\GlobalProtect"

function LogError ($CatchError)
{
    if (!(Test-Path $LogPath))
    {
        
        New-Item -Path "C:\" -Name "temp" -ItemType "directory"
    }
    if (!(Test-Path $LogPath$LogFile))
    {
        New-Item -Path $LogPath$LogFile -ItemType "file"
    }

    $CatchError | Out-File $LogPath$LogFile -Append
}

if ($PANGP.Status -eq "Up")
{
    Disable-NetAdapter -Name $PANGP.Name -Confirm:$False
    Start-Sleep -Seconds 15
}

try
{
    if ($valueExists = (Get-Item $RegistryPath -EA Ignore).Property -contains "Portal")
    {
        try
        {
            Set-ItemProperty -Path $RegistryPath -Name "Portal" -Value "vpn.reynolds.edu"
        }
        catch
        {
            LogError($_)
        }
        
    }
    else {
        try
        {
            New-Item -Path $RegistryPath -Force -ErrorAction Stop
            New-ItemProperty -Path $RegistryPath -Name "Portal" -Value "vpn.reynolds.edu" -ErrorAction Stop
        }
        catch
        {
            LogError($_)
        }
    }
    
    try
    {
        Start-Process $CurrentPath"\GlobalProtect64.msi" -wait -ArgumentList "/q"
    }
    catch
    {
        LogError($_)
    }

    try
    {
        $Running = Get-Process prog -ErrorAction SilentlyContinue
        $Start = {([wmiclass]"win32_process").Create($Exec)} 
        if ($Running -eq $null){& $Start}
    }
    catch
    {
        LogError($_)
    }
}

catch
{
    LogError($_)

    if ($PANGP.Status -eq "Disabled")
    {
        Enable-NetAdapter -Name $PANGP.Name -Confirm:$False
    }

}