zbla(N) :- ia(N).

stop :- true.

iAOffensive(J,N) :- (testInsertion3C(J,N)->stop ; 
		     testInsertion3L(J,N)->stop ;
		     testInsertion3DG(J,N)->stop ;
		     testInsertion2C(J,N)->stop ;
		     testInsertion2L(J,N)->stop ;
		     testInsertion2DG(J,N)->stop ;
		     testInsertionPion(J,N)->stop ;
		     zbla(N)
		    ).

iADefensive(J,N) :- (testInsertion3C(J,N)->stop ; 
		     testInsertion3L(J,N)->stop ;
		     testInsertion3DG(J,N)->stop ;
		     testInsertion2C(J,N)->stop ;
		     testInsertion2L(J,N)->stop ;
		     testInsertion2DG(J,N)->stop ;
		     testInsertionPion(J,N)->stop ;
		     zbla(N)
		    ).

%% on regarde sur les 3 colonnes, si on peut => on renvoit colonne
testInsertion3C(J,N) :- findAll3PathColonne(J,L),parcoursListeColonne(L,J,N).

%% sinon on regarde sur 3 lignes, si on peut => on renvoit colonne
testInsertion3L(J,N) :- findAll3PathLigne(J,L),parcoursListeLigne(L,J,N).

%% sinon on regarde sur 3 diagDroit, si on peut => on renvoit colonne
testInsertion3DG(J,N) :- findAll3PathDiagGauche(J,L),parcoursListeDiagGauche(L,J,N).

%% sinon on regarde sur 3 diagGauche, si on peut => on renvoit colonne
testInsertion3DD(J,N) :- findAll3PathDiagDroite(J,L),parcoursListeDiagDroite(L,J,N).


%% on regarde sur les 2 colonnes, si on peut => on renvoit colonne
testInsertion2C(J,N) :- findAll2PathColonne(J,L),parcoursListeColonne(L,J,N).

%% sinon on regarde sur 2 lignes, si on peut => on renvoit colonne
testInsertion2L(J,N) :- findAll2PathLigne(J,L),parcoursListeLigne(L,J,N).

%% sinon on regarde sur 2 diagDroit, si on peut => on renvoit colonne
testInsertion2DG(J,N) :- findAll2PathDiagGauche(J,L),parcoursListeDiagGauche(L,J,N).

%% sinon on regarde sur 2 diagGauche, si on peut => on renvoit colonne
testInsertion2DD(J,N) :- findAll2PathDiagDroite(J,L),parcoursListeDiagDroite(L,J,N).

%% sinon on regarde pour les pions seuls, si on peut => on renvoit colonne
testInsertionPion(J,N) :- findAllPion(J,L),parcoursListePion(L,J,N).

%% sinon iaAleatoire.


%% PION %%
findAllPion(J,L) :- findall([X,Y],pion(X,Y,J),L).

parcoursListePion([],J,N) :- false.
parcoursListePion([[X,Y]|Q],J,N) :- incrementeX(X,X1),
							decrementeX(Y,Y1),
							decrementeX(Y1,Y11),
							(
							not(pion(X1,Y1,_)),pion(X1,Y11,_), X1<8 , Y1>0 -> N is X1;
							tenteAjoutD([[X,Y]|Q],J,N),
							).
tenteAjoutD([[X,Y]|Q],J,N) :- incrementeX(X,X1),
							decrementeX(Y,Y1),
							(
							not(pion(X1,Y,_)),pion(X1,Y1,_), X1<8 ,Y>0 -> N is X1;
							tenteAjoutHD([[X,Y]|Q],J,N),
							).
tenteAjoutHD([[X,Y]|Q],J,N) :- incrementeX(X,X1),
							incrementeX(Y,Y1),
							(
							not(pion(X1,Y1,_)),pion(X1,Y,_),X1<8, Y1<7-> N is X1;
							tenteAjoutH([[X,Y]|Q],J,N)
							).
tenteAjoutH([[X,Y]|Q],J,N) :- incrementeX(Y,Y1),
							(
							not(pion(X,Y1,_)), Y1<7 -> N is X;
							tenteAjoutHG([[X,Y]|Q],J,N)
							).
tenteAjoutHG([[X,Y]|Q],J,N) :- decrementeX(X,X1),
							incrementeX(Y,Y1),
							(
							not(pion(X1,Y1,_)),pion(X1,Y,_),X1>0,Y1<7 -> N is X1;
							tenteAjoutG([[X,Y]|Q],J,N)
							).
tenteAjoutG([[X,Y]|Q],J,N) :- decrementeX(X,X1),
							decrementeX(Y,Y1),
							(
							not(pion(X1,Y,_)),pion(X1,Y1,_),X1>0,Y>0 -> N is X1;
							tenteAjoutBG([[X,Y]|Q],J,N)
							).
tenteAjoutBG([[X,Y]|Q],J,N) :- decrementeX(X,X1),
							decrementeX(Y,Y1),
							decrementeX(Y1,Y11),
							(
							not(pion(X1,Y1,_)),pion(X1,Y11,_),X1>0,Y1>0 -> N is X1;
							parcoursListePion(Q,J,N)
							).


%% COLONNE %%
findAll3PathColonne(J,L) :- findall([X,Y],(pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J)),L).

findAll2PathColonne(J,L) :- findall([X,Y1],(pion(X,Y,J), incrementeX(Y,Y1), pion(X,Y1,J),incrementeX(Y1,Y2),not(pion(X,Y2,_))),L).


parcoursListeColonne([],J,N) :- false.
parcoursListeColonne([[X,Y]|Q],J,N) :- incrementeX(Y,Y1),(not(pion(X,Y1,_)),Y1<7->N is X;parcoursListeColonne(Q,J,N)).




%% LIGNE %%
findAll3PathLigne(J,L) :- findall([Y,X2,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J), decrementeX(X1,X2), pion(X2,Y,J)),L).

findAll2PathLigne(J,L) :- findall([Y,X1,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J)),L).


parcoursListeLigne([],J,N) :- false.
parcoursListeLigne([[Ligne, Xgauche, Xdroite]|Q],J,N) :- decrementeX(Xgauche, X1),
							 decrementeX(Ligne,L1),
							 (
							     not(pion(X1, Ligne,_)),pion(X1,L1,_),X1>0 -> N is X1 ;
							     tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J,N)
							 ).
tenteAjoutADroite([[Ligne, Xgauche, Xdroite]|Q],J,N) :- incrementeX(Xdroite, X1),
							decrementeX(Ligne,L1),
							(
							    not(pion(X1, Ligne,_)),pion(X1,L1,_),X1<8 -> N is X1 ;
							    parcoursListeLigne(Q,J,N)
 							).
  					 



%% DIAG GAUCHE %%
findAll3PathDiagGauche(J,L) :- findall([X2,Y2,X,Y],(pion(X,Y,J), decrementeX(X,X1),incrementeX(Y,Y1), pion(X1,Y1,J), incrementeX(Y1,Y2),decrementeX(X1,X2), pion(X2,Y2,J)),L).

findAll2PathDiagGauche(J,L) :- findall([X1,Y1,X,Y],(pion(X,Y,J), decrementeX(X,X1),incrementeX(Y,Y1), pion(X1,Y1,J)),L).



parcoursListeDiagGauche([],J,N) :- false.
parcoursListeDiagGauche([[X1,Y1,X2,Y2]|Q],J,N) :- decrementeX(X1, X11),
						  incrementeX(Y1,Y11),
						  (
						      not(pion(X11, Y11,_)),pion(X11,Y1,_),X11>0,Y11<7 -> N is X11 ;
						      tenteAjoutDiagGauche([[X1,Y1,X2,Y2]|Q],J,N)
						  ). 
tenteAjoutDiagGauche([[X1,Y1,X2,Y2]|Q],J,N) :- incrementeX(X2, X22),
					       decrementeX(Y2,Y22),
					       decrementeX(Y22,Y222),
					       (
						   not(pion(X22,Y22,_)),pion(X22,Y222,_),X22<8,Y22>0 -> N is X22 ;
						   parcoursListeDiagGauche(Q,J,N)
 					       ).

  					 

%% DIAG DROITE %%
findAll3PathDiagDroite(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), doubleInc(X,Y,X1,Y1), pion(X1,Y1,J),doubleInc(X1,Y1,X2,Y2), pion(X2,Y2,J)),L).

findAll2PathDiagDroite(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), doubleInc(X,Y,X1,Y1),pion(X1,Y1,J)),L).


parcoursListeDiagDroite([],J,N) :- false.
parcoursListeDiagDroite([[X1,Y1,X2,Y2]|Q],J,N) :- decrementeX(X1, X11),
						  decrementeX(Y1, Y11),
						  decrementeX(Y11,Y111),
						  (
						      not(pion(X11, Y11,_)),pion(X11,Y111,_),X11>0,Y11>0 -> N is X11 ;
						      tenteAjoutDiagDroite([[X1,Y1,X2,Y2]|Q],J,N)
						  ). 
tenteAjoutDiagDroite([[X1,Y1,X2,Y2]|Q],J,N) :- incrementeX(X2, X22),
					       incrementeX(Y2,Y22),
					       (
						   not(pion(X22,Y22,_)),pion(X22,Y2,_),X22<8,Y22<7 -> N is X22 ;
						   parcoursListeDiagDroite(Q,J,N)
 					       ).
