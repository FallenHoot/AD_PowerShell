Search-ADAccount -PasswordNeverExpires | Where-Object {$_.Enabled -eq $True } | 
Select-Object name, LastLogonDate, DistinguishedName | 
Export-Csv C:\Temp\NoExpiration2016.csv