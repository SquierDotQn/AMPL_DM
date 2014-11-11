set HUILES_V;
set HUILES_A;
set HUILES := HUILES_V union HUILES_A;
param N integer >= 0;
set MOIS := 1 .. N;
param cout_achat{HUILES, MOIS} 	>= 0;
param prix_vente 		>= 0;
param prod_max_v 		>= 0;
param prod_max_a 		>= 0;
param durete{HUILES} 		>= 0;
var production{HUILES, MOIS} 	>= 0;

/* Le profit est la différence entre la somme de tous les mois du chiffre d'affaire et celle des dépenses */
maximize vente_nourriture :
	sum{h in HUILES, m in MOIS} prix_vente * production[h,m]
	- sum{h in HUILES, m in MOIS} cout_achat[h,m] * production[h,m];
	
/* On ne peut pas produire plus de prod_max_v(200) tonnes d'huile végétale */
subject to production_max_v{m in MOIS} :
	sum{h in HUILES_V} production[h,m] <= prod_max_v;
	
/* On ne peut pas produire plus de prod_max_a(250) tonnes d'huile animale  */
subject to production_max_a{m in MOIS} :
	sum{h in HUILES_A} production[h,m] <= prod_max_a;
	
/* La dureté de la nourriture produite avec toutes les huiles utilisées doit être comprise entre 3 et 6, 
   mais encadrer la dureté en fait une contrainte non-linéaire, ainsi que de la diviser par une variable
   donc on sépare l'intervalle, et on factorise la contrainte pour la rendre linéaire */
subject to durete_intervalle_max{m in MOIS} :
	/* il faut rajouter la moyenne pondérée*/
	sum{h in HUILES} durete[h]*production[h,m]   <= 6*sum{h in HUILES}production[h,m];
subject to durete_intervalle_min{m in MOIS} :
	/* il faut rajouter la moyenne pondérée*/
	sum{h in HUILES} durete[h]*production[h,m]   >= 3*sum{h in HUILES}production[h,m];

data;
set HUILES_V := VEG1 VEG2;
set HUILES_A := ANI1 ANI2 ANI3;
param N = 6;
param prod_max_v := 200;
param prod_max_a := 250;
param prix_vente := 150;

param cout_achat (tr) :
	VEG1	VEG2	ANI1	ANI2	ANI3 :=
janvier	110	120	130	110	115
fevrier	130	130	110	90	115
mars	110	140	130	100	95
avril	120	110	120	120	125
mai	100	120	150	110	105
juin	90	100	140	80	135;

param durete :=
VEG1 	8.8
VEG2	6.1
ANI1	2.0
ANI2	4.2
ANI3	5.0;



