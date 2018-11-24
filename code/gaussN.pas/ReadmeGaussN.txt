1.Entrez la taille de la matrice.(Entre 2 et 20)

2.Entrez les valeurs de la matrice dans l'ordre de A[1,1], A[1,2]...

Séparez chaque numéro avec un ESPACE et utilisez ENTREE pour changer les lignes.

3.Finalement, vous obtiendrez les matrices L1, U1, L et U.



Comment ça fonctionne:

D’abord on demande la taille de la matrice entrée
Puis on lit les valeurs de la matrice et les met dans un tableau sous le nom « mat »
On établit ensuite deux matrices L1 et U1 vides
On rentre toutes les valeurs dans la diagonale de L1 égales à 1 et de U1 égales à 0
Puis pour L1, on prend la première valeur de chaque ligne de la matrice de base appelée « mat » et 
les divise par mat[1,1]. 
On a U1 avec l’aide de deux boucles et la multiplication de L1 par la matrice « mat ».
A chaque boucle, on calcule une colonne et une ligne comme avec L1 et U1 puis on les met dans
les matrices L et U. Enfin on obtiendra toutes les valeurs des matrices L et U par colonne et
par ligne.