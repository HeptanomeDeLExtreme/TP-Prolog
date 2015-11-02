/* FONCTIONS UTILITAIRES */

incrementeX(X,X1):- X1 is X+1.

decrementeX(X,X1):- X1 is X-1.

doubleInc(X,Y,X1,Y1) :- X1 is X+1,Y1 is Y+1.

ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)).

testVidePlateau1 :- (
                   retract(pion(_,_,1)) -> testVidePlateau1;
                   true
                   ).

testVidePlateau2 :- (
    retract(pion(_,_,2)) -> testVidePlateau2;
    true
    ).

% Méthode pour vider le plateau
testVidePlateau :- testVidePlateau1,testVidePlateau2.

debug(S) :- jpl_call('main',debug,[S],_).
