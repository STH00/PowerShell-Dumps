$registryPath = "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate"
$Name = "AcceptTrustedPublisherCerts"
$value = "1"

New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
Import-Certificate -CertStoreLocation Cert:\LocalMachine\TrustedPublisher -FilePath SCUP.cer
Import-Certificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath SCUP.cer