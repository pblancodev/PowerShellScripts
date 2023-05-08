Connect-AzureAD

$OutputAddress='C:\services.CSV'



Get-AzureADGroup -All:$true |select-object ObjectId,DisplayName | Export-CSV $OutputAddress  -NoTypeInformation

