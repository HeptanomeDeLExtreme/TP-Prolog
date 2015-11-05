%% Unifie P avec le poids de la situation actuelle pour le joueur J
evaluePosition(J,P) :- J1 is 3-J,
						( aCheminDe4(J) -> P is 10000;
						 aCheminDe4(J1) -> P is -10000;
						 aCheminDe3(J),not(aCheminDe3(J1)) -> P is 1000;
						 aCheminDe3(J1), not(aCheminDe3(J)) -> P is -1000;
						 aCheminDe3(J),aCheminDe3(J1) -> P is 100;
						 aCheminDe2(J),not(aCheminDe2(J1)) -> P is 100;
						 aCheminDe2(J1), not(aCheminDe2(J)) -> P is -100;
						 aCheminDe2(J),aCheminDe2(J1) -> P is 10;
						 P is 0
						).

%% Renvoit true si le joueur J possede au moins une chemin de 4
aCheminDe4(J) :- findAll4PathColonne(J,L), not(L = []),!;
				findAll4PathLigne(J,L),not(L = [] ),!;
				findAll4PathDiagGauche(J,L),not(L = []),!;
				findAll4PathDiagDroite(J,L),not(L = []),!.
				
%% Renvoit true si le joueur J possede au moins une chemin de 3
aCheminDe3(J) :- findAll3PathColonne(J,L), not(L = []),!;
				findAll3PathLigne(J,L),not(L = [] ),!;
				findAll3PathDiagGauche(J,L),not(L = []),!;
				findAll3PathDiagDroite(J,L),not(L = []),!.

%% Renvoit true si le joueur J possede au moins une chemin de 2
aCheminDe2(J) :- findAll2PathColonne(J,L), not(L = []),!;
				findAll2PathLigne(J,L),not(L = [] ),!;
				findAll2PathDiagGauche(J,L),not(L = []),!;
				findAll2PathDiagDroite(J,L),not(L = []),!.

%% Trouve tout les chemins de 4 en colonne pour le joueur J
%% unifie la liste L avec la liste des chemins
findAll4PathColonne(J,L) :- findall([X,Y],(pion(X,Y,J), decrementeX(Y,Y1), pion(X,Y1,J), decrementeX(Y1,Y2), pion(X,Y2,J),decrementeX(Y2,Y3),pion(X,Y3,J)),L).

%% Trouve tout les chemins de 4 en ligne
%% Unifie L à la liste des chemins
findAll4PathLigne(J,L) :- findall([Y,X3,X],(pion(X,Y,J), decrementeX(X,X1), pion(X1,Y,J), decrementeX(X1,X2), pion(X2,Y,J),decrementeX(X2,X3),pion(X3,Y,J)),L).

%% Trouve tout les chemins de 4 en diagGauche pour le joueur J
%% Unifie L à la liste des chemins
findAll4PathDiagGauche(J,L) :- findall([X2,Y2,X,Y],(pion(X,Y,J), decrementeX(X,X1),incrementeX(Y,Y1), pion(X1,Y1,J), incrementeX(Y1,Y2),decrementeX(X1,X2), pion(X2,Y2,J),incrementeX(Y2,Y3),decrementeX(X2,X3),pion(X3,Y3,J)),L).

%% Trouve tout les chemins de 4 en diagDroite pour le joueur J
%% Unifie L à la liste des chemins
findAll4PathDiagDroite(J,L) :- findall([X,Y,X2,Y2],(pion(X,Y,J), doubleInc(X,Y,X1,Y1), pion(X1,Y1,J),doubleInc(X1,Y1,X2,Y2), pion(X2,Y2,J),doubleInc(X2,Y2,X3,Y3),pion(X3,Y3,J)),L).
