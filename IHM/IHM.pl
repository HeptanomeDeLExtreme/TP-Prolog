/* ----------- IHM ----------- */
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F),jpl_call('main',init,[F],_).

coupIA :- %ia(N),
		%iADefensive(1,N),
		%iAOffensive(2,N),
		iaFS(N),
		jouerCoup([N,2]),
		testIA(N).
		
testIA(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,2)->echec;finTour).
		
testIA1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,1)->envoieMessageIA('J1 gagne');tourIA2).
		
testIA2(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,2)->envoieMessageIA('J2 gagne');tourIA1).
		
tourIA1 :-	%ia(N),
			%iAOffensive(1,N),
			iaFS(N),
			jouerCoup([N,1]),
			print,
			sleep(1),
			testIA1(N).
			
tourIA2 :-	%ia(M),
			%iADefensive(1,M),
			iaFS(N),
			jouerCoup([M,2]),
			print,
			sleep(1),
			testIA2(M).  

envoieMessageIA(S) :- jpl_call('main',printMessage,[S],_).

finTour :- jpl_call('main',debug,['finTour'],_).

%% Predicat a appeler lorsqu'on veut rafraichir le plateau
print :- jpl_call( 'main', print, [], _).

%% Predicat a appeler en cas de victoire 
victoire :- jpl_call( 'main', victoire, [], _).

%% Predicat a appeler en cas d'echec
echec :- jpl_call( 'main', echec, [], _).

isolerColonneIJoueurX(I,X, Colonne) :- findall(pion(I, Y, X), pion(I, Y, X), Colonne).
    
cheminColonne(I,X) :- isolerColonneIJoueurX(I,X, Colonne),length(Colonne,T),write(T),( T == 4 -> victoire;echec). 
