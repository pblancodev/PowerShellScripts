$Domain = 'agros.pt'
$User = 'Manuel Ferreira'
Get-ADUser $User | select Name, UserPrincipalName

Get-ADUser $User | Set-ADUser -UserPrincipalName "$user@$domain"
Get-ADUser $User | select Name, UserPrincipalName


################# multi user #################################


$Domain = 'prodistica.pt'

$CSVPath ="C:\Users\RIS2048\Documents\userupn\users.csv"

$Users = Import-Csv -Path $CSVPath

foreach ($User in $Users) {
    $Username = $User.Users

    Get-ADUser $Username | Select-Object Name, UserPrincipalName

    Set-ADUser -Identity $Username -UserPrincipalName "$Username@$Domain"

    Get-ADUser $Username | Select-Object Name, UserPrincipalName
}