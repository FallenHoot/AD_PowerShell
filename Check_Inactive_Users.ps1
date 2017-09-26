## Search Users that have been inactive for 180 days.
Search-ADAccount -AccountInactive -TimeSpan 180 | Select-Object Name, LastLogonDate, DistinguishedName, SamAccountName | Export-Csv C:\Temp\NoExpiration2016.csv

## Delete Users from the above script
Import-CSV C:\Temp\NoExpiration2016.csv | ForEach-Object {Remove-ADUser -Identity $SamAccountName -Confirm:$False}