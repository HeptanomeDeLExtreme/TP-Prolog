/* ----------- IHM ----------- */
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F),jpl_call('main',init,[F],_).

coupJoueur(X,Y,Z) :- ajouterPion(X,Y,Z),
					(gagne(X,Y,Z)-> echec;coupIA).
coupIA :- ia(N),
		jouerCoup([N,2]).
		%%testIA(N).
		
testIA(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		gagne(N,NumeroLigne,2).
		
finTour :- jpl_call('main',debug,['finTour'],_).

debug(S) :- jpl_call('main',debug,[S],_).

%% Predicat a appeler lorsqu'on veut rafraichir le plateau
print :- nb_getval('FENETRE',F),jpl_call( F, print, [], _).

%% Predicat a appeler en cas de victoire 
victoire :- jpl_call( 'main', victoire, [], _).

%% Predicat a appeler en cas d'echec
echec :- jpl_call( 'main', echec, [], _).

isolerColonneIJoueurX(I,X, Colonne) :- findall(pion(I, Y, X), pion(I, Y, X), Colonne).
    
cheminColonne(I,X) :- isolerColonneIJoueurX(I,X, Colonne),length(Colonne,T),write(T),( T == 4 -> victoire;echec). 

/* -------- Fin Jeu ------------*/
incr(X,X1):- X1 is X+1.
decr(X,X1):- X1 is X-1.
caseVide(X,Y) :- nonvar(X),nonvar(Y),not(case(X,Y,_)).

gagne(X,Y,J) :- gagneColonne(X,Y,J),jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- gagneLigne(X,Y,J),jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- gagneDiag1(X,Y,J),jpl_call('main',debug,['GAGNE'],_).
gagne(X,Y,J) :- gagneDiag2(X,Y,J),jpl_call('main',debug,['GAGNE'],_).

%%% Colonne %%%
gagneColonne(X,Y,J) :- pion(X,Y,J), decr(Y,Y1), pion(X,Y1,J), decr(Y1,Y2), pion(X,Y2,J), decr(Y2,Y3), pion(X,Y3,J). %ligne en bas

%%% Ligne %%%
gagneLigne(X,Y,J) :- gaucheVerif(X,Y,J,Rg), droiteVerif(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

gaucheVerif(X,Y,J,Rg):- gauche(X,Y,J,0,Rg).
gauche(X,Y,J,R,R) :- not(pion(X,Y,J)). %Jusqu'à la pion non J
gauche(X,Y,J,R,Rg) :- decr(X,X1), incr(R,R1), gauche(X1,Y,J,R1,Rg).

droiteVerif(X,Y,J,Rg):- droite(X,Y,J,0,Rg).
droite(X,Y,J,R,R) :- not(pion(X,Y,J)). %Jusqu'à la pion non J
droite(X,Y,J,R,Rg) :- incr(X,X1), incr(R,R1), droite(X1,Y,J,R1,Rg).

%%% Diagonale \ %%%
gagneDiag1(X,Y,J) :- gaucheHautVerif(X,Y,J,Rg), droiteBasVerif(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

gaucheHautVerif(X,Y,J,Rg):- gaucheHaut(X,Y,J,0,Rg).
gaucheHaut(X,Y,J,R,R) :- not(pion(X,Y,J)). %Jusqu'au pion non J
gaucheHaut(X,Y,J,R,Rg) :- incr(Y,Y1), decr(X,X1), incr(R,R1), gaucheHaut(X1,Y1,J,R1,Rg).

droiteBasVerif(X,Y,J,Rg):- droiteBas(X,Y,J,0,Rg).
droiteBas(X,Y,J,R,R) :- not(pion(X,Y,J)). %Jusqu'au pion non J
droiteBas(X,Y,J,R,Rg) :- decr(Y,Y1), incr(X,X1), incr(R,R1), droiteBas(X1,Y1,J,R1,Rg).

%%% Diagonale / %%%
gagneDiag2(X,Y,J) :- gaucheBasVerif(X,Y,J,Rg), droiteHautVerif(X,Y,J,Rd),!, Rf is Rg+Rd, Rf>4.

gaucheBasVerif(X,Y,J,Rg):- gaucheBas(X,Y,J,0,Rg).
gaucheBas(X,Y,J,R,R) :- not(pion(X,Y,J)). %Jusqu'au pion non J
gaucheBas(X,Y,J,R,Rg) :- decr(Y,Y1), decr(X,X1), incr(R,R1), gaucheBas(X1,Y1,J,R1,Rg).

droiteHautVerif(X,Y,J,Rg):- droiteHaut(X,Y,J,0,Rg).
droiteHaut(X,Y,J,R,R) :- not(pion(X,Y,J)). %Jusqu'au pion non J
droiteHaut(X,Y,J,R,Rg) :- incr(Y,Y1), incr(X,X1), incr(R,R1), droiteHaut(X1,Y1,J,R1,Rg).

/* ----------- Ophelie et Cedric ----------- */
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

indexDernierPion(Colonne, NumeroLigne) :-
	(Colonne = []-> NumeroLigne is 0;last(Colonne, pion(_, NumeroLigne, _))).
    
calculProchainepion(NumeroLigne, NumeroLigneSuivant) :-
    NumeroLigneSuivant is NumeroLigne + 1.
    
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)),
    retract(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :- assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    
jouerCoup([NumeroColonne, Joueur]) :-
    isolerColonne(NumeroColonne, Colonne),
    
    indexDernierPion(Colonne, NumeroLigne),

    calculProchainepion(NumeroLigne, NumeroLigneSuivant),
    
    ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    

/* ----------- IA ----------- */
ia(M):- repeat, N is random(7),M is N+1, peutJouer(M),!.
peutJouer(N):- \+ pion(N, 6, _).

