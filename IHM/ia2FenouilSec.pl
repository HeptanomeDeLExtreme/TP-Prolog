% peutGagner est vrai si ce pion entraine la victoire du joueur J
% Unifie Col à la colonne sur laquelle jouer
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
 		  ia(Col)).


%%%%%%%%%%%%%%%%%%%% Sous-prédicats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Retire le dernier pion de la colonne Col
retirerPion(Col) :- isolerColonne(Col, Colonne),
		    indexDernierPion(Colonne, NumeroLigne),
		    retract(pion(Col,NumeroLigne,_)).

% Predicat qui renvoit true si on peut gagner sur la colonne Col
peutGagnerSurCol(Col) :- jouerCoup([Col,1]),
	    isolerColonne(Col,P),
	    indexDernierPion(P,L),
	    (gagne(Col,L,1) -> retirerPion(Col) ;
            retirerPion(Col),!,false).

% Predicat qui renvoit true si le joueur J peut gagner sur la colonne Col 
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(1), Col is 1.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(2), Col is 2.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(3), Col is 3.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(4), Col is 4.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(5), Col is 5.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(6), Col is 6.
heyJpeuxGagner(Col,J) :- peutGagnerSurCol(7), Col is 7.

% Predicat qui unifie Col avec la colonne qui fait gagner le joueur J
peutGagner(Col,J) :- heyJpeuxGagner(Col,J),!.

% Predicat qui unifie Col avec la colonne qui fait perdre le joueur J
peutPerdre(Col,J) :- heyJpeuxGagner(Col,3-J),!.
