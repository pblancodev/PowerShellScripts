

####################  Domain Info  Extract ##########################

$domainInfo = Get-ADDomain -Current LocalComputer
$csvPath = Read-Host "Ingrese la ruta donde se guardará el archivo"
$csvPathTrueurl=$csvPath
$csvPathTrueurl2=$csvPath
$csvPathTrueurl3=$csvPath
$csvPathTrueurl4=$csvPath

$defaultFileName = "domaininfo.csv"

if ($csvPath -eq "") {
    $csvPath = $defaultFileName
}
else {
    $csvPath = Join-Path -Path $csvPath -ChildPath $defaultFileName
}

$domainInfo | Export-Csv -Path $csvPath -NoTypeInformation


####################  Domain Info  Extract ##########################



######################   Extract GPO List Status  ##############################



$GPOInfo =  get-GPO -all | select DisplayName, CreationTime, ModificationTime, gpostatus

$defaultFileNameGPO="GPOLIstState.csv"


if ($csvPathTrueurl -eq "") {
    $csvPathTrueurl = $defaultFileNameGPO
}
else {
    $csvPathTrueurl = Join-Path -Path $csvPathTrueurl -ChildPath $defaultFileNameGPO
}

$GPOInfo | Export-Csv -Path $csvPathTrueurl -NoTypeInformation



######################   Extract GPO List Status  ##############################


######################       Empity Group        ###############################

$GetEmpityGrooup= get-adgroup -filter * | where {-Not ($_ | get-adgroupmember)} | Select Name

$defaultFileEmpityGroups="EmpityGroupsAd.csv"

if ($csvPathTrueurl2 -eq "") {
    $csvPathTrueurl2 = $defaultFileEmpityGroup
}
else {
    $csvPathTrueurl2 = Join-Path -Path $csvPathTrueurl2 -ChildPath $defaultFileEmpityGroups
}

$GetEmpityGrooup | Export-Csv -Path $csvPathTrueurl2 -NoTypeInformation



#####################        Empity Group        ###############################



#################### HomeDrive e HomeDirectory  ######################################


$defaultFileHomeDriveeDirectorys="HomeDriveeHomeDirectorys.csv"

if ($csvPathTrueurl3 -eq "") {
    $csvPathTrueurl3 = $defaultFileHomeDriveeDirectorys
}
else {
    $csvPathTrueurl3 = Join-Path -Path $csvPathTrueurl3 -ChildPath $defaultFileHomeDriveeDirectorys
}


$HomeDriveDirectory = Get-ADUser -Filter * -Properties scriptpath, homedrive, homedirectory |
    Select-Object Name, scriptpath, homedrive, homedirectory |
    Export-Csv -Path $csvPathTrueurl3 -NoTypeInformation



#################### HomeDrive e HomeDirectory  ######################################



#######################    Account Disabled      ####################################

$defaultFileDisabledUsers = "Disabled Users.csv"

$usersTotal = (Get-ADUser -Filter *).Count
$usersDisabled = (Get-ADUser -Filter * | Where-Object {$_.Enabled -eq $false}).Count

$results = [PSCustomObject]@{
    "Total Users" = $usersTotal
    "Disabled Users" = $usersDisabled
}

$csvFilePath = Join-Path -Path $csvPathTrueurl4 -ChildPath $defaultFileDisabledUsers


$results | Export-Csv -Path $csvFilePath -NoTypeInformation

######################### Account Disabled   ####################################