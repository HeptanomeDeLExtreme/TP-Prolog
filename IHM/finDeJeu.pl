/* -------- Fin Jeu ------------*/
caseVide(X,Y) :- nonvar(X),nonvar(Y),not(pion(X,Y,_)). 

gagne(X,Y,J) :- victoireColonne(X,Y,J).%,jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- victoireLigne(X,Y,J).%,jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- victoireDiagGauche(X,Y,J).%,jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- victoireDiagDroite(X,Y,J).%,jpl_call('main',debug,['GAGNE'],_).

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
