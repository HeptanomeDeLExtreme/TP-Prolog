/* IA aleatoire */

%% Unifie M à une valeur aleatoire sur laquelle jouer
ia(M):- repeat, N is random(7),M is N+1, peutJouer(M),!.

%% True si on peut joueur sur la conne N
peutJouer(N):- \+ pion(N, 6, _).
