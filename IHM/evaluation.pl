% aléatoire vs offensive

eval1 :- initEval1,combatIAEval1.
initEval1 :- nb_setval('AVSO',0).

combatIAEval1 :- tourIA1Eval1.

testIA1Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,1) -> nb_getval('AVSO',X),incrementeX(X,X1),nb_setval('AVSO',X1),write('aleatoire');
		tourIA2Eval1
		).
		
testIA2Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> write('offensive');
		tourIA1Eval1
		).
		
tourIA1Eval1 :-	write('tour1'),
			ia(N),
			jouerCoup([N,1]),
			testIA1Eval1(N).
			
tourIA2Eval1 :-	write('tour2'),
			iAOffensive(2,M),
			jouerCoup([M,2]),
			testIA2Eval1(M).  


% aléatoire vs defensive

% aléatoire vs mixte

% aléatoire vs complète

% offensive vs defensive

% offensive vs mixte

% offensive vs complète

% defensive vs mixte

% defensive vs complète

% mixte vs complète
