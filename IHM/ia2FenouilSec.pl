:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl').

% IA Fenouil Sec
% Recherche du coup le plus pertinent dans l'immédiat
% H4203

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% IA Fenouil Sec %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iaFS renvoie la colonne sur laquelle jouer
% elle accède à la grille de jeu courante (base de faits)


%%%%%%%%%%%%%%%%%%%% Prog principal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zbla(N) :- ia(N).

stop :- true.


% peutGagner est vrai si ce pion entraine la victoire de nous
% (Le repeat est géré dans "peutGagner")
%iaFS(Col) :- peutGagner(pion(Col,Li,2)), var(Col).

% peutPerdre est vrai si ce pion, de l'autre couleur,
% entraine la victoire adverse
%iaFS(Col) :- peutPerdre(pion(Col,Li,2)), var(Col).

% tente de rallonger un de ses chemins de 2 si possible, puis de bloquer un chemin de 2 de l'adversaire, et idem avec les pions unitaires.
 
 iaFS(Col) :-(
 	     testInsertion2C(2,Col)->stop ;
 	     testInsertion2L(2,Col)->stop ;
 	     testInsertion2DG(2,Col)->stop ;
 	     testInsertion2C(1,Col)->stop ;
 	     testInsertion2L(1,Col)->stop ;
 	     testInsertion2DG(1,Col)->stop ;
 	     testInsertionPion(2,Col)->stop ;
 	     testInsertionPion(1,Col)->stop ;
 	     zbla(Col)).

%%%%%%%%%%%%%%%%%%%% Sous-prédicats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%retirerPion
retirerPion(Col) :- isolerColonne(Col, Colonne),indexDernierPion(Colonne, NumeroLigne), retract(pion(Col,NumeroLigne,_)).

%peutJouer est vrai si il est possible de jouer sur la col N (col non pleine)
peutJouer(N):- \+ pion(N, 6, 1).

%peutGagner
peutGagner(pion(Col,Li,Joueur)) :- between(1,7,ColCour),jouerCoup([ColCour,Joueur]),isolerColonne(ColCour, Colonne),indexDernierPion(Colonne, NumeroLigne),(gagneTest(X,NumeroLigne,Joueur) -> Col=ColCour,retirerPion(Col),!;retirerPion(Col)),nonvar(Col).

%peutPerdre 
peutPerdre(pion(Col,Li,Joueur)) :- between(1,7,ColCour),JoueurAdvs is 3-Joueur,jouerCoup([ColCour,JoueurAdvs]),isolerColonne(ColCour, Colonne),indexDernierPion(Colonne, NumeroLigne),(gagneTest(X,NumeroLigne,JoueurAdvs) -> Col=ColCour,retirerPion(Col),!;retirerPion(Col)), nonvar(Col).
