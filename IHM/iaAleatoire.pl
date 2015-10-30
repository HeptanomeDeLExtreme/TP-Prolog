/* IA aleatoire */

ia(M):- repeat, N is random(7),M is N+1, peutJouer(M),!.

peutJouer(N):- \+ pion(N, 6, _).
