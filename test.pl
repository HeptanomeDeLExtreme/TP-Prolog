:- dynamic pion/3.
%% pion(c,l,j).

%% COLONNE
%%pion(1,1,1).
%%pion(1,2,1).
%%pion(1,3,1).

%% LIGNE
%%pion(5,4,1).
%%pion(6,4,1).
%%pion(7,4,1).

%% DIAG DROITE
%% pion(1,1,1).
%% pion(2,2,1).
%% pion(3,3,1).

%% DIAG GAUCHE
%% pion(7,1,1).
%% pion(6,2,1).
%% pion(5,3,1).

%% TEST COMPLET
pion(1,1,1).
pion(2,1,1).
pion(3,1,1).
pion(5,1,1).
pion(6,1,1).
pion(7,1,1).
pion(2,2,1).
pion(3,2,1).
pion(3,3,1).
pion(6,2,1).
pion(5,2,1).
pion(5,3,1).


%% FONCTIONS UTILITAIRES
incrementeX(X,X1):- X1 is X+1.
decrementeX(X,X1):- X1 is X-1.
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)),
    retract(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    

%% COLONNE %%
findAll3PathColonne(J,L) :- findall([X,Y],(pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J)),L),write(L).
findAll2PathColonne(J,L) :- findall([X,Y1],(pion(X,Y,J), incrementeX(Y,Y1), pion(X,Y1,J),incrementeX(Y1,Y2),not(pion(X,Y2,_))),L),write(L).

testColonne(J) :- findAll3PathColonne(J,L3),
			findAll2PathColonne(J,L2),
			append(L3,L2,L),
			parcoursListeColonne(L,J).
parcoursListeColonne([],J) :- true.
parcoursListeColonne([[X,Y]|Q],J) :- incrementeX(Y,Y1),(nonvar(pion(X,Y1,J)),Y1<7->ajouterPion(X,Y1,J);parcoursListeColonne(Q,J)).
%% Fin Colonne %%

%% LIGNE %%
findAll3PathLigne(J,L) :- findall([Y,X2,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J), decrementeX(X1,X2), pion(X2,Y,J)),L),write(L).
findAll2PathLigne(J,L) :- findall([Y,X1,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J)),L),write(L).

testLigne(J) :- findAll3PathLigne(J,L3),
			findAll2PathLigne(J,L2),
			append(L3,L2,L),write(L),
			parcoursListeLigne(L,J).
parcoursListeLigne([],J) :- true.
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J) :- decrementeX(Xgauche, X1), (nonvar(pion(Ligne, X1, J)),X1>0->ajouterPion(Ligne, X1, J);tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J)).
tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J) :- incrementeX(Xdroite, X1), (nonvar(pion(Ligne, X1, J)),X1<8->ajouterPion(Ligne, X1, J);parcoursListeLigne(Q,J)).
%%parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J) :- parcoursListeLigne(Q, J).
%% Fin Ligne %%

%% DIAG DROITE %%
findAll3PathDiagGauche(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), decrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J), incrementeX(X1,X2),decrementeX(Y1,Y2), pion(X2,Y2,J)),L),write(L).
findAll2PathDiagGauche(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), decrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J)),L),write(L).
%% Fin Diag Droite %%

%% DIAD GAUCHE %%
findAll3PathDiagDroite(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), incrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J), incrementeX(X1,X2),incrementeX(Y1,Y2), pion(X2,Y2,J)),L),write(L).
findAll2PathDiagDroite(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), incrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J)),L),write(L).
%% Fin Diag Gauche %%
