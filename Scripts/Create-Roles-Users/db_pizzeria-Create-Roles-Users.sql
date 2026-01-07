-- Supprimer les users si ils existent
DROP USER IF EXISTS 'jean_pizzeria'@'localhost';
DROP USER IF EXISTS 'luca_pizzeria'@'localhost';
DROP USER IF EXISTS 'antonio_pizzeria'@'localhost';
DROP USER IF EXISTS 'marco_pizzeria'@'localhost';
DROP USER IF EXISTS 'laura_pizzeria'@'localhost';
DROP USER IF EXISTS 'nicolas_pizzeria'@'localhost';

-- Supprimer les rôles si ils existent
DROP ROLE IF EXISTS 'administrateurs_pizzeria';
DROP ROLE IF EXISTS 'managers_pizzeria';
DROP ROLE IF EXISTS 'pizzaiolos_pizzeria';
DROP ROLE IF EXISTS 'livreurs_pizzeria';
DROP ROLE IF EXISTS 'agentscaisse_pizzeria';
DROP ROLE IF EXISTS 'analystes_pizzeria';


-- Créer le role administrateur
CREATE ROLE 'administrateurs_pizzeria';

-- Tous les privilèges sur db_pizzeria
GRANT ALL PRIVILEGES ON db_pizzeria.* TO 'administrateurs_pizzeria' WITH GRANT OPTION;

-- Gestion des utilisateurs
GRANT CREATE USER ON *.* TO 'administrateurs_pizzeria';
GRANT RELOAD ON *.* TO 'administrateurs_pizzeria';
GRANT SHOW DATABASES ON *.* TO 'administrateurs_pizzeria';



-- Créer le role manager
CREATE ROLE 'managers_pizzeria';

-- Gestion complète des commandes
GRANT SELECT, INSERT, UPDATE, DELETE ON db_pizzeria.t_commande TO 'managers_pizzeria';

-- Gestion des lignes de commande
GRANT SELECT, INSERT, UPDATE, DELETE ON db_pizzeria.t_lignecommande TO 'managers_pizzeria';

-- Gestion des livraisons
GRANT SELECT, INSERT, UPDATE, DELETE ON db_pizzeria.t_livraison TO 'managers_pizzeria';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_pizzeria.t_livrer TO 'managers_pizzeria';
GRANT SELECT, INSERT, UPDATE, DELETE ON db_pizzeria.t_avoir TO 'managers_pizzeria';

-- Lecture des paiements
GRANT SELECT ON db_pizzeria.t_paiement TO 'managers_pizzeria';

-- Gestion du catalogue (articles)
GRANT SELECT, INSERT, UPDATE, DELETE ON db_pizzeria.t_article TO 'managers_pizzeria';

-- Consultation des clients, adresses, livreurs
GRANT SELECT ON db_pizzeria.t_client TO 'managers_pizzeria';
GRANT SELECT ON db_pizzeria.t_adresse TO 'managers_pizzeria';
GRANT SELECT ON db_pizzeria.t_vivre TO 'managers_pizzeria';
GRANT SELECT ON db_pizzeria.t_livreur TO 'managers_pizzeria';



-- Créer le role pizzaiolo
CREATE ROLE 'pizzaiolos_pizzeria';

-- Lecture des commandes
GRANT SELECT ON db_pizzeria.t_commande TO 'pizzaiolos_pizzeria';

-- Lecture des lignes de commande (pour voir ce qu'il faut préparer)
GRANT SELECT ON db_pizzeria.t_lignecommande TO 'pizzaiolos_pizzeria';

-- Lecture des articles (pour connaître les recettes)
GRANT SELECT ON db_pizzeria.t_article TO 'pizzaiolos_pizzeria';

-- Mise à jour du statut des commandes
GRANT UPDATE (statusCommande) ON db_pizzeria.t_commande TO 'pizzaiolos_pizzeria';



-- Créer le role livreur
CREATE ROLE 'livreurs_pizzeria';

-- Lecture des commandes de type "livraison"
GRANT SELECT ON db_pizzeria.t_commande TO 'livreurs_pizzeria';

-- Lecture des lignes de commande (pour vérifier la commande)
GRANT SELECT ON db_pizzeria.t_lignecommande TO 'livreurs_pizzeria';

-- Lecture des articles
GRANT SELECT ON db_pizzeria.t_article TO 'livreurs_pizzeria';

-- Lecture des adresses de livraison et des clients
GRANT SELECT ON db_pizzeria.t_adresse TO 'livreurs_pizzeria';
GRANT SELECT ON db_pizzeria.t_client TO 'livreurs_pizzeria';

-- Lecture et mise à jour des livraisons
GRANT SELECT, UPDATE ON db_pizzeria.t_livraison TO 'livreurs_pizzeria';

-- Lecture des informations de livreur
GRANT SELECT ON db_pizzeria.t_livreur TO 'livreurs_pizzeria';

-- Lecture des relations livraison
GRANT SELECT ON db_pizzeria.t_livrer TO 'livreurs_pizzeria';
GRANT SELECT ON db_pizzeria.t_avoir TO 'livreurs_pizzeria';

-- Mise à jour du statut de commande
GRANT UPDATE (statusCommande) ON db_pizzeria.t_commande TO 'livreurs_pizzeria';



-- Créer le role d'agent de caisse
CREATE ROLE 'agentscaisse_pizzeria';

-- Gestion complète des paiements
GRANT SELECT, INSERT, UPDATE ON db_pizzeria.t_paiement TO 'agentscaisse_pizzeria';

-- Lecture des commandes
GRANT SELECT ON db_pizzeria.t_commande TO 'agentscaisse_pizzeria';

-- Lecture des lignes de commande
GRANT SELECT ON db_pizzeria.t_lignecommande TO 'agentscaisse_pizzeria';

-- Lecture des articles
GRANT SELECT ON db_pizzeria.t_article TO 'agentscaisse_pizzeria';

-- Lecture des clients
GRANT SELECT ON db_pizzeria.t_client TO 'agentscaisse_pizzeria';

-- Création de nouvelles commandes
GRANT INSERT ON db_pizzeria.t_commande TO 'agentscaisse_pizzeria';
GRANT INSERT ON db_pizzeria.t_lignecommande TO 'agentscaisse_pizzeria';



-- Créer le role d'analyste
CREATE ROLE 'analystes_pizzeria';

-- Lecture seule sur toutes les tables de db_pizzeria
GRANT SELECT ON db_pizzeria.* TO 'analystes_pizzeria';



-- Création des utilisateurs

-- Utilisateur Administrateur
CREATE USER 'jean_pizzeria'@'localhost' IDENTIFIED BY 'AdminPizzThanos!';
GRANT 'administrateurs_pizzeria' TO 'jean_pizzeria'@'localhost';
SET DEFAULT ROLE 'administrateurs_pizzeria' TO 'jean_pizzeria'@'localhost';

-- Utilisateur Manager
CREATE USER 'luca_pizzeria'@'localhost' IDENTIFIED BY 'ManagerPizzThanos!';
GRANT 'managers_pizzeria' TO 'luca_pizzeria'@'localhost';
SET DEFAULT ROLE 'managers_pizzeria' TO 'luca_pizzeria'@'localhost';

-- Utilisateur Pizzaiolo
CREATE USER 'antonio_pizzeria'@'localhost' IDENTIFIED BY 'PizzaioloPizzThanos!';
GRANT 'pizzaiolos_pizzeria' TO 'antonio_pizzeria'@'localhost';
SET DEFAULT ROLE 'pizzaiolos_pizzeria' TO 'antonio_pizzeria'@'localhost';

-- Utilisateur Livreur
CREATE USER 'marco_pizzeria'@'localhost' IDENTIFIED BY 'LivreurPizzThanos!';
GRANT 'livreurs_pizzeria' TO 'marco_pizzeria'@'localhost';
SET DEFAULT ROLE 'livreurs_pizzeria' TO 'marco_pizzeria'@'localhost';

-- Utilisateur Agent de caisse
CREATE USER 'laura_pizzeria'@'localhost' IDENTIFIED BY 'AgentCaissePizzThanos!';
GRANT 'agentscaisse_pizzeria' TO 'laura_pizzeria'@'localhost';
SET DEFAULT ROLE 'agentscaisse_pizzeria' TO 'laura_pizzeria'@'localhost';

-- Utilisateur Analyste
CREATE USER 'nicolas_pizzeria'@'localhost' IDENTIFIED BY 'AnalystePizzThanos!';
GRANT 'analystes_pizzeria' TO 'nicolas_pizzeria'@'localhost';
SET DEFAULT ROLE 'analystes_pizzeria' TO 'nicolas_pizzeria'@'localhost';

-- Application des privilèges
FLUSH PRIVILEGES;