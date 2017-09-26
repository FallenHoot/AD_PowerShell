Import-Module ActiveDirectory
$date = get-date -UFormat "%Y%m%d"
##Example ="OU=Company,DC=Cisco,DC=local"
$Groupaccountpath = "OU=Company,DC=Cisco,DC=local"
$Groups = (Get-AdGroup -filter * -SearchBase $Groupaccountpath | Where {$_.name -like "**"} | select name -ExpandProperty name)
$Table = @()
$Record = @{
  "Group Name" = ""
  "Name" = ""
  "Username" = ""
}
 
Foreach ($Group in $Groups) {
  $Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | get-aduser | Where {$_.Enabled -eq $true}  | select name,samaccountname
  foreach ($Member in $Arrayofmembers) {
    $Record."Group Name" = $Group
    $Record."Name" = $Member.name
    $Record."UserName" = $Member.samaccountname
    $objRecord = New-Object PSObject -property $Record
    $Table += $objrecord
  }
}
$Table | export-csv "C:\temp\SecurityGroups_$date.csv" -NoTypeInformation