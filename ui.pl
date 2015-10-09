/* pion(colonne,ligne,joueur) */
pion(1,1,1).
pion(2,1,2).
pion(3,1,1).
pion(4,1,1).
%%pion(5,1,1).
pion(6,1,1).
pion(7,1,1).

/*
afficher 6eme ligne 
afficher 5eme ligne 
afficher 4eme ligne 
afficher 3eme ligne 
afficher 2eme ligne 
afficher 1eme ligne 
*/

afficheJeu :- afficheLigne(6),afficheLigne(5),afficheLigne(4),afficheLigne(3),afficheLigne(2),afficheLigne(1).

afficheLigne(N) :- findall([X,Y],pion(X,N,Y),L),between(1,7,I),nth1(I,L,[A,B]),(var(pion(A,B,N))-> write(B); write(' ') ).

nth1(I,L,[A,B]),(B=1 -> write('rouge');write('bleu')).
