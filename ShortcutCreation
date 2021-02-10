function CreateShortcut
    {
        $Shell = New-Object -ComObject ("WScript.Shell")
        $Favorite = $Shell.CreateShortcut("C:\Users\Public\Desktop\ALLDATA.lnk")
        $Favorite.TargetPath = "http://my.alldata.com/#/ip";
        $Favorite.Save()
    }

if (Test-Path -Path "C:\Users\Public\Desktop\ALLDATA.lnk")
    {
        Write-Host "File exists"
        Remove-Item "C:\Users\Public\Desktop\ALLDATA.lnk" -Force

        CreateShortcut
    }

if (Test-Path -Path "C:\Users\Public\Desktop\ALLDATA.url")
    {
        Write-Host "File exists"
        Remove-Item "C:\Users\Public\Desktop\ALLDATA.url" -Force

        CreateShortcut
    }
