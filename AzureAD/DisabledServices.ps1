
### paso 1
Connect-MsolService

##  paso 2 Ver el detalle de las sku

Get-MsolAccountSku | Select AccountSkuId | Sort AccountSkuId


## paso 3 ver los servicios del sku

(Get-MsolAccountSku | where {$_.AccountSkuId -eq "reseller-account:O365_BUSINESS_PREMIUM"}).ServiceStatus


## Paso 4 Definir el servicio a desabilitar en una variable 


$LO=New-MsolLicenseOptions -AccountSkuId "reseller-account:O365_BUSINESS_PREMIUM" -DisabledPlans  "EXCHANGE_S_STANDARD"


## Paso 5 Cargar la lista de Cuentas a Deshabilitar

$correos = Import-Csv -Path C:\Users\pedro.blanco\o365


foreach ($correos in $correos) {

    Set-MsolUserLicense -UserPrincipalName $correos -LicenseOptions $LO

    
}
