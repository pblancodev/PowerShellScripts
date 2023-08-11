$Domain = 'agros.pt'
$User = 'Manuel Ferreira'
Get-ADUser $User | select Name, UserPrincipalName

Get-ADUser $User | Set-ADUser -UserPrincipalName "$user@$domain"
Get-ADUser $User | select Name, UserPrincipalName