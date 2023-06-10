#Paso 1
Install-Module AzureAD

#Paso 2
Import-Module AzureAD

#Paso 3
Connect-AzureAD

#Paso 4
Update-AzADUser -UPNOrObjectId  pedro.blanco@prueba.local -City "Valencia"  -JobTitle "Ingeniero" -Department "Informàtica" -OfficeLocation "Av Bolivar 234"