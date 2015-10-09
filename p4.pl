
% Code principal du projet ALIA
% Hexanome H4203
% Octobre 2015



% On fait un plateau à base de cellules (cell)
%TODO ajouter le jeu de base, initialiser ni nécessaire

% Le jeu continue tant qu'il n'est pas fini (un gagnant ou plateau plein)
jouer :- finPartie, !.

% Déroulement principal
jouer :- plateau(X),
	 afficher(X),
	 ia(X,N),
	 jouerCoup(X,Xnouv,N),
	 jouerMemoire(X,Xnouv),
	 jouer,
	 retract(plateau(X)),
	 assert(plateau(Xnouv)).


