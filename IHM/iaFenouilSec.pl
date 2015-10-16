
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
iaFS(Col) :- peutGagner(pion(Col,Li,Joueur)), var(Col).

% peutPerdre est vrai si ce pion, de l'autre couleur,
% entraine la victoire adverse
iaFS(Col) :- peutPerdre(pion(Col,Li,Joueur)), var(Col).

% peutRallongChemin est vrai si ce pion rallonge un chemin de nous
iaFS(Col) :- peutRallongChemin(pion(Col,Li,Joueur)), var(Col).

% peutBloqChemin est vrai si ce pion, de l'autre couleur,
% rallonge un chemin adverse
iaFS(Col) :- peutBloqChemin(pion(Col,Li,Joueur)), var(Col).

% coupAlea renvoie un coup aléatoire, si les 4 prédicats précédents sont faux
iaFS(Col) :- repeat, N is random(7),M is N+1, peutJouer(M),!.


%%%%%%%%%%%%%%%%%%%% Sous-prédicats %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%peutJouer est vrai si il est possible de jouer sur la col N (col non pleine)
peutJouer(N):- \+ pion(N, 6, _).

%peutGagner
peutGagner(pion(Col,Li,Joueur)) :- between(1,7,ColCour),jouerCoup([ColCour,Joueur]),(gagne(X,Y,Joueur) -> Col=ColCour,retirerPion(Col);retirerPion(Col)).

%peutPerdre
