USE db_pizzeria;

/* Requête 1
SELECT c.commande_id, c.dateHeure AS 'Date creation',
c.statusCommande, cl.nom AS 'Client'
FROM t_commande AS c
JOIN t_client AS cl ON c.client_fk = cl.client_id
WHERE c.statusCommande = 'livrée'
AND c.dateHeure > '2025-01-01 00:00:00'
ORDER BY c.dateHeure DESC;
*/

CREATE INDEX idx_commande_statut_date
ON t_commande(statusCommande, dateHeure);


/* Requête 2
SELECT a.NPA AS 'zone_npa', COUNT(c.commande_id) AS 'nb'
FROM t_commande AS c
JOIN t_adresse AS a ON c.adresse_fk = a.adresse_id
WHERE c.typeCommande = 'livraison'
AND HOUR(c.dateHeure) BETWEEN 18 AND 21
GROUP BY a.NPA
ORDER BY nb DESC;
*/

CREATE INDEX idx_commande_type_hour
ON t_commande(typeCommande, (HOUR(dateHeure)));