/* ----------- IA Mixte ----------- */


% peutGagner est vrai si ce pion entraine la victoire du joueur J
% Unifie Col à la colonne sur laquelle jouer
iaMixte(J,Col) :- peutGagner(Col,J).

% peutPerdre est vrai si ce pion, de l'autre couleur, 
% entraine la victoire adverse
iaMixte(J,Col) :- peutPerdre(Col,J).

% Partie 2 de l'IA, si on ne peut ni gagner ni empêcher l'autre de gagner 
% au tour suivant 
% Tente de bloquer un chemin adverse de taille 2 si possible, puis de
%  rallonger ses propres chemins, et répete le même procédé pour les
% pions unitaires
iaMixte(J,Col) :- J1 is 3-J,(
 		  testInsertion2C(J1,Col)->stop ;
 		  testInsertion2L(J1,Col)->stop ;
 		  testInsertion2DG(J1,Col)->stop ;
		  testInsertion2DD(J1,Col)->stop ;
 		  testInsertion2C(J,Col)->stop ;
 		  testInsertion2L(J,Col)->stop ;
 		  testInsertion2DG(J,Col)->stop ;
		  testInsertion2DD(J,Col)->stop ;
		  testInsertionPion(J1,Col)->stop ;
 		  testInsertionPion(J,Col)->stop ;
 		  ia(Col)).


% Retire le dernier pion de la colonne Col
retirerPion(Col) :- isolerColonne(Col, Colonne),
		    indexDernierPion(Colonne, NumeroLigne),
		    retract(pion(Col,NumeroLigne,_)).

% Predicat qui renvoit true si on peut gagner sur la colonne Col
peutGagnerSurCol(Col, J) :- jouerCoup([Col,J]),
	    isolerColonne(Col,P),
	    indexDernierPion(P,L),
	    (gagne(Col,L,J) -> retirerPion(Col) ;
            retirerPion(Col),!,false).

% Predicat qui renvoit true si le joueur J peut gagner sur la colonne Col 
checkVictoireColonne(Col,J) :- peutGagnerSurCol(1, J), Col is 1.
checkVictoireColonne(Col,J) :- peutGagnerSurCol(2, J), Col is 2.
checkVictoireColonne(Col,J) :- peutGagnerSurCol(3, J), Col is 3.
checkVictoireColonne(Col,J) :- peutGagnerSurCol(4, J), Col is 4.
checkVictoireColonne(Col,J) :- peutGagnerSurCol(5, J), Col is 5.
checkVictoireColonne(Col,J) :- peutGagnerSurCol(6, J), Col is 6.
checkVictoireColonne(Col,J) :- peutGagnerSurCol(7, J), Col is 7.

% Predicat qui unifie Col avec la colonne qui fait gagner le joueur J
peutGagner(Col,J) :- checkVictoireColonne(Col,J),!.

% Predicat qui unifie Col avec la colonne qui fait perdre le joueur J
peutPerdre(Col,J) :- J1 is 3-J,checkVictoireColonne(Col,J1),!.
