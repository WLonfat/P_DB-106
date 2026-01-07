USE db_pizzeria;

-- Désactiver les vérifications pour l'import
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO'; -- Ne déclenche pas l'auto increment

-- Tables sans dépendances
LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_client.csv'
INTO TABLE t_client
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(client_id, nom, prenom, email, num_tel);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_article.csv'
INTO TABLE t_article
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(article_id, typeArticle, nom, prixTTC, TVA, etat);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_livreur.csv'
INTO TABLE t_livreur
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(livreur_id, nom, prenom, num_tel);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_adresse.csv'
INTO TABLE t_adresse
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(adresse_id, rue, NPA, localite, latitude, longitude);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_livraison.csv'
INTO TABLE t_livraison
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(livraison_id, depart, arrivee);

-- Tables avec dépendances
LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_commande.csv'
INTO TABLE t_commande
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(commande_id, typeCommande, dateHeure, statusCommande, @adresse_fk, client_fk)
SET adresse_fk = NULLIF(@adresse_fk, '');

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_paiement.csv'
INTO TABLE t_paiement
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(paiement_id, modePaiement, montant, datePaiement, commande_fk);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_lignecommande.csv'
INTO TABLE t_lignecommande
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(lignecommande_id, quantite, prixUnitaire, @t_lignecommande_fk, article_fk, commande_fk)
SET t_lignecommande_fk = NULLIF(@t_lignecommande_fk, '');

-- Tables de liaison
LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_vivre.csv'
INTO TABLE t_vivre
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(client_fk, adresse_fk);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_livrer.csv'
INTO TABLE t_livrer
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(livreur_fk, livraison_fk);

LOAD DATA INFILE '/var/lib/mysql-files/DATA/CSV/t_avoir.csv'
INTO TABLE t_avoir
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(commande_fk, livraison_fk);

-- Réactiver la vérification des FK
SET FOREIGN_KEY_CHECKS = 1;