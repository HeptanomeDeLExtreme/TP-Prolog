/* ----------- Utils ----------- */


%% X1 est unifié à X+1
incrementeX(X,X1):- X1 is X+1.

%% X1 est unifié à X-1
decrementeX(X,X1):- X1 is X-1.

%% X1 est unifié à X+1 et Y1 à Y+1
doubleInc(X,Y,X1,Y1) :- X1 is X+1,Y1 is Y+1.

%% Ajoute un pion à la colonne NumeroColonne, 
%% à la ligne NumeroLigneSuivant
%% pour le joueur Joueur
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)).

%% Enleve les pions du joueur 1 du plateau
testVidePlateau1 :- (
                   retract(pion(_,_,1)) -> testVidePlateau1;
                   true
                   ).


%% Enleve les pions du joueur 2 du plateau
testVidePlateau2 :- (
    retract(pion(_,_,2)) -> testVidePlateau2;
    true
    ).

%% Vide le plateau des pions des joueurs 1 et 2
testVidePlateau :- testVidePlateau1,testVidePlateau2.

%% Affiche le texte S dans la console de l'IHM
debug(S) :- jpl_call('main',debug,[S],_).
