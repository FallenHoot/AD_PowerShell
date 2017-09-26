Import-Module ActiveDirectory
$csvcontent = Import-CSV -Path "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\import_create_ad_users_2a.csv"
$csvcontent | Out-GridView


#RUN AS ADMIN!
Start-Transcript -Path "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\import_create_ad_users_2a.log"
Import-Module ActiveDirectory
$csvcontent = Import-CSV -Path "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\import_create_ad_users_2a.csv"
$csvcontent | ForEach-Object {
$sam = $_.GivenName.substring(0,1)+$_.Lastname
$setpass = ConvertTo-SecureString -AsPlainText $_.Password -force
 Try
 {
 New-ADUser $samAccountName `
 -Path "CN=_s,DC=mmc,DC=local" `
 -GivenName $_.GivenName `
 -Surname $_.LastName `
 -UserPrincipalName ($samAccountName + "@mmc.local")`
 -DisplayName ($_.GivenName + " " + $_.LastName) `
 -Description $_.Description `
 -Enabled $TRUE `
 -Company "mmc LLP." `
 -State $_.Country `
 -AccountPassword $setpass `
 -ChangePasswordAtLogon $False `
 -AccountPassword $setpass 

  $newdn = (Get-ADUser $samAccountName).DistinguishedName
            Rename-ADObject -Identity $newdn -NewName ($_.GivenName + " " + $_.LastName)
 }
  Catch
{
 Write-Host "[ERROR]`t Oops, something went wrong: $($_.Exception.Message)`r`n"
}
}
Stop-Transcript