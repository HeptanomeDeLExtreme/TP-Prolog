:- dynamic pion/3.
pion(-10,-10,-10).

pion(1,1,1).
pion(1,2,1).
pion(1,3,1).
pion(2,1,2).

% IA Fenouil Sec
% Recherche du coup le plus pertinent dans l'immédiat
% H4203 - Marion et Nico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% IA Fenouil Sec %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iaFS renvoie la colonne sur laquelle jouer
% elle accède à la grille de jeu courante (base de faits)


%%%%%%%%%%%%%%%%%%%% Prog principal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% peutGagner est vrai si ce pion entraine la victoire de nous
% (Le repeat est géré dans "peutGagner")
iaFS(Col) :- peutGagner(pion(Col,Li,2)), var(Col).

% peutPerdre est vrai si ce pion, de l'autre couleur,
% entraine la victoire adverse
iaFS(Col) :- peutPerdre(pion(Col,Li,2)), var(Col).

% peutRallongChemin est vrai si ce pion rallonge un chemin de nous
iaFS(Col) :- peutRallongChemin(pion(Col,Li,2)), var(Col).

% peutBloqChemin est vrai si ce pion, de l'autre couleur,
% rallonge un chemin adverse
iaFS(Col) :- peutBloqChemin(pion(Col,Li,2)), var(Col).

% coupAlea renvoie un coup aléatoire, si les 4 prédicats précédents sont faux
iaFS(Col) :- repeat, N is random(7),M is N+1, peutJouer(M),!.


%%%%%%%%%%%%%%%%%%%% Sous-prédicats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%retirerPion
retirerPion(Col) :- isolerColonne(Col, Colonne),indexDernierPion(Colonne, NumeroLigne), retract(pion(Col,NumeroLigne,_)).

%peutJouer est vrai si il est possible de jouer sur la col N (col non pleine)
peutJouer(N):- \+ pion(N, 6, _).

%peutGagner
peutGagner(pion(Col,Li,Joueur)) :- between(1,7,ColCour),jouerCoup([ColCour,Joueur]),isolerColonne(ColCour, Colonne),indexDernierPion(Colonne, NumeroLigne),(gagneTest(X,NumeroLigne,Joueur) -> Col=ColCour,retirerPion(Col),!;retirerPion(Col)),nonvar(Col).

%peutPerdre 
peutPerdre(pion(Col,Li,Joueur)) :- between(1,7,ColCour),JoueurAdvs is 3-Joueur,jouerCoup([ColCour,JoueurAdvs]),isolerColonne(ColCour, Colonne),indexDernierPion(Colonne, NumeroLigne),(gagneTest(X,NumeroLigne,JoueurAdvs) -> Col=ColCour,retirerPion(Col),!;retirerPion(Col)), nonvar(Col).

%peutRallongChemin 
peutRallongChemin :- 

incrementeX(X,X1):- X1 is X+1.
decrementeX(X,X1):- X1 is X-1.

gagneTest(X,Y,J) :- victoireColonne(X,Y,J).
gagneTest(X,Y,J) :- victoireLigne(X,Y,J).
gagneTest(X,Y,J) :- victoireDiagGauche(X,Y,J).
gagneTest(X,Y,J) :- victoireDiagDroite(X,Y,J).

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


indexDernierPion(Colonne, NumeroLigne) :-
	(Colonne = []-> NumeroLigne is 0;last(Colonne, pion(_, NumeroLigne, _))).



