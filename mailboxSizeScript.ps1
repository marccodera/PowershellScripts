# ---------------------------------------------------
# Original Script: C:\scripts\mailboxSizeScript.ps1
# Version: 0.1
# Author: Marc Codera
# Date: 10/04/2018 
# Description: Using PowerShell to find mailbox size for databases in current server and export them in a CSV
# Comments: If you want to know the mailbox size of all the mailboxes, run this script in every Exchange server
# ---------------------------------------------------


$databases = Get-MailboxDatabase
$servername = $env:computername

foreach ($database in $databases){
	if ($database.server -eq $servername){
		$mailboxStats = Get-MailboxDatabase $database.Name | Get-MailboxStatistics | Select-Object displayname, totalitemsize, itemcount
		$mailboxStats | export-csv -Path ("mailboxSize-" + $servername + "_" + $database.Name + ".csv")
	}
}
