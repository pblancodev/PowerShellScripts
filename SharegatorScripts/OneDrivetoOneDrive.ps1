Import-Module Sharegate
$csvFile = "C:\CSV\CopyContent.csv"
$table = Import-Csv $csvFile -Delimiter ","

$srcUsername = "sourceusername"
$srcPassword = ConvertTo-SecureString 'sourcepassword' -AsPlainText -Force

$dstUsername = "destinationusername"
$dstPassword = ConvertTo-SecureString 'destinationpassword' -AsPlainText -Force

Set-Variable srcSite, dstSite, srcList, dstList
foreach ($row in $table) {
    Clear-Variable srcSite
    Clear-Variable dstSite
    Clear-Variable srcList
    Clear-Variable dstList
    $srcSite = Connect-Site -Url $row.SourceSite -Username $srcUsername -Password $srcPassword
    $dstSite = Connect-Site -Url $row.DestinationSite -Username $dstUsername -Password $dstPassword
    $srcList = Get-List -Site $srcSite -Name "Documents"
    $dstList = Get-List -Site $dstSite -Name "Documents"
    Copy-Content -SourceList $srcList -DestinationList $dstList
    Remove-SiteCollectionAdministrator -Site $srcSite
    Remove-SiteCollectionAdministrator -Site $dstSite
}