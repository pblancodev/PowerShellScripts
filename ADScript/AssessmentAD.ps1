




$root = $root = [Environment]::GetFolderPath("MyDocuments")

$Principalroot = "$root\AssessmentAD"

New-Item -ItemType Directory -Path $Principalroot

New-Item -ItemType Directory -Path "$Principalroot\ADInfo"

$registerroot="$Principalroot\ADInfo"


### AD Domain INFO ######

$DomainInfo= Get-ADForest


$Domain = $DomainInfo.Name

$ADfuntionalLevel = $DomainInfo.ForestMode

$DCNumber = (Get-ADDomainController -Filter "*" | Select-Object Name).Count




$objectVersionschema = Get-ADObject (Get-ADRootDSE).schemaNamingContext -Property objectVersion





$objectVersionschema = $objectVersionschema.objectVersion

switch ($objectVersionschema) {
    13 { $os = "Windows 2000 Server" }
    30 { $os = "Windows Server 2003 RTM, Windows 2003 Service Pack 1, Windows 2003 Service Pack 2" }
    31 { $os = "Windows Server 2003 R2" }
    44 { $os = "Windows Server 2008 RTM" }
    47 { $os = "Windows Server 2008 R2" }
    56 { $os = "Windows Server 2012" }
    69 { $os = "Windows Server 2012 R2" }
    87 { $os = "Windows Server 2016" }
    88 { $os = "Windows Server 2019" }
    default { $os = "Versión desconocida" }
}

$os


$schemaVersion =$os



$objetoTablaDomain = New-Object -TypeName PSObject -Property @{
    "Domain" = $Domain
    "Functional Level" = $ADfuntionalLevel
    "DC Number" = $DCNumber
    "Domain Schema" = $os
}

$CSVFile = Join-Path -Path $registerroot -ChildPath "ADInfomation.csv"
$objetoTablaDomain| Export-Csv -Path $CSVFile -NoTypeInformation



### AD Domain INFO ######



###### Recycle BIn ######


$RecycleBin = Get-ADOptionalFeature -Filter {Name -eq "Recycle Bin Feature"}

$RecycleBin=$RecycleBin.EnabledScopes 




$objetoTablaRecycle = New-Object -TypeName PSObject -Property @{
    "RecyclebinScope" = $RecycleBin
}


$CSVFile2 = Join-Path -Path $registerroot -ChildPath "ADRecyclebin.csv"



$objetoTablaRecycle| Export-Csv -Path $CSVFile2 -NoTypeInformation



###### Recycle BIn ######


##### Windows Server ###############


$CSVFile3 = Join-Path -Path $registerroot -ChildPath "Windows Servers Details.csv"

$CSVFile3count = Join-Path -Path $registerroot -ChildPath "Windows Servers Count.csv"


Get-ADComputer -Filter 'operatingsystem -like "*Windows server*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion |
    Export-Csv -Path $csvFile3  -NoTypeInformation

##### Windows Server ###############


##### Windows XP ###############


$CSVFile4 = Join-Path -Path $registerroot -ChildPath "WindowsXP.csv"

Get-ADComputer -Filter 'operatingsystem -like "*Windows XP*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion |
    Export-Csv -Path $csvFile4  -NoTypeInformation


##### Windows XP ###############


##### Windows 7 ###############


$CSVFile5 = Join-Path -Path $registerroot -ChildPath "Windows7.csv"

Get-ADComputer -Filter 'operatingsystem -like "*Windows 7*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion |
    Export-Csv -Path $csvFile5  -NoTypeInformation


##### Windows 7 ###############



##### Windows 8 ###############


$CSVFile6 = Join-Path -Path $registerroot -ChildPath "Windows8.csv"

Get-ADComputer -Filter 'operatingsystem -like "*Windows 8*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion |
    Export-Csv -Path $csvFile6  -NoTypeInformation


##### Windows 8 ###############



##### Windows 10 ###############


$CSVFile7 = Join-Path -Path $registerroot -ChildPath "Windows10.csv"

Get-ADComputer -Filter 'operatingsystem -like "*Windows 10*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion |
    Export-Csv -Path $csvFile7  -NoTypeInformation

##### Windows 10 ###############


##### Windows 11 ###############


$CSVFile8 = Join-Path -Path $registerroot -ChildPath "Windows11.csv"

Get-ADComputer -Filter 'operatingsystem -like "*Windows 11*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion |
    Export-Csv -Path $csvFile8  -NoTypeInformation

##### Windows 11 ###############



######## Divice Numbers ########

$windowsServer = Get-ADComputer -Filter 'operatingsystem -like "*Windows server*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion

$windows11 = Get-ADComputer -Filter 'operatingsystem -like "*Windows 11*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion

$windows10 = Get-ADComputer -Filter 'operatingsystem -like "*Windows 10*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion


$windows8 = Get-ADComputer -Filter 'operatingsystem -like "*Windows 8*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion


$windows7 = Get-ADComputer -Filter 'operatingsystem -like "*Windows 7*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion


$windowsxp = Get-ADComputer -Filter 'operatingsystem -like "*Windows xp*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,OperatingSystemServicePack,IPv4Address |
    Sort-Object -Property Operatingsystem |
    Select-Object -Property Name, Operatingsystem, OperatingSystemVersion


$alldivice = Get-ADComputer -Filter *




# Guardar la cantidad de dispositivospor variable

$numberWindowsserver = $windowsServer.Count

$numberWindows11 = $windows11.Count

$numberWindows10 = $windows10.Count

$numberWindows8 = $windows8.Count

$numberWindowsxp = $windowsxp.Count

$numberWindows7 = $windows7.Count


$numberalldivice = $alldivice.Count


# Crear un objeto personalizado con las variables
$statsObject = New-Object PSObject -Property @{
    "WindowsServer" = $numberWindowsserver
    "Windows11" = $numberWindows11
    "Windows10" = $numberWindows10
    "Windows8" = $numberWindows
    "Windows7" = $numberWindows7
    "WindowsXP" = $numberWindowsxp
    "ALL" = $numberalldivice
}

# Mostrar el objeto en la consola
$statsObject


$CSVFile9 = Join-Path -Path $registerroot -ChildPath "CountSO.csv"

# Exportar el objeto a un archivo CSV
$statsObject | Export-Csv -Path $CSVFile9 -NoTypeInformation



######## Divice Numbers #########



########### Domain ADMins #####################

$CSVFile10 = Join-Path -Path $registerroot -ChildPath "DomainsAdmins.csv"

$DomainADmins =  Get-ADGroupMember "Domain ADmins" | Get-AdUser -Property LastLogonDate | select name,distinguishedName,LastLogonDate

$DomainADmins | Export-Csv -Path $csvFile10  -NoTypeInformation

########### Domain ADMins #####################


############## Domain schema ##################

$CSVFile11 = Join-Path -Path $registerroot -ChildPath "Domainschema.csv"

$DomainSchema= Get-ADGroupMember "Schema Admins" | Get-AdUser -Property LastLogonDate | select name,distinguishedName,LastLogonDate

$DomainSchema | Export-Csv -Path $csvFile11  -NoTypeInformation

############## Domain schema ##################



############## Domain Administrators ##################

$CSVFile12 = Join-Path -Path $registerroot -ChildPath "Administrators.csv"

$DomainAdministrators = Get-ADGroupMember "Administrators" | Get-AdUser -Property LastLogonDate | select name,distinguishedName,LastLogonDate

$DomainAdministrators | Export-Csv -Path $csvFile12  -NoTypeInformation

############## Domain Administrators ##################




############## EnterPrise Administrators ##################

$CSVFile13 = Join-Path -Path $registerroot -ChildPath "EnterpriseSAdministrators.csv"

$DomainEnterpri = Get-ADGroupMember "Enterprise Admins" | Get-AdUser -Property LastLogonDate | select name,distinguishedName,LastLogonDate

$DomainEnterpri | Export-Csv -Path $csvFile13  -NoTypeInformation

############## EnterPrise Administrators ##################

############## Count ADmins ##################

$DomainADminscount = $DomainADmins.Count

$DomainSchemacount = $DomainSchema.Count

$DomainAdministratorscount = $DomainAdministrators.Count

$DomainEnterpricount = $DomainEnterpri.Count

$totaladmins = $DomainADminscount + $DomainSchemacount + $DomainAdministratorscount + $DomainEnterpricount 

$objetoadmins = New-Object -TypeName PSObject -Property @{
    "Domain Admin" = $DomainADminscount
    "Domain Schema" = $DomainSchemacount
    "Domain Administrators" = $DomainAdministratorscount
    "Enterprise Administrators"= $DomainEnterpricount
    "Total Admins" = $totaladmins 

}

$CSVFile13 = Join-Path -Path $registerroot -ChildPath "TotalAdmins.csv"

$objetoadmins | Export-Csv -Path $csvFile13  -NoTypeInformation

############## Count ADmins ##################


################### Disabled Account ########################################

$CSVFile14 = Join-Path -Path $registerroot -ChildPath "DisabledAccount.csv"

$DisabledAccount = Search-ADAccount –AccountDisabled –UsersOnly –ResultPageSize 2000 –ResultSetSize $null | Select-Object SamAccountName, DistinguishedName

$DisabledAccount | Export-Csv -Path $csvFile14  -NoTypeInformation

################### Disabled Account ########################################

###################  all users , Devices , groups ###########################################

$DisabledAccountnum =$DisabledAccount.count

$alluser = (Get-ADUser -Filter *).Count

$allgroup = (Get-ADGroup -Filter *).Count

$alldevice = (Get-ADComputer -Filter *).Count

$objetototaladacount = New-Object -TypeName PSObject -Property @{
    "Total  AD Account" = $alluser
    "Total Disabled Users" = $DisabledAccountnum
    "Total AD Groups" = $allgroup
    "Total Devices"= $alldevice

}


$CSVFile15 = Join-Path -Path $registerroot -ChildPath "allUsersDevicesGroups.csv"


$objetototaladacount | Export-Csv -Path $CSVFile15  -NoTypeInformation

###################  all users , Devices , groups ###########################################


################## Users Password Never Expire  #####################

$CSVFile16 = Join-Path -Path $registerroot -ChildPath "allUsersPasswordNeverExpire.csv"

$allNeverExpire = Get-ADUser -Filter {PasswordNeverExpires -eq "TRUE"} -Properties PasswordNeverExpires | Select Name, SamAccountName, PasswordNeverExpires, Mail | Where-Object { $_.PasswordNeverExpires -like "True" }

$allNeverExpire | Export-Csv -Path $csvFile16 -NoTypeInformation

$allNeverExpirecount = $allNeverExpire.Count

#################  Admin Password Never Expire Domain Admins   #####################

$CSVFile17 = Join-Path -Path $registerroot -ChildPath "DomainADminsPasswordneverexpire.csv"

$domainAdminsMembers = Get-ADGroupMember -Identity "Domain admins"

$domainAdmins = $domainAdminsMembers | ForEach-Object {
    $user = Get-ADUser -Identity $_.SamAccountName -Properties PasswordNeverExpires, LastLogonDate
    if ($user.PasswordNeverExpires) {
        $user | Select-Object Name, PasswordNeverExpires
    }
}

$domainAdmins | Export-Csv -Path $csvFile17 -NoTypeInformation

#################  Admin Password Never Expire Domain Admins   #####################

#################   Paswword Never Expire Details  #####################

$CSVFile18 = Join-Path -Path $registerroot -ChildPath "PasswordNeverExpireCount.csv"

$DomainAdminsCount = (Get-ADUser -Filter {PasswordNeverExpires -eq "TRUE"}).Count

$PasswordNeverExpireDetails = New-Object -TypeName PSObject -Property @{
    "Total AD User Password Never Expire" = $DomainAdminsCount
    "Total AD Admins Password Never Expire" = $allNeverExpirecount
}

$PasswordNeverExpireDetails

$PasswordNeverExpireDetails | Export-Csv -Path $csvFile18 -NoTypeInformation


#################   Paswword Never Expire Details  #####################



