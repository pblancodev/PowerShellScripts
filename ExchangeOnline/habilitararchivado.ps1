

# 1) Nos Conectamos a Exchange Online

 Connect-ExchangeOnline

# 2) Creamos la Variable de los Buzones mediante la ruta.

$mailboxes = Import-Csv -Path C:\usariosm365\usermail.csv


#3) se Habilita el Archivado local en los Correos 

foreach ($mailbox in $mailboxes) {

    Enable-Mailbox -Identity $mailbox.EmailAddress -Archive
}


