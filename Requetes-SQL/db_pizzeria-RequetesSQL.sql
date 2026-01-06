USE db_pizzeria;

-- Requête 1 Les 10 pizzas les plus vendues (sans toppings)
SELECT a.nom AS 'Pizza', SUM(lc.quantite) AS 'Nombres vendues'
FROM t_lignecommande lc
JOIN t_article a ON lc.article_fk = a.article_id
WHERE a.typeArticle = 'pizza'
AND lc.t_lignecommande_fk IS NULL
GROUP BY a.nom
ORDER BY SUM(lc.quantite) DESC
LIMIT 10;


-- Requête 2 Les toppings les plus ajoutés
SELECT a.nom AS 'Nom du topping', COUNT(*) AS 'Nombre d ajouts'
FROM t_lignecommande lc
JOIN t_article a ON lc.article_fk = a.article_id
WHERE a.typeArticle = 'topping'
AND lc.t_lignecommande_fk IS NOT NULL
GROUP BY a.nom
ORDER BY COUNT(*) DESC;


-- Requête 3 Chiffre d'affaires par jour (commandes livrées)
SELECT DATE(c.dateHeure) AS 'Date', ROUND(SUM(lc.quantite * lc.prixUnitaire), 2) AS 'Chiffre d affaires'
FROM t_commande c
JOIN t_lignecommande lc ON c.commande_id = lc.commande_fk
WHERE c.statusCommande LIKE 'livr_e'
GROUP BY DATE(c.dateHeure)
ORDER BY DATE(c.dateHeure);


-- Requête 4 Chiffre d'affaires par NPA
SELECT a.NPA AS 'NPA', a.localite AS 'Localite', ROUND(SUM(lc.quantite * lc.prixUnitaire), 2) AS 'Chiffre d affaires'
FROM t_commande c
JOIN t_adresse a ON c.adresse_fk = a.adresse_id
JOIN t_lignecommande lc ON c.commande_id = lc.commande_fk
WHERE c.adresse_fk IS NOT NULL
GROUP BY a.NPA, a.localite
ORDER BY SUM(lc.quantite * lc.prixUnitaire) DESC;


-- Requête 5 Nombre de commandes par heure
SELECT HOUR(c.dateHeure) AS 'Heure',  COUNT(*) AS 'Nombre de commandes'
FROM t_commande c
GROUP BY HOUR(c.dateHeure)
ORDER BY COUNT(*) DESC;


-- Requête 6 Clients les plus fidèles avec 5 commandes au minimum
SELECT cl.nom AS 'Nom', cl.prenom AS 'Prenom', COUNT(c.commande_id) AS 'Nombre de commandes'
FROM t_client cl
JOIN t_commande c ON cl.client_id = c.client_fk
GROUP BY cl.client_id, cl.nom, cl.prenom
HAVING COUNT(c.commande_id) >= 5
ORDER BY COUNT(c.commande_id) DESC, cl.nom ASC;


-- Requête 7 Total dû par commande
SELECT c.commande_id AS 'ID commande', ROUND(SUM(lc.quantite * lc.prixUnitaire), 2) AS 'Montant du'
FROM t_commande c
JOIN t_lignecommande lc ON c.commande_id = lc.commande_fk
GROUP BY c.commande_id
ORDER BY c.commande_id ASC;


-- Requête 8 Total payé par commande
SELECT c.commande_id AS 'ID commande', ROUND(SUM(p.montant), 2) AS 'Total paye'
FROM t_commande c
JOIN t_paiement p ON c.commande_id = p.commande_fk
GROUP BY c.commande_id
ORDER BY c.commande_id ASC;


-- Requête 9 Répartition des types de commandes pour connaître la proportion de chaque type de commande
SELECT c.typeCommande AS 'Type', COUNT(*) AS 'Nombre de commandes'
FROM t_commande c
GROUP BY c.typeCommande
ORDER BY COUNT(*) DESC;


-- Requête 10 Délai moyen de livraison par livreur en minutes
SELECT  liv.livreur_id AS 'ID Livreur', liv.nom AS 'Nom', 
ROUND(AVG(TIMESTAMPDIFF(MINUTE, l.depart, l.arrivee)), 0) AS 'Delai en minutes'
FROM t_livreur liv
JOIN t_livrer lv ON liv.livreur_id = lv.livreur_fk
JOIN t_livraison l ON lv.livraison_fk = l.livraison_id
GROUP BY liv.livreur_id, liv.nom
ORDER BY AVG(TIMESTAMPDIFF(MINUTE, l.depart, l.arrivee)) ASC;