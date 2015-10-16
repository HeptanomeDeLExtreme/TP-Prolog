:- dynamic pion/3.
%% pion(c,l,j).

%% Chemin de 3 sur la colonne 1
pion(1,1,1).
pion(1,2,1).
pion(1,3,1).

%% Chemin de 3 sur la ligne 4
%%pion(5,4,1).
%%pion(6,4,1).
%%pion(7,4,1).

% Incrémentation
incrementerX(X,X1):- X1 is X+1.

% Décrémentation
decrementerX(X,X1):- X1 is X-1.

% Ajoute le pion dans la base de faits
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)),
    retract(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    
% Trouve tous les pions du plateau
findAllPion(J,L) :- findall([X,Y], pion(X,Y,J), L), write(L).

% Parcourir la liste colonne
parcoursListeColonne([],J) :- true. %% INITIALISATION
parcoursListeColonne([[X,Y]|Q],J) :- incrementerX(Y,Y1), (nonvar(pion(X,Y1,J)), Y1<7->ajouterPion(X,Y1,J) ; parcoursListeColonne(Q,J)).

% Parcourir la liste ligne
parcoursListeLigne([],J) :- true. %% INITIALISATION
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J) :- decrementerX(Xgauche, X1), (nonvar(pion(Ligne, X1, J)), X1>0->ajouterPion(Ligne, X1, J) ; tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J)).

tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J) :- incrementerX(Xdroite, X1), (nonvar(pion(Ligne, X1, J)), X1<8->ajouterPion(Ligne, X1, J) ; parcoursListeLigne(Q,J)).

%% Trouver tous les chemins de longueur 3 (Colonnes + Lignes + Diagonales)
findAllPath3(J, ListeColonne, ListeLigne) :-
    % Trouver les colonnes de longueur 3
    findall([Xcolonne, Ycolonne], (pion(Xcolonne, Ycolonne, J), decrementerX(Ycolonne, Y1colonne), pion(Xcolonne, Y1colonne, J), decrementerX(Y1colonne, Y2colonne), pion(Xcolonne, Y2colonne, J)), ListeColonne), write(ListeColonne).
    % Trouver les lignes de longueur 3
    findall([Yligne, Xligne, X1ligne], (pion(Xligne, Yligne, J), decrementerX(Xligne, X1ligne), pion(X1ligne, Yligne, J)), ListeLigne), write(ListeLigne).
    % Trouver les diagonales gauches de longueur 3
    % Trouver les diagonales droites de longueur 3

%% Test l ajout d un pion pour les chemins de longueur 3
testLength3() :-
    % Test sur les colonnes
    findAllPath3(J, ListeColonne, ListeLigne),
    parcoursListeColonne(ListeColonne, J);
    parcoursListeLigne(ListeLigne, J).

%% Colonne %%
/*findAll3PathColonne(J,L) :- findall([X,Y],(pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J)),L),write(L).
findAll2PathColonne(J,L) :- findall([X,Y],(pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J)),L),write(L).
testColonne(J) :- findAll3PathColonne(J,L3),
			findAll2PathColonne(J,L2),
			append(L3,L2,L),
			parcoursListeColonne(L,J).
parcoursListeColonne([],J) :- true.
parcoursListeColonne([[X,Y]|Q],J) :- incrementeX(Y,Y1),(nonvar(pion(X,Y1,J)),Y1<7->ajouterPion(X,Y1,J);parcoursListeColonne(Q,J)).
%% Fin Colonne %%

%% Ligne %%
findAll3PathLigne(J,L) :- findall([Y,X2,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J), decrementeX(X1,X2), pion(X2,Y,J)),L),write(L).
findAll2PathLigne(J,L) :- findall([Y,X,X1],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J)),L),write(L).
testLigne(J) :- findAll3PathLigne(J,L3),
			findAll2PathLigne(J,L2),
			append(L3,L2,L),write(L),
			parcoursListeLigne(L,J).
parcoursListeLigne([],J) :- true.
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J) :- decrementeX(Xgauche, X1), (nonvar(pion(Ligne, X1, J)),X1>0->ajouterPion(Ligne, X1, J);tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J)).
tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J) :- incrementeX(Xdroite, X1), (nonvar(pion(Ligne, X1, J)),X1<8->ajouterPion(Ligne, X1, J);parcoursListeLigne(Q,J)).
%%parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J) :- parcoursListeLigne(Q, J).
%% Fin Ligne %%
*/

