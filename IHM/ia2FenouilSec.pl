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

% peutGagner est vrai si ce pion entraine la victoire de nous
% (Le repeat est géré dans "peutGagner")
iaFS(J,Col) :- peutGagner(Col,J).

% peutPerdre est vrai si ce pion, de l'autre couleur, 
% entraine la victoire adverse
iaFS(J,Col) :- peutPerdre(Col,J).

% Partie 2 de l'IA, si on ne peut ni gagner ni empêcher l'autre de gagner au
% tour suivant 
% Tente de rallonger un de ses chemins de 2 si possible, puis de bloquer un
% chemin de 2 de l'adversaire, et idem avec les pions unitaires. 
iaFS(J,Col) :- (
 		  testInsertion2C(J,Col)->stop ;
 		  testInsertion2L(J,Col)->stop ;
 		  testInsertion2DG(J,Col)->stop ;
		  testInsertion2DD(J,Col)->stop ;
 		  testInsertion2C(3-J,Col)->stop ;
 		  testInsertion2L(3-J,Col)->stop ;
 		  testInsertion2DG(3-J,Col)->stop ;
		  testInsertion2DD(3-J,Col)->stop ;
 		  testInsertionPion(J,Col)->stop ;
 		  testInsertionPion(3-J,Col)->stop ;
 		  zbla(Col)).


%%%%%%%%%%%%%%%%%%%% Sous-prédicats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%retirerPion
retirerPion(Col) :- isolerColonne(Col, Colonne),
		    indexDernierPion(Colonne, NumeroLigne),
		    retract(pion(Col,NumeroLigne,_)).

%peutJouer est vrai si il est possible de jouer sur la col N (col non pleine)
peutJouer(N):- \+ pion(N, 6, 1).

%peutGagner
%% peutGagner(pion(Col,Li,Joueur)) :- between(1,7,ColCour),
%% 				   jouerCoup([ColCour,Joueur]),
%% 				   isolerColonne(ColCour, PionsPrsnt),
%% 				   indexDernierPion(PionsPrsnt, NumeroLigne),
%% 				   (gagne(PionsPrsnt,NumeroLigne,Joueur) ->
%% 					Col is ColCour,retirerPion(Col),stop,!
%% 				    ;retirerPion(Col),nostop).

%Tentative bas de gamme de récursivité
%% peutGagner(pion(Col,Li,Joueur)) :- jouerCoup([ColCour,Joueur]),
%%    				   isolerColonne(ColCour, PionsPrsnt),
%% 				   indexDernierPion(PionsPrsnt, NumeroLigne),
%% 				   gagne(PionsPrsnt,NumeroLigne,Joueur),
%% 				   Col is ColCour,
%% 				   retirerPion(Col),
%% 				   nostop.
%% peutGagner(pion(Col,Li,Joueur)) :- peutGagner(pion((Col is Col+1),Li,Joueur)).


%Tentative de folie
%% peutGagner(Col,J) :- between(1,7,Col),
%%                      jouerCoup([Col,J]),
%% 		     isolerColonne(Col, PionsPrsnt),
%%  		     indexDernierPion(PionsPrsnt, Li),
%% 		     (
%% 			 gagne(Col,Li,J) ->retirerPion(Col), stop;
%% 			 retirerPion(Col)
%% 		     ).


% Code qui marche et qui casse des culs
peutGagnerSurCol(Col) :- jouerCoup([Col,1]),
	    isolerColonne(Col,P),
	    indexDernierPion(P,L),
	    (gagne(Col,L,1) -> retirerPion(Col) ;
            retirerPion(Col),!,false).

heyJpeuxGagner(Col,J) :- peutGagnerSurCol(1), Col is 1.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(2), Col is 2.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(3), Col is 3.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(4), Col is 4.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(5), Col is 5.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(6), Col is 6.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(7), Col is 7.

peutGagner(Col,J) :- heyJpeuxGagner(Col,J),!.
peutPerdre(Col,J) :- heyJpeuxGagner(Col,3-J),!.
