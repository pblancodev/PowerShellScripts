
####################  Domain Info  Extract ##########################

$domainInfo = Get-ADDomain -Current LocalComputer
$csvPath = Read-Host "Introduza o caminho do diretório onde os registos serão guardados"
$csvPathTrueurl=$csvPath
$csvPathTrueurl2=$csvPath
$csvPathTrueurl3=$csvPath
$csvPathTrueurl4=$csvPath
$csvPathTrueurl5=$csvPath
$csvPathTrueurl6=$csvPath

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



##################### Account Disabled ####################################

$defaultFileDisabledUsers = "Disabled Users.csv"

$usersTotal = (Get-ADUser -Filter *).Count
$usersDisabled = (Get-ADUser -Filter * | Where-Object {$_.Enabled -eq $false}).Count

$results = [PSCustomObject]@{
    "Total Users" = $usersTotal
    "Disabled Users" = $usersDisabled
}

$csvFilePath = Join-Path -Path $csvPathTrueurl4 -ChildPath $defaultFileDisabledUsers


$results | Export-Csv -Path $csvFilePath -NoTypeInformation

##################### Account Disabled ####################################



####################   Account Locked    ##################################

$csvFileName = "AccountLocked.csv"

$lockedUsers = (Search-ADAccount -LockedOut).Count

if ($lockedUsers -eq $null) {
    $lockedUsers = 0
}

$csvFilePath = Join-Path -Path $csvPathTrueurl5 -ChildPath $csvFileName

[PSCustomObject]@{
    "Locked Users Count" = $lockedUsers
} | Export-Csv -Path $csvFilePath -NoTypeInformation



####################   Account Locked    ##################################


####################    SO list       ##################################

$csvFileNameSoLegacy = "OS List.csv"
$csvFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $csvFileNameSoLegacy

$allSO = Get-ADComputer -Filter * -Property OperatingSystem |
    Select-Object -ExpandProperty OperatingSystem

$allSOTypesCount = $allSO | Group-Object | Select-Object @{Name="Operating System"; Expression={$_.Name}}, @{Name="Number"; Expression={$_.Count}}

$allSOTypesCount | Export-Csv -Path $csvFilePath -NoTypeInformation



###########################    SO list      ########################################



##########################   utilizador sem password  ###########################


$csvFileName = "User Sem Password.csv"

$csvFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $csvFileName

$disabledUsers = Get-ADObject -LDAPFilter "(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=32))" -Properties useraccountcontrol |
    Select-Object -Property Name, DistinguishedName



$disabledUsers | Export-Csv -Path $csvFilePath -NoTypeInformation


###########################      utilizador sem password         ########################################



###########################      SMB1V ativo   heck W2K12/16 Servers     ########################################

$csvFileName = "SMB1V ativo W2K12 16 Servers.csv"

$csvFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $csvFileName

$Computersmb1v2016 = Get-ADComputer -Filter {OperatingSystem -Like "Windows *Server*2012*" -or OperatingSystem -Like "Windows *Server*2016*" -and Enabled -eq $true} | % {icm -cn  $_.Name -EA 0 {get-smbserverconfiguration| select PSComputerName,enableSMB1Protocol}}

$Computersmb1v2016 | Export-Csv -Path $csvFilePath -NoTypeInformation 


###########################      SMB1V ativo   heck W2K12/16 Servers     ########################################


###########################    SMB1V ativo   Check W2K8 Servers  Servers   ########################################

$csvFileName = "SMB1V ativo W2K8 legacy Servers.csv"

$csvFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $csvFileName


$computersmb1v2008 = Get-ADComputer -Fil {OperatingSystem -Like "Windows *Server*2008*" -and Enabled -eq $true} | % {icm -cn  $_.Name -EA 0 {gp "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" |?{$_.SMB1 -eq "0"}|select PSComputerName, SMB1}} 

$Computersmb1v2008 | Export-Csv -Path $csvFilePath -NoTypeInformation 


###########################    SMB1V ativo   Check W2K8 Servers  Servers   ########################################




###################################    AD Recycle Bin   ############################################################


$csvFileName = "AD Recycle Bin.csv"

$csvFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $csvFileName


$RecyclebinStatus=Get-ADOptionalFeature -Filter 'name -like "Recycle Bin Feature"'


$RecyclebinStatus | Export-Csv -Path $csvFilePath -NoTypeInformation 


###################################    AD Recycle Bin   ############################################################


###################################    Migration State   ############################################################

$txtFileName = "DfsrMig Result.txt"

$txtFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $txtFileName

$dsfm = DfsrMig /GetMigrationState


$dsfm| Out-File -FilePath $txtFilePath

###################################    Migration State   ############################################################

###################################    Migration State Global   ############################################################


$txtFileName = "DfsrMig GetGlobalState Result.txt"

$txtFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $txtFileName

$dfsrmig = DfsrMig /GetGlobalState



$dfsrmig | Out-File -FilePath $txtFilePath

###################################    Migration State Global   ############################################################

###################################    politica de password do dominio  ############################################################


$domain = Get-ADDomain

$domainname = $domain.Name


$csvFileName = "DomainNamePolicy.csv"

$csvFilePath = Join-Path -Path $csvPathTrueurl6 -ChildPath $csvFileName


$domainpasswordpolicy = Get-ADDefaultDomainPasswordPolicy -Identity $domainname

$domainpasswordpolicy| Export-Csv -Path $csvFilePath -NoTypeInformation 


###################################    politica de password do dominio  ############################################################


