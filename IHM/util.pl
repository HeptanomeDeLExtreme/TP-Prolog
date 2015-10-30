/* FONCTIONS UTILITAIRES */

incrementeX(X,X1):- X1 is X+1.

decrementeX(X,X1):- X1 is X-1.

doubleInc(X,Y,X1,Y1) :- X1 is X+1,Y1 is Y+1.

ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)).
