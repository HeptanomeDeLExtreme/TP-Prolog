initEval :- nb_setval('NBEval',10).

calculPourcentage(PJ1,PJ2,NBJ1,NBJ2) :- nb_getval('NBEval',N),PJ1 is (100*NBJ1/N),PJ2 is (100*NBJ2/N).

% aléatoire vs offensive
eval1 :- nb_getval('NBEval',N),initEval1,between(1,N,I),combatIAEval1.

initEval1 :- nb_setval('AVSO1',0),nb_setval('AVSO2',0).

combatIAEval1 :- tourIA1Eval1.

testIA1Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,1) -> nb_getval('AVSO1',X),incrementeX(X,X1),nb_setval('AVSO1',X1),write('aleatoire'),viderPlateau;
		tourIA2Eval1
		).
		
testIA2Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('AVSO2',X),incrementeX(X,X1),nb_setval('AVSO2',X1),write('offensive'),viderPlateau;
		tourIA1Eval1
		).
		
tourIA1Eval1 :-	write('tour1'),
			ia(N),
			jouerCoup([N,1]),
			testIA1Eval1(N),!.
			
tourIA2Eval1 :-	write('tour2'),
			iAOffensive(2,M),
			jouerCoup([M,2]),
			testIA2Eval1(M),!.  
			
pourcentage :- nb_getval('AVSO1',NBJ1),nb_getval('AVSO2',NBJ2),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),write(PJ1),write(' '),write(PJ2).


% aléatoire vs defensive

% aléatoire vs mixte

% aléatoire vs complète

% offensive vs defensive

% offensive vs mixte

% offensive vs complète

% defensive vs mixte

% defensive vs complète

% mixte vs complète
