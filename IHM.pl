/* ----------- IHM ----------- */

%% Initialise l'IHM et la communication avec Java
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F),jpl_call('main',init,[F],_).

%% Lance le coup de l'IA dans le cas d'un combat Humain vs IA
coupIA :- %ia(N),
		%iADefensive(2,N),
		%iAOffensive(2,N),
		iaMixte(2,N), %% Offensive d'abord
		jouerCoup([N,2]),
		testIA(N).
		
%% Test si l'IA a gagné dans le cas d'un combat Humain vs IA
testIA(N) :- isolerColonne(N, Colonne),
		indexDernierPion(Colonne, NumeroLigne),
		(
			gagne(N,NumeroLigne,2)->echec;
			(
				matchNull -> finMatchNul ;
				finTour
			)
		).
		
		
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
			iaMixte(1,N),
			jouerCoup([N,1]),
			print,
			sleep(2),
			testIA1(N).

%% Predicat qui représente le tour de la deuxieme IA			
tourIA2 :-	%ia(M),
			%iADefensive(2,M),
			iaMixte(2,M),
			jouerCoup([M,2]),
			print,
			sleep(2),
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

%% Predicat a appeler en cas de match nul
finMatchNul :- jpl_call('main',nul,[],_).
