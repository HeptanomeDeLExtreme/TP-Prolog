/* ----------- Evaluation ----------- */

:- use_module(library(statistics)).

initEval :- nb_setval('NBEval',300),
			nb_setval('NBEssaiReel',0).

calculPourcentage(PJ1,PJ2,NBJ1,NBJ2) :- nb_getval('NBEval',N),PJ1 is (100*NBJ1/N),PJ2 is (100*NBJ2/N).
moyenneTemps :- nb_getval('timeTable',L),average_easy(L,M),write('Temps moyen d\'execution : '),write(M),writeln(' secondes').

average_easy( List, Avg ) :-
    sum_( List, Sum ),
    length_( List, Length ),
    Avg is Sum / Length.

sum_( [], 0 ).
sum_( [H|T], Sum ) :-
    sum_( T, Temp ),
    Sum is Temp + H.

length_( [], 0 ).
length_( [_|B], L ):-
    length_( B, Ln ),
    L is Ln+1.

printToEval(NBEssai,PJ1,PJ2) :- write('Nombre essai : '),writeln(NBEssai),write('J1 : '),write(PJ1),write('%       J2 : '),write(PJ2),writeln('%\n').

% #### Lancement de l'evaluation ####
lancerEval :- writeln('#### Aleatoire vs Offensive (1) ####'),initEval,initEval1,eval1.
lancerEval :- moyenneTemps,pourcentage1.

lancerEval :- writeln('#### Offensive vs Aleatoire (1b) ####'),initEval,initEval1b,eval1b.
lancerEval :- moyenneTemps,pourcentage1b.

lancerEval :- writeln('#### Aleatoire vs Defensive (2) ####'),initEval,initEval2, eval2.
lancerEval :- pourcentage2.

lancerEval :- writeln('#### Defensive vs Aleatoire (2b) ####'),initEval,initEval2b, eval2b.
lancerEval :- moyenneTemps,pourcentage2b.

lancerEval :- writeln('#### Aleatoire vs Mixte (3) ####'),initEval,initEval3, eval3.
lancerEval :- pourcentage3.

lancerEval :- writeln('#### Mixte vs Aleatoire (3b) ####'),initEval,initEval3b, eval3b.
lancerEval :- moyenneTemps,pourcentage3b.

lancerEval :- writeln('#### Defensive vs Mixte (4) ####'),initEval,initEval8, eval8.
lancerEval :- pourcentage8.

lancerEval :- writeln('#### Mixte vs Defensive (4b) ####'),initEval,initEval8b, eval8b.
lancerEval :- pourcentage8b.

lancerEval :- writeln('#### Offensive vs Defensive (5) ####'),initEval,initEval5, eval5.
lancerEval :- pourcentage5.

lancerEval :- writeln('#### Defensive vs Offensive (5b) ####'),initEval,initEval5b, eval5b.
lancerEval :- pourcentage5b.

lancerEval :- writeln('#### Offensive vs Mixte (6) ####'),initEval,initEval6, eval6.
lancerEval :- pourcentage6.

lancerEval :- writeln('#### Mixte vs Offensive (6b) ####'),initEval,initEval6b, eval6b.
lancerEval :- pourcentage6b.

/* A REVOIR
lancerEval :- writeln('#### Offensive vs Complete (7) ####'),initEval,initEval7, eval7.
lancerEval :- pourcentage7.

lancerEval :- writeln('#### Offensive vs Complete (7b) ####'),initEval,initEval7, eval7.
lancerEval :- pourcentage7.
*/

/* A REVOIR
lancerEval :- writeln('#### Aleatoire vs Complete (8) ####'),initEval,initEval4, eval4.
lancerEval :- pourcentage4.

lancerEval :- writeln('#### Complete vs Aleatoire (8b) ####'),initEval,initEval4b, eval4b.
lancerEval :- pourcentage4b.
*/

/* A REVOIR
lancerEval :- writeln('#### Defensive vs Complete (9) ####'),initEval,initEval9, eval9.
lancerEval :- pourcentage9.

lancerEval :- writeln('#### Complete vs Defensive (9b) ####'),initEval,initEval9b, eval9b.
lancerEval :- pourcentage9b.

lancerEval :- writeln('#### Mixte vs Complete (10) ####'),initEval,initEval10, eval10.
lancerEval :- pourcentage10.

lancerEval :- writeln('#### Complete vs Mixte (10b) ####'),initEval,initEval10b, eval10b.
lancerEval :- pourcentage10b.
*/
% ####################################################################
% #### aléatoire vs offensive (1) ####

eval1 :- nb_getval('NBEval',N),initEval1,between(1,N,I),combatIAEval1.

initEval1 :- nb_setval('timeTable',[]),nb_setval('AVSO1',0),nb_setval('AVSO2',0).

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
		
tourIA1Eval1 :-	statistics(cputime,T1),ia(N),statistics(cputime,T2),nb_getval('timeTable',TimeTable),Temp is T2-T1,append(TimeTable,[Temp],Final),nb_setval('timeTable',Final),
		jouerCoup([N,1]),
		testIA1Eval1(N),!.
			
tourIA2Eval1 :-	iAOffensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval1(M),!.  
			
pourcentage1 :- nb_getval('AVSO1',NBJ1),nb_getval('AVSO2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% #### offensive vs aléatoire (1b) ####

eval1b :- nb_getval('NBEval',N),initEval1b,between(1,N,I),combatIAEval1b.

initEval1b :- nb_setval('timeTable',[]),nb_setval('AVSO1b',0),nb_setval('AVSO2b',0).

combatIAEval1b :- tourIA1Eval1b.

testIA1Eval1b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSO1b',X),incrementeX(X,X1),nb_setval('AVSO1b',X1),testVidePlateau;
		tourIA2Eval1b
		).
		
testIA2Eval1b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSO2b',X),incrementeX(X,X1),nb_setval('AVSO2b',X1),testVidePlateau;
		tourIA1Eval1b
		).
		
tourIA1Eval1b :-	statistics(cputime,T1),iAOffensive(1,N),statistics(cputime,T2),nb_getval('timeTable',TimeTable),Temp is T2-T1,append(TimeTable,[Temp],Final),nb_setval('timeTable',Final),
		jouerCoup([N,1]),
		testIA1Eval1b(N),!.
			
tourIA2Eval1b :-	ia(M),
		jouerCoup([M,2]),
		testIA2Eval1b(M),!.  
			
pourcentage1b :- nb_getval('AVSO1b',NBJ1),nb_getval('AVSO2b',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  aléatoire vs defensive (2) ####

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
			
tourIA2Eval2 :-	iADefensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval2(M),!.  
			
pourcentage2 :- nb_getval('AVSD1',NBJ1),nb_getval('AVSD2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  defensive vs aléatoire (2b) ####

eval2b :- nb_getval('NBEval',N),initEval2b,between(1,N,I),combatIAEval2b.

initEval2b :- nb_setval('timeTable',[]),nb_setval('AVSD1b',0),nb_setval('AVSD2b',0).

combatIAEval2b :- tourIA1Eval2b.

testIA1Eval2b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSD1b',X),incrementeX(X,X1),nb_setval('AVSD1b',X1),testVidePlateau;
		tourIA2Eval2b
		).
		
testIA2Eval2b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSD2b',X),incrementeX(X,X1),nb_setval('AVSD2b',X1),testVidePlateau;
		tourIA1Eval2b
		).
		
tourIA1Eval2b :-	statistics(cputime,T1),iADefensive(1,N),statistics(cputime,T2),nb_getval('timeTable',TimeTable),Temp is T2-T1,append(TimeTable,[Temp],Final),nb_setval('timeTable',Final),
		jouerCoup([N,1]),
		testIA1Eval2b(N),!.
			
tourIA2Eval2b :-	ia(M),
		jouerCoup([M,2]),
		testIA2Eval2b(M),!.  
			
pourcentage2b :- nb_getval('AVSD1b',NBJ1),nb_getval('AVSD2b',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  aléatoire vs mixte (3) ####

eval3 :- nb_getval('NBEval',N),initEval3,between(1,N,I),combatIAEval3.

initEval3 :- nb_setval('AVSM1',0),nb_setval('AVSM2',0).

combatIAEval3 :- tourIA1Eval3.

testIA1Eval3(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSM1',X),incrementeX(X,X1),nb_setval('AVSM1',X1),testVidePlateau;
		tourIA2Eval3
		).
		
testIA2Eval3(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSM2',X),incrementeX(X,X1),nb_setval('AVSM2',X1),testVidePlateau;
		tourIA1Eval3
		).
		
tourIA1Eval3 :-	ia(N),
		jouerCoup([N,1]),
		testIA1Eval3(N),!.
			
tourIA2Eval3 :-	iaMixte(2,M),
		jouerCoup([M,2]),
		testIA2Eval3(M),!.  
			
pourcentage3 :- nb_getval('AVSM1',NBJ1),nb_getval('AVSM2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  mixte vs aléatoire (3b) ####


eval3b :- nb_getval('NBEval',N),initEval3b,between(1,N,I),combatIAEval3b.

initEval3b :- nb_setval('timeTable',[]),nb_setval('AVSM1b',0),nb_setval('AVSM2b',0).

combatIAEval3b :- tourIA1Eval3b.

testIA1Eval3b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSM1b',X),incrementeX(X,X1),nb_setval('AVSM1b',X1),testVidePlateau;
		tourIA2Eval3b
		).
		
testIA2Eval3b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSM2b',X),incrementeX(X,X1),nb_setval('AVSM2b',X1),testVidePlateau;
		tourIA1Eval3b
		).
		
tourIA1Eval3b :-	statistics(cputime,T1),iaMixte(1,N),statistics(cputime,T2),nb_getval('timeTable',TimeTable),Temp is T2-T1,append(TimeTable,[Temp],Final),nb_setval('timeTable',Final),
		jouerCoup([N,1]),
		testIA1Eval3b(N),!.
			
tourIA2Eval3b :-	ia(M),
		jouerCoup([M,2]),
		testIA2Eval3b(M),!.  
			
pourcentage3b :- nb_getval('AVSM1b',NBJ1),nb_getval('AVSM2b',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  aléatoire vs complète (4) ####
% ######### ATTENTION, IACOMPLETE PAS ENCORE IMPLEMENTEE
/*
eval4 :- nb_getval('NBEval',N),initEval4,between(1,N,I),combatIAEval4.

initEval4 :- nb_setval('AVSC1',0),nb_setval('AVSC2',0).

combatIAEval4 :- tourIA1Eval4.

testIA1Eval4(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSC1',X),incrementeX(X,X1),nb_setval('AVSC1',X1),testVidePlateau;
		tourIA2Eval4
		).
		
testIA2Eval4(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSC2',X),incrementeX(X,X1),nb_setval('AVSC2',X1),testVidePlateau;
		tourIA1Eval4
		).
		
tourIA1Eval4 :-	ia(N),
		jouerCoup([N,1]),
		testIA1Eval4(N),!.

tourIA2Eval4 :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval4(M),!.  
			
pourcentage4 :- nb_getval('AVSC1',NBJ1),nb_getval('AVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).
*/

% ####################################################################
% ####  complète vs aléatoire (4b) ####
% ######### ATTENTION, IACOMPLETE PAS ENCORE IMPLEMENTEE
/*
eval4b :- nb_getval('NBEval',N),initEval4b,between(1,N,I),combatIAEval4b.

initEval4b :- nb_setval('AVSC1',0),nb_setval('AVSC2',0).

combatIAEval4b :- tourIA1Eval4b.

testIA1Eval4b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSC1',X),incrementeX(X,X1),nb_setval('AVSC1',X1),testVidePlateau;
		tourIA2Eval4b
		).
		
testIA2Eval4b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('AVSC2',X),incrementeX(X,X1),nb_setval('AVSC2',X1),testVidePlateau;
		tourIA1Eval4b
		).
		
tourIA2Eval4b :-	ia(N),
		jouerCoup([N,1]),
		testIA1Eval4b(N),!.

tourIA1Eval4b :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval4b(M),!.  
			
pourcentage4b :- nb_getval('AVSC1',NBJ1),nb_getval('AVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).
*/

% ####################################################################
% ####   offensive vs defensive (5) ####

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
			
tourIA2Eval5 :-	iADefensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval5(M),!.  
			
pourcentage5 :- nb_getval('OVSD1',NBJ1),nb_getval('OVSD2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####   defensive vs offensive (5b) ####

eval5b :- nb_getval('NBEval',N),initEval5b,between(1,N,I),combatIAEval5b.

initEval5b :- nb_setval('OVSD1b',0),nb_setval('OVSD2b',0).

combatIAEval5b :- tourIA1Eval5b.

testIA1Eval5b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSD1b',X),incrementeX(X,X1),nb_setval('OVSD1b',X1),testVidePlateau;
		tourIA2Eval5b
		).
		
testIA2Eval5b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSD2b',X),incrementeX(X,X1),nb_setval('OVSD2b',X1),testVidePlateau;
		tourIA1Eval5b
		).
		
tourIA1Eval5b :-	iADefensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval5b(N),!.
			
tourIA2Eval5b :-	iAOffensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval5b(M),!.  
			
pourcentage5b :- nb_getval('OVSD1b',NBJ1),nb_getval('OVSD2b',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  offensive vs mixte (6) ####

eval6 :- nb_getval('NBEval',N),initEval6,between(1,N,I),combatIAEval6.

initEval6 :- nb_setval('OVSM1',0),nb_setval('OVSM2',0).

combatIAEval6 :- tourIA1Eval6.

testIA1Eval6(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSM1',X),incrementeX(X,X1),nb_setval('OVSM1',X1),testVidePlateau;
		tourIA2Eval6
		).
		
testIA2Eval6(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSM2',X),incrementeX(X,X1),nb_setval('OVSM2',X1),testVidePlateau;
		tourIA1Eval6
		).
		
tourIA1Eval6 :-	iAOffensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval6(N),!.
			
tourIA2Eval6 :-	iaMixte(2,M),
		jouerCoup([M,2]),
		testIA2Eval6(M),!.  
			
pourcentage6 :- nb_getval('OVSM1',NBJ1),nb_getval('OVSM2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  mixte vs offensive (6b) ####

eval6b :- nb_getval('NBEval',N),initEval6b,between(1,N,I),combatIAEval6b.

initEval6b :- nb_setval('OVSM1b',0),nb_setval('OVSM2b',0).

combatIAEval6b :- tourIA1Eval6b.

testIA1Eval6b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSM1b',X),incrementeX(X,X1),nb_setval('OVSM1b',X1),testVidePlateau;
		tourIA2Eval6b
		).
		
testIA2Eval6b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSM2b',X),incrementeX(X,X1),nb_setval('OVSM2b',X1),testVidePlateau;
		tourIA1Eval6b
		).
		
tourIA1Eval6b :-	iaMixte(1,N),
		jouerCoup([N,1]),
		testIA1Eval6b(N),!.
			
tourIA2Eval6b :-	iAOffensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval6b(M),!.  
			
pourcentage6b :- nb_getval('OVSM1b',NBJ1),nb_getval('OVSM2b',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  offensive vs complète (7) ####
/*
eval7 :- nb_getval('NBEval',N),initEval7,between(1,N,I),combatIAEval7.

initEval7 :- nb_setval('OVSC1',0),nb_setval('OVSC2',0).

combatIAEval7 :- tourIA1Eval7.

testIA1Eval7(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSC1',X),incrementeX(X,X1),nb_setval('OVSC1',X1),testVidePlateau;
		tourIA2Eval7
		).
		
testIA2Eval7(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSC2',X),incrementeX(X,X1),nb_setval('OVSC2',X1),testVidePlateau;
		tourIA1Eval7
		).
		
tourIA1Eval7 :-	iAOffensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval7(N),!.
			
tourIA2Eval7 :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval7(M),!.  
			
pourcentage7 :- nb_getval('OVSC1',NBJ1),nb_getval('OVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

*/

% ####################################################################
% ####  complete vs offensive (7b) ####
/*
eval7b :- nb_getval('NBEval',N),initEval7b,between(1,N,I),combatIAEval7b.

initEval7b :- nb_setval('OVSC1',0),nb_setval('OVSC2',0).

combatIAEval7b :- tourIA1Eval7b.

testIA1Eval7b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSC1',X),incrementeX(X,X1),nb_setval('OVSC1',X1),testVidePlateau;
		tourIA2Eval7b
		).
		
testIA2Eval7b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('OVSC2',X),incrementeX(X,X1),nb_setval('OVSC2',X1),testVidePlateau;
		tourIA1Eval7b
		).
		
tourIA2Eval7b :-	iAOffensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval7b(N),!.
			
tourIA1Eval7b :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval7b(M),!.  
			
pourcentage7b :- nb_getval('OVSC1',NBJ1),nb_getval('OVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

*/

% ####################################################################
% ####  defensive vs mixte (8) ####
eval8 :- nb_getval('NBEval',N),initEval8,between(1,N,I),combatIAEval8.

initEval8 :- nb_setval('DVSM1',0),nb_setval('DVSM2',0).

combatIAEval8 :- tourIA1Eval8.

testIA1Eval8(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSM1',X),incrementeX(X,X1),nb_setval('DVSM1',X1),testVidePlateau;
		tourIA2Eval8
		).
		
testIA2Eval8(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSM2',X),incrementeX(X,X1),nb_setval('DVSM2',X1),testVidePlateau;
		tourIA1Eval8
		).
		
tourIA1Eval8 :-	iADefensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval8(N),!.
			
tourIA2Eval8 :-	iaMixte(2,M),
		jouerCoup([M,2]),
		testIA2Eval8(M),!.  
			
pourcentage8 :- nb_getval('DVSM1',NBJ1),nb_getval('DVSM2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  mixte vs defensive (8b) ####

eval8b :- nb_getval('NBEval',N),initEval8b,between(1,N,I),combatIAEval8b.

initEval8b :- nb_setval('DVSM1b',0),nb_setval('DVSM2b',0).

combatIAEval8b :- tourIA1Eval8b.

testIA1Eval8b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSM1b',X),incrementeX(X,X1),nb_setval('DVSM1b',X1),testVidePlateau;
		tourIA2Eval8b
		).
		
testIA2Eval8b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSM2b',X),incrementeX(X,X1),nb_setval('DVSM2b',X1),testVidePlateau;
		tourIA1Eval8b
		).
		
tourIA1Eval8b :-	iaMixte(1,N),
		jouerCoup([N,1]),
		testIA1Eval8b(N),!.
			
tourIA2Eval8b :-	iADefensive(2,M),
		jouerCoup([M,2]),
		testIA2Eval8b(M),!.  
			
pourcentage8b :- nb_getval('DVSM1b',NBJ1),nb_getval('DVSM2b',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).

% ####################################################################
% ####  defensive vs complète (9) ####
/*
eval9 :- nb_getval('NBEval',N),initEval9,between(1,N,I),combatIAEval9.

initEval9 :- nb_setval('DVSC1',0),nb_setval('DVSC2',0).

combatIAEval9 :- tourIA1Eval9.

testIA1Eval9(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSC1',X),incrementeX(X,X1),nb_setval('DVSC1',X1),testVidePlateau;
		tourIA2Eval9
		).
		
testIA2Eval9(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSC2',X),incrementeX(X,X1),nb_setval('DVSC2',X1),testVidePlateau;
		tourIA1Eval9
		).
		
tourIA1Eval9 :-	iADefensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval9(N),!.
			
tourIA2Eval9 :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval9(M),!.  
			
pourcentage9 :- nb_getval('DVSC1',NBJ1),nb_getval('DVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).
*/

% ####################################################################
% #### complète vs defensive (9b) ####
/*
eval9b :- nb_getval('NBEval',N),initEval9b,between(1,N,I),combatIAEval9b.

initEval9b :- nb_setval('DVSC1',0),nb_setval('DVSC2',0).

combatIAEval9b :- tourIA1Eval9b.

testIA1Eval9b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSC1',X),incrementeX(X,X1),nb_setval('DVSC1',X1),testVidePlateau;
		tourIA2Eval9b
		).
		
testIA2Eval9b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('DVSC2',X),incrementeX(X,X1),nb_setval('DVSC2',X1),testVidePlateau;
		tourIA1Eval9b
		).
		
tourIA2Eval9b :-	iADefensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval9b(N),!.
			
tourIA1Eval9b :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval9b(M),!.  
			
pourcentage9b :- nb_getval('DVSC1',NBJ1),nb_getval('DVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).
*/

% ####################################################################
% ####  mixte vs complète (10) ####
/*
eval10 :- nb_getval('NBEval',N),initEval10,between(1,N,I),combatIAEval10.

initEval10 :- nb_setval('MVSC1',0),nb_setval('MVSC2',0).

combatIAEval10 :- tourIA1Eval10.

testIA1Eval10(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('MVSC1',X),incrementeX(X,X1),nb_setval('MVSC1',X1),testVidePlateau;
		tourIA2Eval10
		).
		
testIA2Eval10(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('MVSC2',X),incrementeX(X,X1),nb_setval('MVSC2',X1),testVidePlateau;
		tourIA1Eval10
		).
		
tourIA1Eval10 :-	iADefensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval10(N),!.
			
tourIA2Eval10 :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval10(M),!.  
			
pourcentage10 :- nb_getval('MVSC1',NBJ1),nb_getval('MVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).
*/

% ####################################################################
% ####  complète vs mixte (10b) ####
/*
eval10b :- nb_getval('NBEval',N),initEval10b,between(1,N,I),combatIAEval10b.

initEval10b :- nb_setval('MVSC1',0),nb_setval('MVSC2',0).

combatIAEval10b :- tourIA1Eval10b.

testIA1Eval10b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		 gagne(N,NumeroLigne,1) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('MVSC1',X),incrementeX(X,X1),nb_setval('MVSC1',X1),testVidePlateau;
		tourIA2Eval10b
		).
		
testIA2Eval10b(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
		gagne(N,NumeroLigne,2) -> nb_getval('NBEssaiReel',Y),incrementeX(Y,Y1),nb_setval('NBEssaiReel',Y1),nb_getval('MVSC2',X),incrementeX(X,X1),nb_setval('MVSC2',X1),testVidePlateau;
		tourIA1Eval10b
		).
		
tourIA2Eval10b :-	iADefensive(1,N),
		jouerCoup([N,1]),
		testIA1Eval10b(N),!.
			
tourIA1Eval10b :-	iaCompl(1,M),
		jouerCoup([M,2]),
		testIA2Eval10b(M),!.  
			
pourcentage10b :- nb_getval('MVSC1',NBJ1),nb_getval('MVSC2',NBJ2),nb_getval('NBEssaiReel',NBEssai),calculPourcentage(PJ1,PJ2,NBJ1,NBJ2),printToEval(NBEssai,PJ1,PJ2).
*/
