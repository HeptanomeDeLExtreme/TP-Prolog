
:- include('pionsFictifs.pl'). 
:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('evaluation.pl').
:- include('iaMixte.pl').
:- use_module(library(lists)).

/* ----------- Tests ----------- */
/* 
   POUR LANCER LES TESTS : tests.
   DANS LA CONSOLE.
*/


%% Affichage dans la console

afficherDebut(NomPredicat,SortieAttendue, Objectif) :- 
	writeln(['### Test du predicat ', NomPredicat, ' ###']),
	writeln(Objectif),
	writeln(['Sortie attendue : ', SortieAttendue]).
	
afficherFin(NomPredicat, Sortie, FailOrNot) :-
	writeln(['Sortie obtenue : ', Sortie]),
	( 
		FailOrNot == 'TEST REUSSI' -> ansi_format([fg(green)], 'TEST REUSSI', []);
		ansi_format([fg(red)], 'TEST ECHOUE', [])
	),
	writeln(['\n### FIN - Test du predicat ', NomPredicat, ' ###']),
	nl.
	
afficherNomTest(NomTest) :-
	nl,
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	writeln(NomTest),
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	nl.
	
afficherTestsUnitaires :-
	nl,
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	nl,
	writeln('TESTS UNITAIRES'),
	nl,
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	nl.
	
afficherFinTestsUnitaires :-
	nl,
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	nl,
	writeln('FIN - TESTS UNITAIRES'),
	nl,
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	nl.
	
afficherNomTest(N) :-
	writeln(['Test :', N]).
	
%% Tests du fichier util.pl

testUtil1 :-
	afficherNomTest(testUtil1),
	afficherDebut('incrementeX', true, 'Incrementation d une variable'),
	incrementeX(1, Reponse),!,  %% ICI
	(Reponse =:= 2 -> afficherFin('incrementeX', true, 'TEST REUSSI');
	afficherFin('incrementeX', false, 'TEST ECHOUE')).
	
testUtil2 :-
	afficherNomTest(testUtil2),
	afficherDebut('decrementeX', true, 'Decrementation d une variable'),
	decrementeX(3, Reponse),!,
	(Reponse =:= 2 -> afficherFin('decrementeX', true, 'TEST REUSSI');
	afficherFin('decrementeX', false, 'TEST ECHOUE')).
	
testUtil3 :-
	afficherNomTest(testUtil3),
	afficherDebut('doubleInc', true, 'Incrementation de deux variables'),
	doubleInc(2, 3, NewColonne, NewLigne),!,
	( (NewColonne =:= 3, NewLigne =:= 4) -> afficherFin('doubleInc', true, 'TEST REUSSI');
	afficherFin('doubleInc', false, 'TEST ECHOUE')).
	
testUtil4 :-
	afficherNomTest(testUtil4),
	afficherDebut('testVidePlateau', false, 'Verifie que le plateau se vide correctement apres l insertion de plusieurs pions'),
	assert(pion(1, 1, 1)),
	assert(pion(1, 2, 2)),
	testVidePlateau,!,
	( pion(Colonne, Ligne, Joueur) -> afficherFin('testVidePlateau', true, 'TEST ECHOUE');
	afficherFin('testVidePlateau', false, 'TEST REUSSI')).

testUtil5 :-
	afficherNomTest(testUtil5),
	afficherDebut('ajouterPion', true, 'Verifie qu un pion a bien ete ajoute'),
	assert(pion(1, 1, 1)),!,
	( pion(1, 1, _) -> afficherFin('ajouterPion', true, 'TEST REUSSI');
	afficherFin('ajouterPion', false, 'TEST ECHOUE')),
	testVidePlateau.
	
%% Tests du fichier iaDefOff.pl

testIaDefOff1 :-
	afficherNomTest(testIaDefOff1),
	afficherDebut('findAll3PathColonne', true, 'Verifie que le predicat trouve tous les chemins de taille 3 en colonne du plateau'),
	% Chemin sur la colonne 1, tableau de retour de findAll3PathColonne : [ColonneConcernee, SommetColonne]
	% ColonneConcernee = colonne ; SommetColonne = ligne
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(5, 1, 1),
	findAll3PathColonne(1, ListeJoueur1),
	%writeln(['Liste trouvee :', ListeJoueur1] ),
	( list_to_set(ListeJoueur1, [[1, 3]]) -> afficherFin('findAll3PathColonne', true, 'TEST REUSSI');
	afficherFin('findAll3PathColonne', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff2 :- 
	afficherNomTest(testIaDefOff2),
	afficherDebut('findAll2PathColonne', true, 'Verifie que le predicat trouve tous les chemins de taille 2 en colonne du plateau'),
	% Chemin sur la colonne 1, tableau de retour de findAll2PathColonne : [ColonneConcernee, SommetColonne]
	% ColonneConcernee = colonne ; SommetColonne = ligne
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(5, 1, 1),
	findAll2PathColonne(1, ListeJoueur1),
	%writeln(['Liste trouvee :', ListeJoueur1] ),
	( list_to_set(ListeJoueur1, [[1, 2]]) -> afficherFin('findAll2PathColonne', true, 'TEST REUSSI');
	afficherFin('findAll2PathColonne', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff3 :- 
	afficherNomTest(testIaDefOff3),
	afficherDebut('parcoursListeColonne', true, 'Verifie que le predicat renvoie la premiere colonne qui n est pas remplie'),
	% Une liste représentant le sommet de la colonne 1, le sommet de la colonne 2 et le sommet de la colonne 3
	parcoursListeColonne([[1, 7], [2, 4],[3, 1]], 1, Colonne),
	%writeln(['Liste trouvee :', ListeJoueur1] ),
	( Colonne =:= 2 -> afficherFin('parcoursListeColonne', true, 'TEST REUSSI');
	afficherFin('parcoursListeColonne', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff4 :- 
	afficherNomTest(testIaDefOff4),
	afficherDebut('parcoursListeColonne', false, 'Verifie que le predicat renvoie false quand la liste est vide'),
	( parcoursListeColonne([[]], 1, Colonne) -> afficherFin('parcoursListeColonne', true, 'TEST ECHOUE');
	afficherFin('parcoursListeColonne', false, 'TEST REUSSI')),
	testVidePlateau.
	
testIaDefOff5 :-
	afficherNomTest(testIaDefOff5),
	afficherDebut('findAll3PathLigne', true, 'Verifie que le predicat trouve tous les chemins de taille 3 en ligne du plateau'),
	% Chemin sur la ligne 1, tableau de retour de findAll3PathColonne : [Ligne, PionGauche, PionDroit]
	% PionGauche = Colonne ; PionDroit = Ligne
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(5, 1, 1),
	findAll3PathLigne(1, ListeJoueur1),
	%writeln(['Liste trouvee :', ListeJoueur1] ),
	( list_to_set(ListeJoueur1, [[1, 1, 3]]) -> afficherFin('findAll3PathLigne', true, 'TEST REUSSI');
	afficherFin('findAll3PathLigne', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff6 :- 
	afficherNomTest(testIaDefOff6),
	afficherDebut('findAll2PathLigne', true, 'Verifie que le predicat trouve tous les chemins de taille 2 en ligne du plateau'),
	% Chemin sur la ligne 1, tableau de retour de findAll3PathColonne : [Ligne, PionGauche, PionDroit]
	% PionGauche = Colonne ; PionDroit = Ligne
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(5, 1, 1),
	findAll2PathLigne(1, ListeJoueur1),
	%writeln(['Liste trouvee :', ListeJoueur1] ),
	( list_to_set(ListeJoueur1, [[1, 1, 2], [1, 2, 3]]) -> afficherFin('findAll2PathLigne', true, 'TEST REUSSI');
	afficherFin('findAll2PathLigne', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff7 :-
	afficherNomTest(testIaDefOff7),
	afficherDebut('tenteAjoutADroite', true, 'Verifie que le predicat ajoute bien un pion a droite d une ligne'),
	% Une liste représente [Ligne, PionLePlusAGauche, PionLePlusADroite]
	ajouterPion(1, 1, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	tenteAjoutADroite( [[1, 1, 3]], 1, Colonne),
	%writeln( ['Colonne :', Colonne] ),
	( Colonne =:= 4 ) -> afficherFin('tenteAjoutADroite', true, 'TEST REUSSI');
	afficherFin('tenteAjoutADroite', false, 'TEST ECHOUE'),
	testVidePlateau.
	
testIaDefOff8 :- 
	afficherNomTest(testIaDefOff8),
	afficherDebut('parcoursListeLigne', true, 'Verifie que le predicat ajoute bien un pion a gauche d une ligne avant de l ajouter de tenter l ajout a droite'),
	% Une liste représente [Ligne, PionLePlusAGauche, PionLePlusADroite]
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(4, 1, 1),
	parcoursListeLigne([[1, 2, 4]], 1, Colonne),
	% writeln(['Colonne :', Colonne] ),
	( Colonne =:= 1 -> afficherFin('parcoursListeLigne', true, 'TEST REUSSI');
	afficherFin('parcoursListeLigne', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff9 :- 
	afficherNomTest(testIaDefOff9),
	afficherDebut('parcoursListeLigne', true, 'Verifie que le predicat ajoute bien un pion a droite d une ligne lorsque l ajout a gauche est impossible'),
	% Une liste représente [Ligne, PionLePlusAGauche, PionLePlusADroite]
	ajouterPion(1, 1, 2),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(4, 1, 1),
	parcoursListeLigne([[1, 2, 4]], 1, Colonne),
	% writeln(['Colonne :', Colonne] ),
	( Colonne =:= 5 -> afficherFin('parcoursListeLigne', true, 'TEST REUSSI');
	afficherFin('parcoursListeLigne', false, 'TEST ECHOUE')),
	testVidePlateau.


testIaDefOff11 :-
	afficherNomTest(testIaDefOff11),
	afficherDebut('findAll3PathDiagGauche', true, 'Verifie que le predicat trouve tous les chemins de taille 3 en diagonale gauche'),
	ajouterPion(3, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(1, 3, 1),
	findAll3PathDiagGauche(1, ListeJoueur1),
	( list_to_set(ListeJoueur1, [[1, 3, 3, 1]]) -> afficherFin('findAll3PathDiagGauche', true, 'TEST REUSSI');
	afficherFin('findAll3PathDiagGauche', false, 'TEST ECHOUE')),
	testVidePlateau.

testIaDefOff12 :-
	afficherNomTest(testIaDefOff12),
	afficherDebut('findAll2PathDiagGauche', true, 'Verifie que le predicat trouve tous les chemins de taille 2 en diagonale gauche'),
	ajouterPion(3, 1, 1),
	ajouterPion(2, 2, 1),
	findAll2PathDiagGauche(1, ListeJoueur1),
	( list_to_set(ListeJoueur1, [[2,2,3,1]]) -> afficherFin('findAll2PathDiagGauche', true, 'TEST REUSSI');
	afficherFin('findAll2PathDiagGauche', false, 'TEST ECHOUE')),
	testVidePlateau.

testIaDefOff13 :-
	afficherNomTest(testIaDefOff13),
	afficherDebut('parcoursListeDiagGauche', true, 'Verifie que le predicat trouve tous les chemins en diagonale gauche'),
	ajouterPion(3, 1, 1),
	ajouterPion(2, 2, 1),
	findAll2PathDiagGauche(1, ListeJoueur1),
	( list_to_set(ListeJoueur1, [[2,2,3,1]]) -> afficherFin('findAll2PathDiagGauche', true, 'TEST REUSSI');
	afficherFin('findAll2PathDiagGauche', false, 'TEST ECHOUE')),
	testVidePlateau.

testIaDefOff15 :-
	afficherNomTest(testIaDefOff15),
	afficherDebut('findAll3PathDiagDroite', true, 'Verifie que le predicat trouve tous les chemins de taille 3 en diagonale droite'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 3, 1),
	findAll3PathDiagDroite(1, ListeJoueur1),
	( list_to_set(ListeJoueur1, [[1,1,3,3]]) -> afficherFin('findAll3PathDiagDroite', true, 'TEST REUSSI');
	afficherFin('findAll3PathDiagDroite', false, 'TEST ECHOUE')),
	testVidePlateau.

testIaDefOff16 :-
	afficherNomTest(testIaDefOff16),
	afficherDebut('findAll2PathDiagDroite', true, 'Verifie que le predicat trouve tous les chemins de taille 2 en diagonale droite'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 2, 1),
	findAll2PathDiagDroite(1, ListeJoueur1),
	( list_to_set(ListeJoueur1, [[1,1,2,2]]) -> afficherFin('findAll2PathDiagDroite', true, 'TEST REUSSI');
	afficherFin('findAll2PathDiagDroite', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testIaDefOff19 :-
	afficherNomTest(testIaDefOff19),
	afficherDebut('findAllPion', true, 'Verifie que le predicat trouve tous les pions du joueur 2'),
	% Liste retournée de la forme [ColonneDuPion, LigneDuPion]
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 2),
	ajouterPion(1, 3, 1),
	ajouterPion(1, 4, 2),
	ajouterPion(1, 5, 1),
	findAllPion(2, ListeJoueur2),
	( list_to_set( ListeJoueur2, [ [1, 2], [1, 4] ] ) -> afficherFin('findAllPion', true, 'TEST REUSSI');
	afficherFin('findAllPion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff20 :-
	afficherNomTest(testIaDefOff20),
	afficherDebut('tenteAjoutBG', true, 'Verifie que le predicat demande bien l ajout d un pion en bas a gauche du pion passe en parametre'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 2),
	tenteAjoutBG([ [3, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 2 -> afficherFin('tenteAjoutBG', true, 'TEST REUSSI');
	afficherFin('tenteAjoutBG', false, 'TEST ECHOUE') ),
	testVidePlateau.

testIaDefOff21 :-
	afficherNomTest(testIaDefOff21),
	afficherDebut('tenteAjoutG', true, 'Verifie que le predicat demande bien l ajout d un pion a gauche du pion passe en parametre'),
	ajouterPion(3, 1, 1),
	tenteAjoutG([ [3, 1] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 2 -> afficherFin('tenteAjoutG', true, 'TEST REUSSI');
	afficherFin('tenteAjoutG', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff22 :-
	afficherNomTest(testIaDefOff22),
	afficherDebut('tenteAjoutHG', true, 'Verifie que le predicat demande bien l ajout d un pion en haut a gauche du pion passe en parametre'),
	ajouterPion(3, 1, 1),
	ajouterPion(2, 1, 2),
	tenteAjoutHG([ [3, 1] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 2 -> afficherFin('tenteAjoutHG', true, 'TEST REUSSI');
	afficherFin('tenteAjoutHG', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff23 :-
	afficherNomTest(testIaDefOff23),
	afficherDebut('tenteAjoutH', true, 'Verifie que le predicat demande bien l ajout d un pion en haut du pion passe en parametre'),
	ajouterPion(3, 1, 1),
	tenteAjoutH([ [3, 1] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 3 -> afficherFin('tenteAjoutH', true, 'TEST REUSSI');
	afficherFin('tenteAjoutH', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff24 :-
	afficherNomTest(testIaDefOff24),
	afficherDebut('tenteAjoutHD', true, 'Verifie que le predicat demande bien l ajout d un pion en haut a droite du pion passe en parametre'),
	ajouterPion(3, 1, 1),
	ajouterPion(4, 1, 2),
	tenteAjoutHD([ [3, 1] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 4 -> afficherFin('tenteAjoutHD', true, 'TEST REUSSI');
	afficherFin('tenteAjoutHD', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff25 :-
	afficherNomTest(testIaDefOff25),
	afficherDebut('tenteAjoutD', true, 'Verifie que le predicat demande bien l ajout d un pion a droite du pion passe en parametre'),
	ajouterPion(3, 1, 1),
	tenteAjoutD([ [3, 1] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 4 -> afficherFin('tenteAjoutD', true, 'TEST REUSSI');
	afficherFin('tenteAjoutD', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff26 :-
	afficherNomTest(testIaDefOff26),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion en bas a droite du pion passe en parametre avant de tenter l ajout des pions a droite, puis en haut a droite, puis en haut, puis en haut a gauche, puis a gauche, puis en bas a gauche'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 1),
	parcoursListePion([ [3, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 4 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff27 :-
	afficherNomTest(testIaDefOff27),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion a droite du pion passe en parametre lorsque l ajout d autres pions est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 1, 2),
	parcoursListePion([ [2, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 3 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff28 :-
	afficherNomTest(testIaDefOff28),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion en haut a droite du pion passe en parametre lorsque l ajout d autres pions est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	parcoursListePion([ [2, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 3 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff29 :-
	afficherNomTest(testIaDefOff29),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion en haut du pion passe en parametre lorsque l ajout d autres pions est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	parcoursListePion([ [2, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 2 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff30 :-
	afficherNomTest(testIaDefOff30),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion en haut a gauche du pion passe en parametre lorsque l ajout d autres pions est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	parcoursListePion([ [2, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 1 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff31 :-
	afficherNomTest(testIaDefOff31),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion a gauche du pion passe en parametre lorsque l ajout d autres pions est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	parcoursListePion([ [2, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 1 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff32 :-
	afficherNomTest(testIaDefOff32),
	afficherDebut('parcoursListePion', true, 'Verifie que le predicat demande bien l ajout d un pion en bas a gauche du pion passe en parametre lorsque l ajout d autres pions est impossible'),
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	parcoursListePion([ [2, 2] ], 1, ColonneAJouer),
	( ColonneAJouer =:= 1 -> afficherFin('parcoursListePion', true, 'TEST REUSSI');
	afficherFin('parcoursListePion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff33 :-
	afficherNomTest(testIaDefOff33),
	afficherDebut('parcoursListePion', false, 'Verifie que le predicat renvoie false lorsque l ajout de pions est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),	
	ajouterPion(2, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	( parcoursListePion([ [2, 2] ], 1, ColonneAJouer) -> afficherFin('parcoursListePion', true, 'TEST ECHOUE');
	afficherFin('parcoursListePion', false, 'TEST REUSSI') ),
	testVidePlateau.
	
testIaDefOff34:-
	afficherNomTest(testIaDefOff34),
	afficherDebut('testInsertion3C', true, 'Verifie que le predicat demande l insertion d abord dans un chemin en colonne de longueur 3 quand c est possible'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(3, 3, 1),
	ajouterPion(4, 1, 2),
	ajouterPion(4, 2, 2),
	ajouterPion(5, 1, 1),
	testInsertion3C(1, ColonneAJouer),
	( ColonneAJouer =:= 3 -> afficherFin('testInsertion3C', true, 'TEST REUSSI');
	afficherFin('testInsertion3C', false, 'TEST ECHOUE') ),
	testVidePlateau.

testIaDefOff35 :-
	afficherNomTest(testIaDefOff35),
	afficherDebut('testInsertion3L', true, 'Verifie que le predicat demande l insertion dans un chemin en ligne de longueur 3 quand l insertion en colonne n est pas possible (colonne de taille 3)'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	ajouterPion(4, 1, 1),
	ajouterPion(4, 2, 2),
	ajouterPion(5, 1, 1),
	testInsertion3L(1, ColonneAJouer),
	%writeln( ['ColonneAJouer :', ColonneAJouer] ),
	( ColonneAJouer =:= 2 -> afficherFin('testInsertion3L', true, 'TEST REUSSI');
	afficherFin('testInsertion3L', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff36 :-
	afficherNomTest(testIaDefOff36),
	afficherDebut('testInsertion3DG', true, 'Verifie que le predicat demande l insertion en haut a gauche dans un chemin en diagonal de longueur 3 quand l insertion en ligne n est pas possible (ligne de taille 3)'),
	ajouterPion(2, 1, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(2, 3, 2),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 1),
	ajouterPion(4, 1, 2),
	ajouterPion(4, 2, 1),
	ajouterPion(4, 3, 2),
	ajouterPion(5, 1, 1),
	ajouterPion(5, 2, 2),
	ajouterPion(5, 3, 2),
	testInsertion3DG(1, ColonneAJouer),
	( ColonneAJouer =:= 2 -> afficherFin('testInsertion3DG', true, 'TEST REUSSI');
	afficherFin('testInsertion3DG', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff37 :-
	afficherNomTest(testIaDefOff37),
	afficherDebut('testInsertion3DD', true, 'Verifie que le predicat demande l insertion en haut a droite dans un chemin en diagonal de longueur 3 quand l insertion en haut a gauche d une diagonal de longueur 3 n est pas possible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 2),
	ajouterPion(1, 3, 2),
	ajouterPion(2, 1, 2),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 2),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 1),
	ajouterPion(4, 1, 2),
	ajouterPion(4, 2, 2),
	ajouterPion(4, 3, 2),
	testInsertion3DD(1, ColonneAJouer),
	( ColonneAJouer =:= 4 -> afficherFin('testInsertion3DD', true, 'TEST REUSSI');
	afficherFin('testInsertion3DD', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff38 :-
	afficherNomTest(testIaDefOff38),
	afficherDebut('testInsertion2C', true, 'Verifie que le predicat demande l insertion sur une colonne de taille 2 lorsque l insertion en faut a droite dans un chemin en diagonal de longueur 3 est impossible'),
	ajouterPion(4, 1, 1),
	ajouterPion(4, 2, 1),
	ajouterPion(5, 1, 1),
	testInsertion2C(1, ColonneAJouer),
	( ColonneAJouer =:= 4 -> afficherFin('testInsertion2C', true, 'TEST REUSSI');
	afficherFin('testInsertion2C', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff39 :-
	afficherNomTest(testIaDefOff39),
	afficherDebut('testInsertion2L', true, 'Verifie que le predicat demande sur une ligne de taille 2 lorsque l insertion sur une colonne de taille 2 est impossible'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 2),
	ajouterPion(3, 3, 2),
	ajouterPion(4, 1, 1),
	ajouterPion(4, 2, 2),
	testInsertion2L(1, ColonneAJouer),
	%writeln( ['ColonneAJouer :', ColonneAJouer] ),
	( ColonneAJouer =:= 2 -> afficherFin('testInsertion2L', true, 'TEST REUSSI');
	afficherFin('testInsertion2L', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff40 :-
	afficherNomTest(testIaDefOff40),
	afficherDebut('testInsertion2DG', true, 'Verifie que le predicat demande l insertion en haut a gauche d une diagonale si l insertion sur une ligne de taille 2 est impossible'),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 1, 2),
	ajouterPion(4, 2, 1),
	ajouterPion(4, 3, 2),
	ajouterPion(5, 1, 1),
	ajouterPion(5, 2, 2),
	ajouterPion(5, 3, 2),
	testInsertion2DG(1, ColonneAJouer),
	( ColonneAJouer =:= 3 -> afficherFin('testInsertion2DG', true, 'TEST REUSSI');
	afficherFin('testInsertion2DG', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff41 :-
	afficherNomTest(testIaDefOff41),
	afficherDebut('testInsertion2DD', true, 'Verifie que le predicat demande l insertion en haut a droite d une diagonale de taille 2 lorsque l insertion en haut a gauche d une diagonale de taille 2 est impossible'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 2),
	ajouterPion(1, 3, 2),
	ajouterPion(2, 1, 2),
	ajouterPion(2, 2, 1),
	ajouterPion(2, 3, 2),
	ajouterPion(3, 1, 2),
	ajouterPion(3, 2, 2),
	testInsertion2DD(1, ColonneAJouer),
	( ColonneAJouer =:= 3 -> afficherFin('testInsertion2DD', true, 'TEST REUSSI');
	afficherFin('testInsertion2DD', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
testIaDefOff42 :-
	afficherNomTest(testIaDefOff42),
	afficherDebut('testInsertionPion', true, 'Verifie que le predicat demande l insertion autours d un pion lorsque l insertion en haut a droite d une diagonale de taille 2 est impossible'),
	ajouterPion(1, 1, 1),
	testInsertionPion(1, ColonneAJouer),
	( ColonneAJouer =:= 2 -> afficherFin('testInsertionPion', true, 'TEST REUSSI');
	afficherFin('testInsertionPion', false, 'TEST ECHOUE') ),
	testVidePlateau.
	
%% Tests du fichier iaMixte.pl


testM1:-
	afficherNomTest(testM1),
	afficherDebut('PeutGagnerSurCol', true, 'Verifie que le predicat peutGagnerSurCol vérifie une colonne qui permet la victoire'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(3, 3, 1),
	(peutGagnerSurCol(3,1) -> afficherFin('peutGagnerSurCol', true, 'TEST REUSSI');
	afficherFin('peutGagnerSurCol', false, 'TEST ECHOUE')),
	testVidePlateau.

testM2:-
	afficherNomTest(testM2),
	afficherDebut('PeutGagnerSurCol', true, 'Verifie que le predicat peutGagnerSurCol ne vérifie pas une colonne qui ne permet pas la victoire.'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(3, 3, 1),
	(peutGagnerSurCol(4,1) ->afficherFin('peutGagnerSurCol', false, 'TEST ECHOUE');
 	afficherFin('peutGagnerSurCol', true, 'TEST REUSSI')),
	testVidePlateau.

testM3:-
	afficherNomTest(testM3),
	afficherDebut('checkVictoireColonne', true, 'Verifie que le predicat checkVictoireColonne trouve bien la première colonne où une victoire est possible.'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(4, 1, 1),
	ajouterPion(4, 2, 1),
	ajouterPion(4, 3, 1),
	peutGagner(X,1),
	(X =:=1 ->afficherFin('checkVictoireColonne', true, 'TEST REUSSI');
 	afficherFin('checkVictoireColonne', false, 'TEST ECHOUE')),
	testVidePlateau.

testM4:-
	afficherNomTest(testM4),
	afficherDebut('peutGagner', true, 'Verifie que le predicat peutGagner trouve bien la première colonne où une victoire est possible.'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(4, 1, 1),
	ajouterPion(4, 2, 1),
	ajouterPion(4, 3, 1),
	peutGagner(X,1),
	(X =:=1 ->afficherFin('peutGagner', true, 'TEST REUSSI');
 	afficherFin('peutGagner', false, 'TEST ECHOUE')),
	testVidePlateau.
	
testM5:-
	afficherNomTest(testM5),
	afficherDebut('peutPerdre', true, 'Verifie que le predicat peutPerdre trouve bien la première colonne où une victoire est possible.'),
	ajouterPion(1, 1, 2),
	ajouterPion(1, 2, 2),
	ajouterPion(1, 3, 2),
	peutPerdre(X,1),
	(X =:=1 ->afficherFin('peutPerdre', true, 'TEST REUSSI');
 	afficherFin('peutPerdre', false, 'TEST ECHOUE')),
	testVidePlateau.


%% Tests du fichier jouerCoup.pl
testJouerCoup1 :-
    afficherNomTest(testJouerCoup1),
    afficherDebut('isolerColonne', true, 'Verifie que le predicat renvoie la liste des pions présents sur la colonne'),
    assert(pion(1, 1, 1)),
    assert(pion(2, 1, 1)),
    assert(pion(2, 2, 1)),
    assert(pion(4, 1, 1)),
    isolerColonne(2,ColIsol),
    ( list_to_set(ColIsol, [pion(2, 1, 1), pion(2, 2, 1)]) -> afficherFin('isolerColonne', true, 'TEST REUSSI');
      afficherFin('isolerColonne', false, '')),
    testVidePlateau.


testJouerCoup2 :-
    afficherNomTest(testJouerCoup2),
    afficherDebut('indexDernierPion', true, 'Verifie que le predicat renvoie le numero de ligne du pion le plus haut de la colonne'),
    indexDernierPion([pion(2,1,1),pion(2,2,1),pion(2,3,1)],NumLi),
    ( NumLi == 3 -> afficherFin('indexDernierPion', true, 'TEST REUSSI');
      afficherFin('indexDernierPion', false, '')),
    testVidePlateau.


testJouerCoup3 :-
    afficherNomTest(testJouerCoup3),
    afficherDebut('calculProchainepion', true, 'Verifie que le predicat renvoie le numero de ligne suivant'),
    calculProchainepion(3,NextNumLi),
    ( NextNumLi == 4 -> afficherFin('calculProchainepion', true, 'TEST REUSSI');
      afficherFin('calculProchainepion', false, '')),
    testVidePlateau.


testJouerCoup4 :-
    afficherNomTest(testJouerCoup4),
    afficherDebut('isolerColonne', true, 'Verifie que le predicat jouerCoup ajoute un pion sur la première ligne vide de la colonne voulue'),
    assert(pion(1, 1, 1)),
    assert(pion(2, 1, 1)),
    assert(pion(2, 2, 1)),
    assert(pion(4, 1, 1)),
    jouerCoup([2,1]),
    ( pion(2,3,1) -> afficherFin('isolerColonne', true, 'TEST REUSSI');
      afficherFin('isolerColonne', false, '')),
    testVidePlateau.


%% Tests du fichier iaAleatoire.pl
testIaAleatoire1 :-
    afficherNomTest(testIaAleatoire1),
    afficherDebut('peutJouer', true, 'Verifie que le predicat est vrai si la colonne est non-pleine et faux si elle est pleine'),
    assert(pion(2, 1, 1)),
    assert(pion(2, 2, 1)),
    assert(pion(2, 3, 1)),
    assert(pion(2, 4, 1)),
    assert(pion(2, 5, 1)),
    assert(pion(2, 6, 1)),
    assert(pion(4, 1, 1)),
    (peutJouer(4), not(peutJouer(2)) -> afficherFin('peutJouer', true, 'TEST REUSSI');
      afficherFin('peutJouer', false, '')),
    testVidePlateau.

%% Tests du fichier finDeJeu.pl
testFDJ3:-
	afficherNomTest(testFDJ3),
	afficherDebut('victoireColonne', true, 'Verifie que le predicat victoireColonne détecte une colonne de 4 pions du même joueur.'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(1, 4, 1),
	ajouterPion(2, 1, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(2, 3, 2),
	ajouterPion(2, 4, 1),
	( (victoireColonne(1,4,1), not(victoireColonne(2,4,1)) ) -> afficherFin('victoireColonne', true, 'TEST REUSSI');
	afficherFin('victoireColonne', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ4:-
	afficherNomTest(testFDJ4),
	afficherDebut('verifieGauche', true, 'Verifie que le predicat verifieGauche détecte les pions à Gauche du pion en paramètre (uniquement ceux du joueur actif).'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(4, 1, 1),
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 2),
	verifieGauche(4, 1, 1, X1),
	verifieGauche(4, 2, 2, X2),
	((X1 =:= 4, X2 =:= 2 ) -> afficherFin('verifieDroite', true, 'TEST REUSSI');
	afficherFin('verifieGauche', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ5:-
	afficherNomTest(testFDJ5),
	afficherDebut('verifieDroite', true, 'Verifie que le predicat verifieDroite détecte les pions à Droite du pion en paramètre (uniquement ceux du joueur actif).'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(4, 1, 1),
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 2),
	verifieDroite(1, 1, 1, X1),
	verifieDroite(1, 2, 2, X2),
	((X1 =:= 4, X2 =:= 1 ) -> afficherFin('verifieDroite', true, 'TEST REUSSI');
	afficherFin('verifieDroite', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ6:-
	afficherNomTest(testFDJ6),
	afficherDebut('victoireLigne', true, 'Verifie que le predicat victoireLigne détecte une ligne de 4 pions du même joueur.'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 1, 1),
	ajouterPion(3, 1, 1),
	ajouterPion(4, 1, 1),
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 1),
	( (victoireLigne(4,1,1), not(victoireColonne(4,2,1)) ) -> afficherFin('victoireLigne', true, 'TEST REUSSI');
	afficherFin('victoireLigne', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ7:-
	afficherNomTest(testFDJ7),
	afficherDebut('verifieGaucheHaut', true, 'Verifie que le prédicat compte bien le nombre de pions du même joueur alignés sur une diagonale Gauche haut.'),
	ajouterPion(1, 4, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(4, 1, 1),
	verifieGaucheHaut(4, 1, 1, X),
	( X =:= 4-> afficherFin('verifieGaucheHaut', true, 'TEST REUSSI');
	afficherFin('verifieGaucheHaut', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ8:-
	afficherNomTest(testFDJ8),
	afficherDebut('verifieDroiteBas', true, 'Verifie que le prédicat compte bien le nombre de pions du même joueur alignés sur une droite bas.'),
	ajouterPion(1, 4, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(4, 1, 1),
	verifieDroiteBas(1, 4, 1, X),
	( X =:= 4-> afficherFin('verifieDroiteBas', true, 'TEST REUSSI');
	afficherFin('verifieDroiteBas', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ9:-
	afficherNomTest(testFDJ9),
	afficherDebut('victoireDiagGauche', true, 'Verifie que le prédicat détecte une diagonale Gauche Haut/ Droite Bas de 4 pions du même joueur.'),
	ajouterPion(1, 4, 1),
	ajouterPion(2, 3, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(4, 1, 1),
	
	( (victoireDiagGauche(1,4,1), victoireDiagGauche(4,1,1))-> afficherFin('victoireDiagGauche', true, 'TEST REUSSI');
	afficherFin('victoireDiagGauche', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ10:-
	afficherNomTest(testFDJ10),
	afficherDebut('verifieGaucheBas', true, 'Verifie que le prédicat compte bien le nombre de pions du même joueur alignés sur une diagonale Gauche bas.'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 3, 1),
	ajouterPion(4, 4, 1),
	verifieGaucheBas(4, 4, 1, X),
	( X =:= 4-> afficherFin('verifieGaucheBas', true, 'TEST REUSSI');
	afficherFin('verifieGaucheBas', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ11:-
	afficherNomTest(testFDJ11),
	afficherDebut('verifieDroiteHaut', true, 'Verifie que le prédicat compte bien le nombre de pions du même joueur alignés sur une diagonale droiteHaut.'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 3, 1),
	ajouterPion(4, 4, 1),
	verifieDroiteHaut(1, 1, 1, X),
	( X =:= 4-> afficherFin('verifieDroiteHaut', true, 'TEST REUSSI');
	afficherFin('verifieDroiteHaut', false, 'TEST ECHOUE')) ,
	testVidePlateau.

testFDJ12:-
	afficherNomTest(testFDJ12),
	afficherDebut('victoireDiagDroite', true, 'Verifie que le prédicat détecte une diagonale Gauche Bas/ Droite Haut de 4 pions du même joueur.'),
	ajouterPion(1, 1, 1),
	ajouterPion(2, 2, 1),
	ajouterPion(3, 3, 1),
	ajouterPion(4, 4, 1),
	((victoireDiagDroite(1,1,1), victoireDiagDroite(4,4,1))-> afficherFin('victoireDiagDroite', true, 'TEST REUSSI');
	afficherFin('victoireDiagDroite', false, 'TEST ECHOUE')) ,
	testVidePlateau.
%% Appel des tests

testsUtils :-
	afficherTestsUnitaires,
	afficherNomTest('Fichier : util.pl'),
	testUtil1,
	testUtil2,
	testUtil3,
	testUtil4,
	testUtil5,
	!.
	
testsIADefOFF :-
	afficherNomTest('Fichier : iaDefOff.pl'),
	testIaDefOff1,
	testIaDefOff2,
	testIaDefOff3,
	testIaDefOff4,
	testIaDefOff5,
	testIaDefOff6,
	testIaDefOff7,
	testIaDefOff8,
	testIaDefOff9,
	testIaDefOff11,
	testIaDefOff12,
	testIaDefOff13,
	%testIaDefOff14,
	testIaDefOff15,
	testIaDefOff16,
	%testIaDefOff17,
	%testIaDefOff18,
	testIaDefOff19,
	testIaDefOff20,
	testIaDefOff21,
	testIaDefOff22,
	testIaDefOff23,
	testIaDefOff24,
	testIaDefOff25,
	testIaDefOff26,
	testIaDefOff26,
	testIaDefOff27,
	testIaDefOff28,
	testIaDefOff29,
	testIaDefOff30,
	testIaDefOff31,
	testIaDefOff31,
	testIaDefOff32,
	testIaDefOff33,
	testIaDefOff34,
	testIaDefOff35,
	testIaDefOff36,
	testIaDefOff37,
	testIaDefOff38,
	testIaDefOff39,
	testIaDefOff40,
	%testIaDefOff41,
	!.

testsJouerCoup :-
	afficherNomTest('Fichier : jouerCoup.pl'),
	testJouerCoup1,
	testJouerCoup2,
	testJouerCoup3,
	testJouerCoup4,
	!.
	
testsM :-
	afficherNomTest('Fichier : iaMixte.pl'),
	testM1,
	testM2,
	testM3,
	testM4,
	testM5,
	!.

testsAleatoire :-
	afficherNomTest('Fichier : iaAleatoire.pl'),
	testIaAleatoire1,
	!.
	
testsFDJ :-
	afficherNomTest('Fichier : finDeJeu.pl'),
	testFDJ3,
	testFDJ4,
	testFDJ5,
	testFDJ6,
	testFDJ7,
	testFDJ8,
	testFDJ9,
	testFDJ10,
	testFDJ11,
	testFDJ12,
	!.

finTests :-	afficherFinTestsUnitaires,!.

tests :- testsUtils,
		testsIADefOFF,
		testsJouerCoup,
		testsM,
		testsAleatoire,
		testsFDJ,
		finTests.
