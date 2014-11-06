Projet réalisé par Théo PLOCKYN et Rémy DEBUE 

Choix des variables : 

Au départ pour les mois nous avions choisis JANVIER, FEVRIER etc mais nous nous sommes rendus compte que la gestion des stocks indicés sur le mois était plus pratique avec des numéros ( 1 pour Janvier , 2 Févier ..)

Pour les autres variables nous avons donné des noms peut être un peu long mais explicite ex :

set HUILES_V; /* represente les huiles vegetales */
set HUILES_A;	/*represente les huiles animales */
set HUILES := HUILES_V union HUILES_A;	/*represente l'union des huiles animales et végétales */
param N integer >= 0;	/* N represente la variation du mois */
set MOIS := 1 .. N;
param cout_achat{HUILES,MOIS} 	>= 0;	/* le cout d'achat des huiles dépend de l'huile courante ainsi que le mois */
param prix_vente 		>= 0;
param prod_max_v 		>= 0;
param prod_max_a 		>= 0;
param stockage_max		>= 0;
param durete{HUILES} 		>= 0;
param cout_stockage          	>= 0;
var stockage{HUILES, 0 .. N} 	integer >= 0;
var qte_vendue{HUILES,MOIS} 	integer >= 0;
var qte_achete{HUILES,MOIS}	integer >= 0;

Difficultés rencontrées : la gestion des stocks (au niveau de l'équilibre), la dureté avec la double contrainte, trouver du temps pour travailler ce projet (en prennant en compte tout les autres projets)



