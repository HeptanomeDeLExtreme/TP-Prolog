:- dynamic pion/3.

%% FONCTIONS UTILITAIRES

incrementeX(X,X1):- X1 is X+1.

decrementeX(X,X1):- X1 is X-1.

doubleInc(X,Y,X1,Y1) :- X1 is X+1,Y1 is Y+1.

ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)).

viderPlateau :- retract(pion(Colonne, Ligne, Joueur)), pion(Colonne, Ligne, Joueur), viderPlateau.

initialiserPlateau :-
%% pion(Colonne, Ligne, Joueur)
	assert(pion(1,0,-10)),
	assert(pion(2,0,-10)),
	assert(pion(3,0,-10)),
	assert(pion(4,0,-10)),
	assert(pion(5,0,-10)),
	assert(pion(6,0,-10)),
	assert(pion(7,0,-10)),
	assert(pion(-10,-10,-10)).
