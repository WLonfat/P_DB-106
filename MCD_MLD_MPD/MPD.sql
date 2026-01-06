CREATE TABLE t_client(
   client_id INT AUTO_INCREMENT,
   nom VARCHAR(60) NOT NULL,
   prenom VARCHAR(40) NOT NULL,
   email VARCHAR(150) NOT NULL,
   num_tel VARCHAR(60) NOT NULL,
   PRIMARY KEY(client_id)
);

CREATE TABLE t_article(
   article_id INT AUTO_INCREMENT,
   typeArticle VARCHAR(60) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   prixTTC DECIMAL(10,2) NOT NULL,
   TVA DECIMAL(4,2) NOT NULL,
   etat BOOLEAN NOT NULL,
   PRIMARY KEY(article_id)
);

CREATE TABLE t_livreur(
   livreur_id VARCHAR(10),
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   num_tel VARCHAR(60) NOT NULL,
   PRIMARY KEY(livreur_id)
);

CREATE TABLE t_adresse(
   adresse_id INT AUTO_INCREMENT,
   rue VARCHAR(150) NOT NULL,
   NPA SMALLINT NOT NULL,
   localite VARCHAR(100) NOT NULL,
   latitude DECIMAL(9,6),
   longitude DECIMAL(9,6),
   PRIMARY KEY(adresse_id)
);

CREATE TABLE t_livraison(
   livraison_id INT AUTO_INCREMENT,
   depart DATETIME NOT NULL,
   arrivee DATETIME NOT NULL,
   PRIMARY KEY(livraison_id)
);

CREATE TABLE t_commande(
   commande_id INT AUTO_INCREMENT,
   typeCommande VARCHAR(40) NOT NULL,
   dateHeure DATETIME NOT NULL,
   statusCommande VARCHAR(30) NOT NULL,
   adresse_fk INT,
   client_fk INT NOT NULL,
   PRIMARY KEY(commande_id),
   FOREIGN KEY(adresse_fk) REFERENCES t_adresse(adresse_id),
   FOREIGN KEY(client_fk) REFERENCES t_client(client_id)
);

CREATE TABLE t_paiement(
   paiement_id INT AUTO_INCREMENT,
   modePaiement VARCHAR(20) NOT NULL,
   montant DECIMAL(15,2) NOT NULL,
   datePaiement DATETIME,
   commande_fk INT NOT NULL,
   PRIMARY KEY(paiement_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id)
);

CREATE TABLE t_lignecommande(
   lignecommande_id INT AUTO_INCREMENT,
   quantite SMALLINT NOT NULL,
   prixUnitaire DECIMAL(10,2) NOT NULL,
   t_lignecommande_fk INT,
   article_fk INT NOT NULL,
   commande_fk INT NOT NULL,
   PRIMARY KEY(lignecommande_id),
   FOREIGN KEY(t_lignecommande_fk) REFERENCES t_lignecommande(lignecommande_id),
   FOREIGN KEY(article_fk) REFERENCES t_article(article_id),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id)
);

CREATE TABLE t_vivre(
   client_fk INT,
   adresse_fk INT,
   PRIMARY KEY(client_fk, adresse_fk),
   FOREIGN KEY(client_fk) REFERENCES t_client(client_id),
   FOREIGN KEY(adresse_fk) REFERENCES t_adresse(adresse_id)
);

CREATE TABLE t_livrer(
   livreur_fk VARCHAR(10),
   livraison_fk INT,
   PRIMARY KEY(livreur_fk, livraison_fk),
   FOREIGN KEY(livreur_fk) REFERENCES t_livreur(livreur_id),
   FOREIGN KEY(livraison_fk) REFERENCES t_livraison(livraison_id)
);

CREATE TABLE t_avoir(
   commande_fk INT,
   livraison_fk INT,
   PRIMARY KEY(commande_fk, livraison_fk),
   FOREIGN KEY(commande_fk) REFERENCES t_commande(commande_id),
   FOREIGN KEY(livraison_fk) REFERENCES t_livraison(livraison_id)
);
