initEval :- nb_setval('NBEval',500),
			nb_setval('NBEssaiReel',0).

calculPourcentage(PJ1,PJ2,NBJ1,NBJ2) :- nb_getval('NBEval',N),PJ1 is (100*NBJ1/N),PJ2 is (100*NBJ2/N).

printToEval(NBEssai,PJ1,PJ2) :- write('Nombre essai : '),writeln(NBEssai),write('J1 : '),write(PJ1),write('%       J2 : '),write(PJ2),writeln('%\n').

% #### Lancement de l'evaluation ####
lancerEval :- writeln('#### Aleatoire vs Offensive ####'),initEval,initEval1,eval1.
lancerEval :- pourcentage1.

lancerEval :- writeln('#### Aleatoire vs Defensive ####'),initEval,initEval2, eval2.
lancerEval :- pourcentage2.

lancerEval :- writeln('#### Offensive vs Defensive ####'),initEval,initEval5, eval5.
lancerEval :- pourcentage5.

% #### aléatoire vs offensive ####
eval1 :- nb_getval('NBEval',N),initEval1,between(1,N,I),combatIAEval1.

initEval1 :- nb_setval('AVSO1',0),nb_setval('AVSO2',0).

combatIAEval1 :- tourIA1Eval1.

testIA1Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSO1',X),incrementeX(X,X1),nb_setval('AVSO1',X1),testVidePlateau;
		tourIA2Eval1
		).
		
testIA2Eval1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSO2',X),incrementeX(X,X1),nb_setval('AVSO2',X1),testVidePlateau;
		tourIA1Eval1
		).
		
tourIA1Eval1 :-	ia(N),
		jouerCoup([N,1]),
		testIA1Eval1(N),!.
			
tourIA2Eval1 :-	iAOffensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval1(M),!.  
			
pourcentage1 :- nb_getval('AVSO1',NBJ1),nb_getval('AVSO2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).


% ####  aléatoire vs defensive  ####
eval2 :- nb_getval('NBEval',N),initEval2,between(1,N,I),combatIAEval2.

initEval2 :- nb_setval('AVSD1',0),nb_setval('AVSD2',0).

combatIAEval2 :- tourIA1Eval2.

testIA1Eval2(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSD1',X),incrementeX(X,X1),nb_setval('AVSD1',X1),testVidePlateau;
		tourIA2Eval2
		).
		
testIA2Eval2(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSD2',X),incrementeX(X,X1),nb_setval('AVSD2',X1),testVidePlateau;
		tourIA1Eval2
		).
		
tourIA1Eval2 :-	ia(N),
		jouerCoup([N,1]),
		testIA1Eval2(N),!.
			
tourIA2Eval2 :-	iADefensive(1,M),
		jouerCoup([M,2]),
		testIA2Eval2(M),!.  
			
pourcentage2 :- nb_getval('AVSD1',NBJ1),nb_getval('AVSD2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####  aléatoire vs mixte  ####

% ####  aléatoire vs complète  ####

% ####   offensive vs defensive ####
eval5 :- nb_getval('NBEval',N),initEval5,between(1,N,I),combatIAEval5.

initEval5 :- nb_setval('OVSD1',0),nb_setval('OVSD2',0).

combatIAEval5 :- tourIA1Eval5.

testIA1Eval5(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSD1',X),incrementeX(X,X1),nb_setval('OVSD1',X1),testVidePlateau;
		tourIA2Eval5
		).
		
testIA2Eval5(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSD2',X),incrementeX(X,X1),nb_setval('OVSD2',X1),testVidePlateau;
		tourIA1Eval5
		).
		
tourIA1Eval5 :-	iAOffensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval5(N),!.
			
tourIA2Eval5 :-	iADefensive(1,M),
		jouerCoup([M,2]),
		testIA2Eval5(M),!.  
			
pourcentage5 :- nb_getval('OVSD1',NBJ1),nb_getval('OVSD2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).


% ####  offensive vs mixte  ####

% ####  offensive vs complète  ####

% ####  defensive vs mixte  ####

% ####  defensive vs complète  ####

% ####  mixte vs complète  ####
