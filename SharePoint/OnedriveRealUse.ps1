Install-Module -Name Microsoft.Online.SharePoint.PowerShell

$AdminSiteURL="https://ris2048-my.sharepoint.com/"

Connect-SPOService -Url $AdminSiteURL

$Result=@()
$oneDriveSites = Get-SPOSite -IncludePersonalSite $true -Limit All -Filter "Url -like '-my.sharepoint.com/personal/'"
$oneDriveSites | ForEach-Object {
$site = $_
$Result += New-Object PSObject -property @{ 
Nombre_de_usuario = $site.Owner
Espacio_en_MB = $site.StorageUsageCurrent
Cuota_de_Almacenaje_enGB = $site.StorageQuota/1024
Advertencia_espacio_enGB =  $site.StorageQuotaWarningLevel/1024
Url_de_OneDrive = $site.URL
}
}
$Result | Select Nombre_de_usuario, Espacio_en_MB, Cuota_de_Almacenaje_enGB, Advertencia_espacio_enGB, Url_de_OneDrive |
Export-CSV "C:\Reportes\Reporte_Espacio_Usado_OneDrive.csv" -NoTypeInformation -Encoding UTF8
