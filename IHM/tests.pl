:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl').
:- include('ia2FenouilSec.pl').
:- use_module(library(lists)).

%% Affichage dans la console

afficherDebut(NomPredicat,SortieAttendue, Objectif) :- 
	writeln(['### Test du precidat ', NomPredicat, ' ###']),
	writeln(Objectif),
	writeln(['Sortie attendue : ', SortieAttendue]).
	
afficherFin(NomPredicat, Sortie, FailOrNot) :-
	writeln(['Sortie obtenue : ', Sortie]),
	writeln(FailOrNot),
	writeln(['### FIN - Test du precidat ', NomPredicat, ' ###']),
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
	
afficherTestsFonctionnels :-
	nl,
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	writeln('** ** ** ** ** ** ** ** ** ** **'),
	nl,
	writeln('TESTS FONCTIONNELS'),
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
	incrementeX(1, Reponse),
	(Reponse =:= 2 -> afficherFin('incrementeX', true, 'TEST REUSSI');
	afficherFin('incrementeX', false, 'TEST ECHOUE')).
	
testUtil2 :-
	afficherNomTest(testUtil2),
	afficherDebut('decrementeX', true, 'Decrementation d une variable'),
	decrementeX(3, Reponse),
	(Reponse =:= 2 -> afficherFin('decrementeX', true, 'TEST REUSSI');
	afficherFin('decrementeX', false, 'TEST ECHOUE')).
	
testUtil3 :-
	afficherNomTest(testUtil3),
	afficherDebut('doubleInc', true, 'Incrementation de deux variables'),
	doubleInc(2, 3, NewColonne, NewLigne),
	( (NewColonne =:= 3, NewLigne =:= 4) -> afficherFin('doubleInc', true, 'TEST REUSSI');
	afficherFin('doubleInc', false, 'TEST ECHOUE')).
	
testUtil4 :-
	afficherNomTest(testUtil4),
	afficherDebut('testVidePlateau', false, 'Verifie que le plateau se vide correctement apres l insertion de plusieurs pions'),
	assert(pion(1, 1, 1)),
	assert(pion(1, 2, 2)),
	testVidePlateau,
	( pion(Colonne, Ligne, Joueur) -> afficherFin('testVidePlateau', true, 'TEST ECHOUE');
	afficherFin('testVidePlateau', false, 'TEST REUSSI')).

testUtil5 :-
	afficherNomTest(testUtil5),
	afficherDebut('ajouterPion', true, 'Verifie qu un pion a bien ete ajoute'),
	assert(pion(1, 1, 1)),
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
	
%% Tests du fichier ia2FenouilSec.pl

testM1:-
	afficherNomTest(testM1),
	afficherDebut('PeutGagnerSurCol', true, 'Verifie que le predicat peutGagnerSurCol vérifie une colonne qui permet la victoire'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(3, 3, 1),
	(peutGagnerSurCol(3) -> afficherFin('peutGagnerSurCol', true, 'TEST REUSSI');
	afficherFin('peutGagnerSurCol', false, 'TEST ECHOUE')),
	testVidePlateau.

testM2:-
	afficherNomTest(testM2),
	afficherDebut('PeutGagnerSurCol', true, 'Verifie que le predicat peutGagnerSurCol ne vérifie pas une colonne qui ne permet pas la victoire.'),
	ajouterPion(3, 1, 1),
	ajouterPion(3, 2, 1),
	ajouterPion(3, 3, 1),
	(peutGagnerSurCol(4) ->afficherFin('peutGagnerSurCol', false, 'TEST ECHOUE');
 	afficherFin('peutGagnerSurCol', true, 'TEST REUSSI')),
	testVidePlateau.


testM3:-
	afficherNomTest(testM3),
	afficherDebut('peutGagner', true, 'Verifie que le predicat peutGagner trouve une colonne où une victoire est possible.'),
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	peutGagner(X,1),
	(X =:=1 ->afficherFin('peutGagner', true, 'TEST REUSSI');
 	afficherFin('peutGagner', false, 'TEST ECHOUE')),
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



%% Appel des tests

tests :-
	afficherTestsUnitaires,
	afficherNomTest('Fichier : util.pl'),
	testUtil1,
	testUtil2,
	testUtil3,
	testUtil4,
	testUtil5,
	afficherNomTest('Fichier : iaDefOff.pl'),
	testIaDefOff1,
	testIaDefOff2,
	afficherNomTest('Fichier : jouerCoup.pl'),
	testJouerCoup1,
	testJouerCoup2,
	testJouerCoup3,
	testJouerCoup4,
	afficherNomTest('Fichier : ia2FenouilSec.pl'),
	testM1,
	testM2,
	% testM3, ça merde à partir d'ici.
	afficherNomTest('Fichier : iaAleatoire.pl'),
	testIaAleatoire1,

	afficherTestsFonctionnels.
/*
% setup : permet d'effetuer des opérations avant que le test soit
%         lancé (exemple, remplir le plateau avec initialiserPlateau.
% cleanup : permet d'effetuer des opérations après que le test se soit
%           lancé (exemple, vider le plateau de jeu avec testVidePlateau.

% Tests unitaires

:- begin_tests(util).

test('du predicat incrementeX', 
	[ true(Reponse =:= 2) ]) :-
	incrementeX(1, Reponse).
	
test('du predicat decrementeX', [ true(Reponse =:= 2) ]) :-
	decrementeX(3, Reponse).
	
test('du predicat doubleInc pour incrementer deux variables', 
	[all(Reponse == [3, 4])]) :-
	doubleInc(2, 3, NewColonne, NewLigne),
	(Reponse = NewColonne ; Reponse = NewLigne).

% Apres avoir ajoute quelques pions, test si le plateau se vide
% correctement en appelant testVidePlateau. Ce test doit echouer.
test('du predicat testVidePlateau', 
	[ all(Reponse == []),
	  cleanup(testVidePlateau) ]) :-
	assert(pion(1, 1, 1)),
	assert(pion(1, 2, 2)),
	testVidePlateau,
	pion(Colonne, Ligne, Joueur),
	(Reponse = Colonne ; Reponse = Ligne ; Reponse = Joueur). 
	
% Test si il existe un pion a l'endroit ou ajouterPion doit avoir
% ajoute un pion. Ce test doit reussir.
test('du predicat ajouterPion',
	[ cleanup(testVidePlateau) ]) :-
	ajouterPion(1, 1, 1),
	pion(1, 1, _).
	
% Test si le plateau s initialise correctement 
test('du predicat initialiserPlateau',
	[ cleanup(testVidePlateau),
	  all(Reponse == [1, 0, -10, 2, 0, -10, 3, 0, -10, 4, 0, -10, 5, 0, -10, 6, 0, -10, 7, 0, -10, -10, -10, -10])]) :-
	initialiserPlateau,
	%testVidePlateau,
	pion(Colonne, Ligne, Joueur),
	(Reponse = Colonne ; Reponse = Ligne ; Reponse = Joueur).
	
:- end_tests(util).

:- begin_tests(finDeJeu).

% Le joueur 1 gagne sur la colonne 1
test('du predicat victoireColonne. Victoire du joueur 1 sur la colonne',
	[ cleanup(testVidePlateau) ]) :-
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(1, 4, 1),
	victoireColonne(1, 4, 1).
	
% Le joueur 2 ne gagne pas sur la colonne 1
test('du predicat victoireColonne. Pas de victoire sur la colonne pour le joueur 2',
	[ cleanup(testVidePlateau), fail ])
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(1, 4, 2),
	victoireColonne(1, 4, 2).
	
% On insère un pion à gauche et on vérifie que le predicat
% gauche le détecte bien.
% TODO : A FAIRE
	
% TODO : FAIRE LE TEST POUR LE PREDICAT droite

% Le joueur 2 gagne sur la ligne 2
test('du predicat victoireLigne. Victoire du joueur 2 sur la ligne',
	[ cleanup(testVidePlateau) ]) :-
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 2),
	victoireLigne(4, 2, 2).
	
% Le joueur 1 ne gagne pas sur la ligne 2
test('du predicat victoireLigne. Pas de victoire du joueur 1 sur la ligne',
	[ cleanup(testVidePlateau), fail ]) :-
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 1),
	victoireLigne(4, 2, 1).
	
:- end_tests(finDeJeu). */
