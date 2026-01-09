# Date du dernier backup complet
LAST_DATE_FULL="2026-01-09 00:56:00"

# Fichier de sortie
DATE=$(date +"%Y-%m-%d_%Hh%M")
File="/scripts/Scripts/Backup-Restore/backup_db_pizzeria_diff_${DATE}.sql"

echo "USE db_pizzeria;" > $File

# Création de la backup différentielle
mysqldump -u root -proot --databases db_pizzeria --tables \
t_client t_article t_livreur \
t_adresse t_livraison t_commande \
t_paiement t_lignecommande t_vivre \
t_livrer t_avoir \
--no-create-info --where="dateModification >= '$LAST_DATE_FULL'" >> $File 2>/dev/null