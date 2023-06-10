#Paso 1
Install-Module AzureAD

#Paso 2
Import-Module AzureAD

#Paso 3
Connect-AzureAD

#Paso 5 Ruta del archivo CSV
$csvPath = "C:\archivo.csv"

#Paso 6 Leer los correos desde el archivo CSV
$correos = Import-Csv -Path $csvPath | Select-Object -ExpandProperty Correo

#Paso 7 Recorrer cada correo y aplicar los cambios
foreach ($correo in $correos) {
    
    $usuario = Get-AzureADUser -UPNOrObjectId $correo  -CompanyName "UnicomCorp" -Country "Venezuela" -Country "Finanzas "
}
