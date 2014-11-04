set HUILES_V;
set HUILES_A;
set HUILES := HUILES_V union HUILES_A;
param N integer >= 0;
set MOIS := 1 .. N;
param cout_achat{HUILES,MOIS} 	>= 0;
param prix_vente 		>= 0;
param prod_max_v 		>= 0;
param prod_max_a 		>= 0;
param stockage_max		>= 0;
param durete{HUILES} 		>= 0;
param cout_stockage          	>= 0;
var stockage{HUILES, 0 .. N} 	integer >= 0;
var qte_vendue{HUILES,MOIS} 	integer >= 0;
var qte_achete{HUILES,MOIS}	integer >= 0;

maximize vente_nourriture :
	sum{h in HUILES, m in MOIS} prix_vente * qte_vendue[h,m]
	- sum{h in HUILES, m in MOIS} cout_achat[h,m] * qte_achete[h,m]
	- sum{h in HUILES, m in MOIS} cout_stockage   * stockage[h,m];

/* On ne peut pas produire plus de 200 tonnes d'huile végétale */
subject to production_max_v{m in MOIS} :
	sum{h in HUILES_V} qte_vendue[h,m] <= prod_max_v;

/* On ne peut pas produire plus de 250 tonnes d'huile animale  */
subject to production_max_a{m in MOIS} :
	sum{h in HUILES_A} qte_vendue[h,m] <= prod_max_a;

/* La durete de l'huile doit être comprise entre 3 et 6*/
subject to durete_intervalle_max{m in MOIS} :
	/* il faut rajouter la moyenne pondérée*/
	sum{h in HUILES} durete[h]*qte_vendue[h,m]   <= 6*sum{h in HUILES}qte_vendue[h,m];
subject to durete_intervalle_min{m in MOIS} :
	/* il faut rajouter la moyenne pondérée*/
	sum{h in HUILES} durete[h]*qte_vendue[h,m]   >= 3*sum{h in HUILES}qte_vendue[h,m];

/* contrainte sur le stockage initial */
subject to stockage_initial{h in HUILES, m in MOIS} :
	stockage[h, 0] = 500;
subject to stockage_final{h in HUILES, m in MOIS} :
	stockage[h,N] = 500;
subject to stockage_equilibre{h in HUILES, m in MOIS} :
	stockage[h,m] = stockage[h,m-1] + qte_achete[h,m] - qte_vendue[h,m];

subject to stockage_max_nourriture{h in HUILES, m in MOIS} :
	stockage[h,m] <= stockage_max;

data;
set HUILES_V := VEG1 VEG2;
set HUILES_A := ANI1 ANI2 ANI3;
param N = 6;
param prod_max_v := 200;
param prod_max_a := 250;
param stockage_max := 1000;
param prix_vente := 150;
param cout_stockage := 5;

param cout_achat (tr) :
	VEG1	VEG2	ANI1	ANI2	ANI3 :=
1	110	120	130	110	115
2	130	130	110	90	115
3	110	140	130	100	95
4	120	110	120	120	125
5	100	120	150	110	105
6	90	100	140	80	135;

param durete :=
VEG1 	8.8
VEG2	6.1
ANI1	2.0
ANI2	4.2
ANI3	5.0;



