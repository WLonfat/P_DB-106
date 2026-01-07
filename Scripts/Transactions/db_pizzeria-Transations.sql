USE db_pizzeria;

SET AUTOCOMMIT = 0;

-- Transation valide
START TRANSACTION;

INSERT INTO t_paiement (modePaiement, montant, datePaiement, commande_fk)
VALUES ('carte', 48.00, NOW(), 3);

UPDATE t_commande
SET statusCommande = 'payée'
WHERE commande_id = 3;

COMMIT;

-- Vérification de l'update
SELECT commande_id, statusCommande
FROM t_commande
WHERE commande_id = 3;


-- Transaction invalide avec un id inexistant
START TRANSACTION;

INSERT INTO t_paiement (modePaiement, montant, datePaiement, commande_fk)
VALUES ('especes', 50.00, NOW(), 99999);

UPDATE t_commande
SET statusCommande = 'payée'
WHERE commande_id = 7;

ROLLBACK;

-- Vérification de l'annulation de l'update
SELECT commande_id, statusCommande
FROM t_commande
WHERE commande_id = 7;