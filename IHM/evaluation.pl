initEval :- nb_setval('NBEval',50),nb_setval('NBEssaiReel',0).

calculPourcentage(PJ1,PJ2,NBJ1,NBJ2) :- nb_getval('NBEval',N),PJ1 is (100*NBJ1/N),PJ2 is (100*NBJ2/N).

incrementeVar(nom) :- nb_getval(nom,X),incrementeX(X,X1),nb_setval(nom,X1).

% Le prédicat pour vider le plateau a été mis dans util.pl

% aléatoire vs offensive
eval1 :- nb_getval('NBEval',N),initEval1,between(1,N,I),combatIAEval1.

initEval1 :- nb_setval('AVSO1',0),nb_setval('AVSO2',0).

combatIAEval1 :- tourIA1Eval1.

testIA1Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSO1',X),incrementeX(X,X1),nb_setval('AVSO1',X1),write('Aleatoire'),testVidePlateau;
		tourIA2Eval1
		).
		
testIA2Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSO2',X),incrementeX(X,X1),nb_setval('AVSO2',X1),write('Offensive'),testVidePlateau;
		tourIA1Eval1
		).
		
tourIA1Eval1 :-	ia(N),
		write(N),
		writeln('tour 1'),
		jouerCoup([N,1]),
		testIA1Eval1(N),!.
			
tourIA2Eval1 :-	iAOffensive(2,M),
		write(M),
		writeln('tour 2'),
		jouerCoup([M,2]),
		testIA2Eval1(M),!.  
			
pourcentage :- nb_getval('AVSO1',NBJ1),nb_getval('AVSO2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),write('Nombre essai : '),writeln(NBEssai),write(PJ1),write(' '),write(PJ2).


% aléatoire vs defensive

% aléatoire vs mixte

% aléatoire vs complète

% offensive vs defensive

% offensive vs mixte

% offensive vs complète

% defensive vs mixte

% defensive vs complète

% mixte vs complète
