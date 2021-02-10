$Index = $null
$query = "select * from Win32_NetworkAdapterConfiguration Where IPEnabled = 'True'"
Get-WmiObject -Query $query | ForEach-Object {
    $Index = $_.Index
	if ($Index.Length -ne 4) {
		do {
			$Index = "0$Index"
		} while ($Index.Length -lt 4)
	}
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\$Index" -Name "EnablePME" -Value "1" -Type "String" -Force
}
