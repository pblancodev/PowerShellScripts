Connect-AzureAD

$OutputAddress='C:\ListMenber.csv'

Get-AzureADGroupMember -ObjectId 0a26404d-0f9c-4391-b89c-4e445fc0df60 |select-object DisplayName,UserPrincipalName | Export-CSV $OutputAddress  -NoTypeInformation
