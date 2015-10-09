/* Base de faits :
pion(Colonne, Ligne, {1|2}). */

pion(1, 1, 1).
pion(1, 2, 1).
pion(1, 3, 2).
pion(1, 4, 2).
    
/* IsolerColonne permet de prendre uniquement la colonne
que le joueur/IA aura joue */
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

/* Permet de recuperer le numero de ligne du dernier pion qui aura ete joue */
indexDernierPion(Colonne, NumeroLigne) :-
    last(Colonne, pion(_, NumeroLigne, _)).
    
/* Permet de savoir s_il reste encore de la place dans la colonne */
/* DEMANDER UN NOUVEL INPUT A L IA/LE JOUEUR */
colonneIndisponible(NumeroLigne, X, Xnew) :-
    NumeroLigne = 6, jouerCoup(X, Xnew, [1, 2]).

/* X represente l''ancien tableau de jeu
Xnew represente le nouveau tableau avec le coup joue
N represente un tableau avec [colonneSelectionnee, numeroJoueur] */

jouerCoup(X, Xnew, [NumeroColonne, Joueur]) :-
    /* Isoler la colonne jouee */
    isolerColonne(NumeroColonne, Colonne),
    
    /* Recuperer l''index de la prochaine case vide */
    indexDernierPion(Colonne, NumeroLigne),
    
    /* Si la colonne est n''est pas pleine, nous pouvons ajouter le nouveau coup
    dans la colonne */
    colonneIndisponible(NumeroLigne, X, Xnew),
    
    /* TODOOOOOOOOOOOOOOOOOOOOOO */
    not (colonneIndisponible) :- pion(NumeroColonne, NumeroLignePlus1, Joueur), NumeroLignePlus1 is NumeroLigne + 1.
