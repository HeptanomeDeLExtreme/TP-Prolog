:- dynamic pion/3.
pion(-10,-10,-10).
/* ----------- IHM ----------- */
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F),jpl_call('main',init,[F],_).

coupJoueur(X,Y,Z) :- ajouterPion(X,Y,Z),
					(gagne(X,Y,Z)-> victoire;coupIA).
coupIA :- %%ia(N),
		%iADefensive(1,N),
		iAOffensive(2,N),
		jouerCoup([N,2]),
		testIA(N).
		
testIA(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,2)->echec;finTour).
		
testIA1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,1)->envoieMessageIA('J1 gagne');tourIA2).
		
testIA2(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,2)->envoieMessageIA('J2 gagne');tourIA1).
		
tourIA1 :-	%ia(N),
			iAOffensive(1,N),
			jouerCoup([N,1]),
			print,
			sleep(1),
			testIA1(N).
			
tourIA2 :-	%ia(M),
			iADefensive(1,M),
			jouerCoup([M,2]),
			print,
			sleep(1),
			testIA2(M).  

combatIA :- tourIA1.

envoieMessageIA(S) :- jpl_call('main',printMessage,[S],_).

finTour :- jpl_call('main',debug,['finTour'],_).

debug(S) :- jpl_call('main',debug,[S],_).

%% Predicat a appeler lorsqu'on veut rafraichir le plateau
print :- jpl_call( 'main', print, [], _).

%% Predicat a appeler en cas de victoire 
victoire :- jpl_call( 'main', victoire, [], _).

%% Predicat a appeler en cas d'echec
echec :- jpl_call( 'main', echec, [], _).

isolerColonneIJoueurX(I,X, Colonne) :- findall(pion(I, Y, X), pion(I, Y, X), Colonne).
    
cheminColonne(I,X) :- isolerColonneIJoueurX(I,X, Colonne),length(Colonne,T),write(T),( T == 4 -> victoire;echec). 

/* -------- Fin Jeu ------------*/
incrementeX(X,X1):- X1 is X+1.
decrementeX(X,X1):- X1 is X-1.
caseVide(X,Y) :- nonvar(X),nonvar(Y),not(case(X,Y,_)).

gagne(X,Y,J) :- victoireColonne(X,Y,J),jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- victoireLigne(X,Y,J),jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- victoireDiagGauche(X,Y,J),jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- victoireDiagDroite(X,Y,J),jpl_call('main',debug,['GAGNE'],_).

%% Colonne %%
victoireColonne(X,Y,J) :- pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J), decrementeX(Y2,Y3), pion(X,Y3,J). %ligne en bas

%% Ligne %%
victoireLigne(X,Y,J) :- verifieGauche(X,Y,J,Rg), verifieDroite(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

verifieGauche(X,Y,J,G):- gauche(X,Y,J,0,G).
gauche(X,Y,J,R,R) :- not(pion(X,Y,J)). 
gauche(X,Y,J,R,G) :- decrementeX(X,X1), incrementeX(R,R1), gauche(X1,Y,J,R1,G).

verifieDroite(X,Y,J,D):- droite(X,Y,J,0,D).
droite(X,Y,J,R,R) :- not(pion(X,Y,J)). 
droite(X,Y,J,R,D) :- incrementeX(X,X1), incrementeX(R,R1), droite(X1,Y,J,R1,D).

%% Diagonale Gauche %%
victoireDiagGauche(X,Y,J) :- verifieGaucheHaut(X,Y,J,Rg), verifieDroiteBas(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

verifieGaucheHaut(X,Y,J,G):- gaucheHaut(X,Y,J,0,G).
gaucheHaut(X,Y,J,R,R) :- not(pion(X,Y,J)).
gaucheHaut(X,Y,J,R,G) :- incrementeX(Y,Y1), decrementeX(X,X1), incrementeX(R,R1), gaucheHaut(X1,Y1,J,R1,G).

verifieDroiteBas(X,Y,J,D):- droiteBas(X,Y,J,0,D).
droiteBas(X,Y,J,R,R) :- not(pion(X,Y,J)). 
droiteBas(X,Y,J,R,D) :- decrementeX(Y,Y1), incrementeX(X,X1), incrementeX(R,R1), droiteBas(X1,Y1,J,R1,D).

%% Diagonale Droite %%
victoireDiagDroite(X,Y,J) :- verifieGaucheBas(X,Y,J,Rg), verifieDroiteHaut(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

verifieGaucheBas(X,Y,J,G):- gaucheBas(X,Y,J,0,G).
gaucheBas(X,Y,J,R,R) :- not(pion(X,Y,J)). 
gaucheBas(X,Y,J,R,G) :- decrementeX(Y,Y1), decrementeX(X,X1), incrementeX(R,R1), gaucheBas(X1,Y1,J,R1,G).

verifieDroiteHaut(X,Y,J,D):- droiteHaut(X,Y,J,0,D).
droiteHaut(X,Y,J,R,R) :- not(pion(X,Y,J)). 
droiteHaut(X,Y,J,R,D) :- incrementeX(Y,Y1), incrementeX(X,X1), incrementeX(R,R1), droiteHaut(X1,Y1,J,R1,D).

/* ----------- Ophelie et Cedric ----------- */
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

indexDernierPion(Colonne, NumeroLigne) :-
	(Colonne = []-> NumeroLigne is 0;last(Colonne, pion(_, NumeroLigne, _))).
    
calculProchainepion(NumeroLigne, NumeroLigneSuivant) :-
    NumeroLigneSuivant is NumeroLigne + 1.
    
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)),
    retract(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :- assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    
jouerCoup([NumeroColonne, Joueur]) :-
    isolerColonne(NumeroColonne, Colonne),
    
    indexDernierPion(Colonne, NumeroLigne),

    calculProchainepion(NumeroLigne, NumeroLigneSuivant),
    
    ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    

/* ----------- IA ----------- */
/* IA aleatoire */
ia(M):- repeat, N is random(7),M is N+1, peutJouer(M),!.
peutJouer(N):- \+ pion(N, 6, _).

/* IA offensive */

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
%% pion(7,1,2).
%% pion(6,2,2).
%% pion(5,3,2).
%% pion(3,1,2).
%% pion(2,2,2).
%% pion(1,3,2).

%% TEST COMPLET
%% pion(1,1,2).
%% pion(1,2,2).
%% pion(2,2,1).
%% pion(3,2,1).
%% pion(4,2,1).
%% pion(5,1,2).
%% pion(5,2,2).
%% pion(6,1,1).
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
zbla(N) :- ia(N),write('zbla').
iAOffensive(J,N) :- (testInsertion3C(J,N)->stop ; 
		     testInsertion3L(J,N)->stop ;
		     %testInsertion3DG(J,N)->stop ;
		     testInsertion2C(J,N)->stop ;
		     testInsertion2L(J,N)->stop ;
		     %testInsertion2DG(J,N)->stop ;
		     zbla(N)
		    ).

iADefensive(J,N) :- (testInsertion3C(J,N)->stop ; 
		     testInsertion3L(J,N)->stop ;
		     %testInsertion3DG(J,N)->stop ;
		     testInsertion2C(J,N)->stop ;
		     testInsertion2L(J,N)->stop ;
		     %testInsertion2DG(J,N)->stop ;
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

%% sinon iaAleatoire.


%% PION %%
findAllPion(J,L) :- findall([X,Y],pion(X,Y,J),L).
parcoursListePion([],J,N) :- false.



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
findAll3PathDiagGauche(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), decrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J), incrementeX(X1,X2),decrementeX(Y1,Y2), pion(X2,Y2,J)),L),write(L).
findAll2PathDiagGauche(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), decrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J)),L),write(L).


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
findAll3PathDiagDroite(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), incrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J), incrementeX(X1,X2),incrementeX(Y1,Y2), pion(X2,Y2,J)),L),write(L).
findAll2PathDiagDroite(J,L) :- findall([X,Y,X1,Y1],(pion(X,Y,J), incrementeX(Y,Y1),incrementeX(X,X1), pion(X1,Y1,J)),L),write(L).

parcoursListeDiagDroite([],J,N) :- false.
parcoursListeDiagDroite([[X1,Y1,X2,Y2]|Q],J,N) :- decrementeX(Xgauche, X1),
						  decrementeX(Ligne,L1),
						  (
						      not(pion(X1, Ligne,_)),pion(X1,L1,_),X1>0 -> N is X1 ;
						      tenteAjoutDiagDroite([[Ligne, Xgauche, Xdroite]|Q],J,N)
						  ). 
tenteAjoutDiagDroite([[X1,Y1,X2,Y2]|Q],J,N) :- incrementeX(Xdroite, X1),
					       decrementeX(Ligne,L1),
					       (
						   not(pion(X1, Ligne,_)),pion(X1,L1,_),X1<8 -> N is X1 ;
						   parcoursListeDiagDroite(Q,J,N)
 					       ).
  					 
