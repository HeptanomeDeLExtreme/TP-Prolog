:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl')

% IA Fenouil Sec
% Recherche du coup le plus pertinent dans l'immédiat
% H4203

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% IA Fenouil Sec %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iaFS renvoie la colonne sur laquelle jouer
% elle accède à la grille de jeu courante (base de faits)


%%%%%%%%%%%%%%%%%%%% Prog principal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zbla(N) :- ia(N).

% peutGagner est vrai si ce pion entraine la victoire de nous
% (Le repeat est géré dans "peutGagner")
iaFS(Col) :- peutGagner(pion(Col,Li,2)), var(Col).

% peutPerdre est vrai si ce pion, de l'autre couleur,
% entraine la victoire adverse
iaFS(Col) :- peutPerdre(pion(Col,Li,2)), var(Col).

% tente de rallonger un chemin à lui
% rajouter [stop :- true.] mais je sais pas où
iaFS(Col) :-(testInsertion3C(2,Col)->stop ; 
	     testInsertion3L(2,Col)->stop ;
	     testInsertion3DG(2,Col)->stop ;
	     testInsertion3C(1,Col)->stop ; 
	     testInsertion3L(1,Col)->stop ;
	     testInsertion3DG(1,Col)->stop ;
	     testInsertion2C(2,Col)->stop ;
	     testInsertion2L(2,Col)->stop ;
	     testInsertion2DG(2,Col)->stop ;
	     testInsertion2C(1,Col)->stop ;
	     testInsertion2L(1,N)->stop ;
	     testInsertion2DG(1,Col)->stop ;
	     testInsertionPion(2,Col)->stop ;
	     testInsertionPion(1,Col)->stop ;
	     zbla(Col)).

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
