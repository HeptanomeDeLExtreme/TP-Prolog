% Le jeu continue tant qu'il n'est pas fini (un gagnant ou plateau plein)
%%jouer :- finPartie, !.

caribou :- 		%%testFinJeu,!, 
		ia(N),
		jouerCoup([N,2]).
		%%finjeu,!.

/* ----------- IHM ----------- */
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F),jpl_call('main',init,[F],_).

%% Predicat pour faire le coup d'un joueur
coupJoueur(X,Y,Z) :- ajouterPion(X,Y,Z),caribou. %% lastPion

%% Predicat a appeler lorsqu'on veut rafraichir le plateau
print :- nb_getval('FENETRE',F),jpl_call( F, print, [], _).

%% Predicat a appeler en cas de victoire 
victoire :- jpl_call( 'main', victoire, [], _).

%% Predicat a appeler en cas d'echec
echec :- jpl_call( 'main', echec, [], _).

isolerColonneIJoueurX(I,X, Colonne) :- findall(pion(I, Y, X), pion(I, Y, X), Colonne).
    
cheminColonne(I,X) :- isolerColonneIJoueurX(I,X, Colonne),length(Colonne,T),write(T),( T == 4 -> victoire;echec). 

testFinJeu :- cheminColonne(1,1).


/* ----------- Ophelie et Cedric ----------- */
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

indexDernierPion(Colonne, NumeroLigne) :-
	(Colonne = []-> NumeroLigne is 0;last(Colonne, pion(_, NumeroLigne, _))).
    
calculProchaineCase(NumeroLigne, NumeroLigneSuivant) :-
    NumeroLigneSuivant is NumeroLigne + 1.
    
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)),
    retract(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :- assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    
jouerCoup([NumeroColonne, Joueur]) :-
    isolerColonne(NumeroColonne, Colonne),
    
    indexDernierPion(Colonne, NumeroLigne),

    calculProchaineCase(NumeroLigne, NumeroLigneSuivant),
    
    ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    

/* ----------- IA ----------- */
ia(M):- repeat, N is random(7),M is N+1, peutJouer(M),!.
peutJouer(N):- \+ pion(N, 6, _).

/* ----------- MARION ----------- */
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

chercherChemin(Chemins) :- findall(chemin(length(cheminVertical(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminVertical(dernPion(I,J,X), pion(K,L,X)), Chemins),
findall(chemin(length(cheminHorizontal(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminHorizontal(dernPion(I,J,X), pion(K,L,X)), Chemins),
findall(chemin(length(cheminDiagDroite(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminDiagDroite(dernPion(I,J,X), pion(K,L,X)), Chemins),
findall(chemin(length(cheminDiagGauche(dernPion(I,J,X), pion(K,L,X)), Y), X, Y), cheminDiagGauche(dernPion(I,J,X), pion(K,L,X)), Chemins).

verifGagnant(Chemins) :- sort(2, @<, Chemins, X), ((last(X) = chemin(_,_,4))-> donnerResultat(last(X));!).

%suite :- length(findall(cheminVertical(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
%suite :- length(findall(cheminHorizontal(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
%suite :- length(findall(cheminDiagDroite(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.
%suite :- length(findall(cheminDiagGauche(dernPion(I,J,X), pion(K,L,X))), 4), Resultat=X.

donnerResultat(chemin(_,_,Z)) :- ((Z = 2)-> victoire; echec).

%findall(x,...,L)
%nth0(I, L+, E)
%length(v)
