
%Pion qui pèse
pion(-10,-10,-10).

%Pions de test
pion(1,1,1).
pion(1,2,1).
pion(1,3,1).
pion(2,1,2).

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