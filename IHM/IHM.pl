/* ----------- IHM ----------- */
%% Initialise l'IHM et la communication avec Java
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F),jpl_call('main',init,[F],_).

%% Lance le coup de l'IA dans le cas d'un combat Humain vs IA
coupIA :- %ia(N),
		iADefensive(1,N),
		%iAOffensive(2,N),
		%iaFS(N,1),
		jouerCoup([N,2]),
		testIA(N).
		
%% Test si l'IA a gagné dans le cas d'un combat Humain vs IA
testIA(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,2)->echec;finTour).
		
		
%% Test si la premiere IA à gagner
testIA1(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,1)->envoieMessageIA('J1 gagne');tourIA2).
		
%% Test si la deuxieme IA à gagner
testIA2(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(gagne(N,NumeroLigne,2)->envoieMessageIA('J2 gagne');tourIA1).
		
%% Predicat qui représente le tour de la premiere IA
tourIA1 :-	%ia(N),
			%iAOffensive(1,N),
			iaFS(N),
			jouerCoup([N,1]),
			print,
			sleep(1),
			testIA1(N).

%% Predicat qui représente le tour de la deuxieme IA			
tourIA2 :-	%ia(M),
			%iADefensive(1,M),
			iaFS(M),
			jouerCoup([M,2]),
			print,
			sleep(1),
			testIA2(M).  

%% Envoie à l'IHM un message
envoieMessageIA(S) :- jpl_call('main',printMessage,[S],_).

%% Affiche dans la console de l'IHM qu'un tour est fini
finTour :- jpl_call('main',debug,['finTour'],_).

%% Predicat a appeler lorsqu'on veut rafraichir le plateau
print :- jpl_call( 'main', print, [], _).

%% Predicat a appeler en cas de victoire 
victoire :- jpl_call( 'main', victoire, [], _).

%% Predicat a appeler en cas d'echec
echec :- jpl_call( 'main', echec, [], _).

%% Met les pions du joueur X et de la colonne I dans la liste Colonne
isolerColonneIJoueurX(I,X, Colonne) :- findall(pion(I, Y, X), pion(I, Y, X), Colonne).
    
