DATE=$(date +"%Y-%m-%d_%Hh%M")
mysqldump -u root -proot --databases db_pizzeria > /var/lib/mysql-files/Scripts/Backup-Restore/backup_db_pizzeria_full_${DATE}.sql