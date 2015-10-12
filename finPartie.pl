%Code faux!!!!!!!!!!!!!!!!

pion(1,1,1).
pion(1,2,1).
pion(1,3,1).
dernPion(1,4,1).

pion(7,1,2).
pion(6,1,2).
pion(5,1,2).

finjeu :- length(findall(pion(_, 6, _)), 7), donnerResultat(chemin(_,_,0)).
finjeu :- suite, donnerResultat.

lienVertical(dernPion(I,J,X), pion(K,L,X)) :- J is L+1, I is K.
lienVertical(dernPion(I,J,X), pion(K,L,X)) :- J is L-1, I is K.

cheminVertical(dernPion(I,J,X), pion(K,L,X)) :- lienVertical(dernPion(I,J,X), pion(K,L,X)).
cheminVertical(dernPion(I,J,X), pion(K,L,X)) :- lienVertical(dernPion(I,J,X), pion(M,N,X)), cheminVertical(dernPion(M,N,X), pion(K,L,X)).

lienHorizontal(dernPion(I,J,X), pion(K,L,X)) :- I is K+1, J is L.
lienHorizontal(dernPion(I,J,X), pion(K,L,X)) :- I is K-1, J is L.

cheminHorizontal(dernPion(I,J,X), pion(K,L,X)) :- lienHorizontal(dernPion(I,J,X), pion(K,L,X)).
cheminHorizontal(dernPion(I,J,X), pion(K,L,X)) :- lienHorizontal(dernPion(I,J,X), pion(M,N,X)), cheminHorizontal(dernPion(M,N,X), pion(K,L,X)).

lienDiagDroite(dernPion(I,J,X), pion(K,L,X)) :- J is L+1, I is K+1.
lienDiagDroite(dernPion(I,J,X), pion(K,L,X)) :- J is L-1, I is K-1.

cheminDiagDroite(dernPion(I,J,X), pion(K,L,X)) :- lienDiagDroite(dernPion(I,J,X), pion(K,L,X)).
cheminDiagDroite(dernPion(I,J,X), pion(K,L,X)) :- lienDiagDroite(dernPion(I,J,X), pion(M,N,X)), cheminDiagDroite(dernPion(M,N,X), pion(K,L,X)).

lienDiagGauche(dernPion(I,J,X), pion(K,L,X)) :- J is L+1, I is K-1.
lienDiagGauche(dernPion(I,J,X), pion(K,L,X)) :- J is L-1, I is K+1.

cheminDiagGauche(dernPion(I,J,X), pion(K,L,X)) :- lienDiagGauche(dernPion(I,J,X), pion(K,L,X)).
cheminDiagGauche(dernPion(I,J,X), pion(K,L,X)) :- lienDiagGauche(dernPion(I,J,X), pion(M,N,X)), cheminDiagGauche(dernPion(M,N,X), pion(K,L,X)).

suite :- chercherChemin(Chemins), verifGagnant(Chemins).

chercherChemin(Chemins) :- setall(chemin(length(cheminVertical(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminVertical(dernPion(I,J,X), pion(K,L,X)), Chemins).
chercherChemin(Chemins) :- setall(chemin(length(cheminHorizontal(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminHorizontal(dernPion(I,J,X), pion(K,L,X)), Chemins).
chercherChemin(Chemins) :- setall(chemin(length(cheminDiagDroite(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminDiagDroite(dernPion(I,J,X), pion(K,L,X)), Chemins).
chercherChemin(Chemins) :- setall(chemin(length(cheminDiagGauche(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminDiagGauche(dernPion(I,J,X), pion(K,L,X)), Chemins).

verifGagnant(Chemins) :- ((first(Chemins(X,Y,Z)) = (_,_,4))-> donnerResultat(first(Chemins(X,Y,Z)));!).

%suite :- length(findall(cheminVertical(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
%suite :- length(findall(cheminHorizontal(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
%suite :- length(findall(cheminDiagDroite(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
%suite :- length(findall(cheminDiagGauche(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.

donnerResultat(chemin(X,Y,Z)) :- ((Z = 2)-> victoire; echec).

%findall(x,...,L)
%nth0(I, L+, E)
%length(v)
