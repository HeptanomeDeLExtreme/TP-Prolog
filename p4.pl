
% Code principal du projet ALIA
% Hexanome H4203
% Octobre 2015



% Un fait plateau, initialisé à un plateau vide
% Init manuelle pour pouvoir jouer des cas particuliers si besoin 
plateau(X=([0,0,0,0,0,0],
	   [0,0,0,0,0,0],
	   [0,0,0,0,0,0],
 	   [0,0,0,0,0,0],
	   [0,0,0,0,0,0],
	   [0,0,0,0,0,0],
	   [0,0,0,0,0,0])).

% Le jeu continue tant qu'il n'est pas fini (un gagnant ou plateau plein)
jouer :- finjeu, !.

% Déroulement principal
jouer :- plateau(X),
	 afficher(X),
	 ia(X,N),
	 jouerCoup(X,Xnouv,N),
	 jouerEnMem(X,Xnouv),
	 jouer,
	 retract(plateau(X)),
	 assert(plateau(Xnouv)).


