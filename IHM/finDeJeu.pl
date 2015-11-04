/* -------- Fin Jeu ------------*/
%% Predicat qui renvoit true sur le pion situé en X,Y fait 
%% gagné le joueur J
gagne(X,Y,J) :- victoireColonne(X,Y,J).
gagne(X,Y,J) :- victoireLigne(X,Y,J).
gagne(X,Y,J) :- victoireDiagGauche(X,Y,J).
gagne(X,Y,J) :- victoireDiagDroite(X,Y,J).



%% Predicat qui renvoit true sur le pion X,Y fait gagné
%% sur une colonne le joueur J
victoireColonne(X,Y,J) :- pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J), decrementeX(Y2,Y3), pion(X,Y3,J). %ligne en bas



%% Predicat qui renvoit true sur le pion X,Y fait gagné
%% sur une ligne le joueur J
victoireLigne(X,Y,J) :- verifieGauche(X,Y,J,Rg), verifieDroite(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

%% Unifie G avec le nombre de pion du joueur J à gauche du pion X,Y
verifieGauche(X,Y,J,G):- gauche(X,Y,J,0,G).
gauche(X,Y,J,R,R) :- not(pion(X,Y,J)). 
gauche(X,Y,J,R,G) :- decrementeX(X,X1), incrementeX(R,R1), gauche(X1,Y,J,R1,G).


%% Unifie G avec le nombre de pion du joueur J à droite du pion X,Y
verifieDroite(X,Y,J,D):- droite(X,Y,J,0,D).
droite(X,Y,J,R,R) :- not(pion(X,Y,J)). 
droite(X,Y,J,R,D) :- incrementeX(X,X1), incrementeX(R,R1), droite(X1,Y,J,R1,D).



%% Predicat qui renvoit true sur le pion X,Y fait gagné
%% sur une diagGauche le joueur J
victoireDiagGauche(X,Y,J) :- verifieGaucheHaut(X,Y,J,Rg), verifieDroiteBas(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

%% Unifie G avec le nombre de pion du joueur J en haut à gauche du pion X,Y
verifieGaucheHaut(X,Y,J,G):- gaucheHaut(X,Y,J,0,G).
gaucheHaut(X,Y,J,R,R) :- not(pion(X,Y,J)).
gaucheHaut(X,Y,J,R,G) :- incrementeX(Y,Y1), decrementeX(X,X1), incrementeX(R,R1), gaucheHaut(X1,Y1,J,R1,G).

%% Unifie G avec le nombre de pion du joueur J en bas à droite du pion X,Y
verifieDroiteBas(X,Y,J,D):- droiteBas(X,Y,J,0,D).
droiteBas(X,Y,J,R,R) :- not(pion(X,Y,J)). 
droiteBas(X,Y,J,R,D) :- decrementeX(Y,Y1), incrementeX(X,X1), incrementeX(R,R1), droiteBas(X1,Y1,J,R1,D).



%% Predicat qui renvoit true sur le pion X,Y fait gagné
%% sur une diagDroite le joueur J
victoireDiagDroite(X,Y,J) :- verifieGaucheBas(X,Y,J,Rg), verifieDroiteHaut(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

%% Unifie G avec le nombre de pion du joueur J en bas à gauche du pion X,Y
verifieGaucheBas(X,Y,J,G):- gaucheBas(X,Y,J,0,G).
gaucheBas(X,Y,J,R,R) :- not(pion(X,Y,J)). 
gaucheBas(X,Y,J,R,G) :- decrementeX(Y,Y1), decrementeX(X,X1), incrementeX(R,R1), gaucheBas(X1,Y1,J,R1,G).

%% Unifie G avec le nombre de pion du joueur J en haut à droite du pion X,Y
verifieDroiteHaut(X,Y,J,D):- droiteHaut(X,Y,J,0,D).
droiteHaut(X,Y,J,R,R) :- not(pion(X,Y,J)). 
droiteHaut(X,Y,J,R,D) :- incrementeX(Y,Y1), incrementeX(X,X1), incrementeX(R,R1), droiteHaut(X1,Y1,J,R1,D).
