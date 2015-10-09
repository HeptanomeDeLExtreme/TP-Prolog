pion(1,1,1).
pion(1,2,1).
pion(1,3,1).
dernPion(1,4,1).

pion(7,1,2).
pion(6,1,2).
pion(5,1,2).

finjeu :- length(findall(pion(_, 6, _)), 7) , Resultat=0, donnerResultat.
finjeu :- suite, donnerResultat.

lienVetical(pion(I,J,X), pion(K,L,X)) :- J=L+1, I=K.
lienVetical(pion(I,J,X), pion(K,L,X)) :- J=L-1, I=K.

cheminVertical(pion(I,J,X), pion(K,L,X)) :- lienVetical(pion(I,J,X), pion(K,L,X)).
cheminVertical(pion(I,J,X), pion(K,L,X)) :- lienVetical(pion(I,J,X), pion(M,N,X)), cheminVertical(pion(M,N,X), pion(K,L,X)).

lienHorizontal(pion(I,J,X), pion(K,L,X)) :- I=K+1, J=L.
lienHorizontal(pion(I,J,X), pion(K,L,X)) :- I=K-1, J=L.

cheminHorizontal(pion(I,J,X), pion(K,L,X)) :- lienHorizontal(pion(I,J,X), pion(K,L,X)).
cheminHorizontal(pion(I,J,X), pion(K,L,X)) :- lienHorizontal(pion(I,J,X), pion(M,N,X)), cheminHorizontal(pion(M,N,X), pion(K,L,X)).

lienDiagDroite(pion(I,J,X), pion(K,L,X)) :- J=L+1, I=K+1.
lienDiagDroite(pion(I,J,X), pion(K,L,X)) :- J=L-1, I=K-1.

cheminDiagDroite(pion(I,J,X), pion(K,L,X)) :- lienDiagDroite(pion(I,J,X), pion(K,L,X)).
cheminDiagDroite(pion(I,J,X), pion(K,L,X)) :- lienDiagDroite(pion(I,J,X), pion(M,N,X)), cheminDiagDroite(pion(M,N,X), pion(K,L,X)).

lienDiagGauche(pion(I,J,X), pion(K,L,X)) :- J=L+1, I=K-1.
lienDiagGauche(pion(I,J,X), pion(K,L,X)) :- J=L-1, I=K+1.

cheminDiagGauche(pion(I,J,X), pion(K,L,X)) :- lienDiagGauche(pion(I,J,X), pion(K,L,X)).
cheminDiagGauche(pion(I,J,X), pion(K,L,X)) :- lienDiagGauche(pion(I,J,X), pion(M,N,X)), cheminDiagGauche(pion(M,N,X), pion(K,L,X)).

suite :- length(findall(cheminVertical(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
suite :- length(findall(cheminHorizontal(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
suite :- length(findall(cheminDiagDroite(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
suite :- length(findall(cheminDiagGauche(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.

donnerResultat :- not(Resultat==0), write('Felicitation joueur '), write(Resultat), write(', vous avez gagne!').
donnerResultat :- write('Match nul :(').
