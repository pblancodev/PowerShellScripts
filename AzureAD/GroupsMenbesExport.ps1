Connect-AzureAD

$OutputAddress='C:\ListMenber.csv'

Get-AzureADGroupMember -ObjectId 6e8f8e08-182c-423a-83cc-51d376641e3d |select-object DisplayName,UserPrincipalName | Export-CSV $OutputAddress  -NoTypeInformation
