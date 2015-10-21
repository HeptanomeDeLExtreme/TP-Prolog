:- dynamic pion/3.
%% pion(c,l,j).

%% Pion fictif
pion(1,0,-10).
pion(2,0,-10).
pion(3,0,-10).
pion(4,0,-10).
pion(5,0,-10).
pion(6,0,-10).
pion(7,0,-10).

%% COLONNE
%%pion(1,1,1).
%%pion(1,2,1).
%%pion(1,3,1).

%% LIGNE
%pion(5,4,1).
%pion(6,4,1).
%pion(7,4,1).

%% DIAG DROITE
%% pion(1,1,1).
%% pion(2,2,1).
%% pion(3,3,1).

%% DIAG GAUCHE
%% pion(7,1,1).
%% pion(6,2,1).
%% pion(5,3,1).

%% TEST COMPLET
pion(1,1,2).
pion(2,1,1).
pion(3,1,1).
pion(4,1,1).
pion(5,1,2).
%pion(6,1,1).
%pion(7,1,1).
%pion(1,2,1).
%pion(1,1,2).
%pion(2,1,1).
%pion(3,1,1).
%pion(4,1,1).
%pion(5,1,2).
%pion(3,2,1).
%pion(3,3,1).
%pion(3,4,2).
%pion(6,2,1).
%pion(5,2,1).
%pion(5,3,1).


%% FONCTIONS UTILITAIRES
incrementeX(X,X1):- X1 is X+1.
decrementeX(X,X1):- X1 is X-1.
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    
%% PARTIE LOGIQUE
stop :- true.
zbla :- write('zbla').
iAOffensive(J,N) :- (%testInsertion3C(J,N)->stop ; 
		     testInsertion3L(J,N)->stop ;
		     %testInsertion2C(J,N)->stop ;
		     %testInsertion2L(J,N)->stop ;
		     zbla
		    ).
%% on regarde sur les 3 colonnes, si on peut => on renvoit colonne
testInsertion3C(J,N) :- findAll3PathColonne(J,L),parcoursListeColonne(L,J,N).
%% sinon on regarde sur 3 lignes, si on peut => on renvoit colonne
testInsertion3L(J,N) :- findAll3PathLigne(J,L),parcoursListeLigne(L,J,N).
%% sinon on regarde sur 3 diagDroit, si on peut => on renvoit colonne
%testInsertion(J,N) :- findAll3PathDiagGauche(J,L),parcoursListeDiagGauche(L,J).
%% sinon on regarde sur 3 diagGauche, si on peut => on renvoit colonne
%%testInsertion(J,N) :- findAll3PathDiagDroite(J,L),parcoursListeDiagDroite(L,J).

%% on regarde sur les 2 colonnes, si on peut => on renvoit colonne
testInsertion2C(J,N) :- findAll2PathColonne(J,L),parcoursListeColonne(L,J,N).
%% sinon on regarde sur 2 lignes, si on peut => on renvoit colonne
testInsertion2L(J,N) :- findAll2PathLigne(J,L),parcoursListeLigne(L,J,N).
%% sinon on regarde sur 2 diagDroit, si on peut => on renvoit colonne
%%testInsertion(J,N) :- findAll2PathDiagGauche(J,L),parcoursListeDiagGauche(L,J).
%% sinon on regarde sur 2 diagGauche, si on peut => on renvoit colonne
%%testInsertion(J,N) :- findAll2PathDiagDroite(J,L),parcoursListeDiagDroite(L,J).

%% sinon on regarde pour les pions seuls, si on peut => on renvoit colonne

%% sinon iaAleatoire.


%% COLONNE %%
findAll3PathColonne(J,L) :- findall([X,Y],(pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J)),L).
findAll2PathColonne(J,L) :- findall([X,Y1],(pion(X,Y,J), incrementeX(Y,Y1), pion(X,Y1,J),incrementeX(Y1,Y2),not(pion(X,Y2,_))),L).

parcoursListeColonne([],J,N) :- false.
parcoursListeColonne([[X,Y]|Q],J,N) :- incrementeX(Y,Y1),(not(pion(X,Y1,_)),Y1<7->N is X;parcoursListeColonne(Q,J,N)).




%% LIGNE %%
findAll3PathLigne(J,L) :- findall([Y,X2,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J), decrementeX(X1,X2), pion(X2,Y,J)),L).
findAll2PathLigne(J,L) :- findall([Y,X1,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J)),L).

%% parcoursListeLigne([],J,N) :- false.
%% parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J,N) :- decrementeX(Xgauche, X1),
%% 							 decrementeX(Ligne,L1),
%% 							 (
%% 							     not(pion(Ligne, X1,_)),pion(L1,X1,_),X1>0 -> N is X1 ;
%% 							     tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J,N)
%% 							 ).
%% tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J,N) :- incrementeX(Xdroite, X1),
%% 							decrementeX(Ligne,L1),
%% 							(
%% 							    not(pion(Ligne, X1,_)),pion(L1,X1,_),X1<8 -> N is X1 ;
%% 							    parcoursListeLigne(Q,J,N)
%%  							).
  
isFull(X,Y) :- pion(X,Y,_),!.
isEmpty(X,Y) :- not(pion(X,Y,_)),!.

parcoursListeLigne([],J,N) :- false.
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J,N) :- decrementeX(Xgauche, X1),
							 decrementeX(Ligne,L1),
							 isEmpty(Ligne, X1),
							 %isFull(L1,X1),
							 X1>0,
							 N is X1,!.
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J,N) :- incrementeX(Xdroite, X1),
							 decrementeX(Ligne,L1),
							 isEmpty(Ligne, X1),
							 %isFull(L1,X1),
							 X1<8,
							 N is X1,!.
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J,N) :- parcoursListeLigne(Q,J,N).
							 

%% DIAG DROITE %%
findAll3PathDiagGauche(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), decrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J), incrementeX(X1,X2),decrementeX(Y1,Y2), pion(X2,Y2,J)),L),write(L).
findAll2PathDiagGauche(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), decrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J)),L),write(L).




%% DIAD GAUCHE %%
findAll3PathDiagDroite(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), incrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J), incrementeX(X1,X2),incrementeX(Y1,Y2), pion(X2,Y2,J)),L),write(L).
findAll2PathDiagDroite(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), incrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J)),L),write(L).
