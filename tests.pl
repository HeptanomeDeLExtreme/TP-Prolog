/* ----------- Tests ----------- */


:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('evaluation.pl').
:- include('iaMixte.pl').
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
	
	/* TEST A REVOIR TRES CERTAINEMENT - LA SORTIE EST 3 MAIS JE NE COMPENDS PAS PK*/
testIaDefOff7 :- 
	afficherNomTest(testIaDefOff7),
	afficherDebut('parcoursListeLigne', true, 'Verifie que le predicat renvoie la premiere ligne qui n est pas remplie'),
	% Une liste représentant le sommet de la colonne 1, le sommet de la colonne 2 et le sommet de la colonne 3
	parcoursListeLigne([[1, 1, 2], [1, 2, 3], [2, 1, 2]], 1, Colonne),
	% writeln(['Colonne :', Colonne] ),
	( Colonne =:= 3 -> afficherFin('parcoursListeLigne', true, 'TEST REUSSI');
	afficherFin('parcoursListeLigne', false, 'TEST ECHOUE')),
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

tests :-
	afficherTestsUnitaires,
	afficherNomTest('Fichier : util.pl'),
	testUtil1,
	testUtil2,
	testUtil3,
	testUtil4,
	testUtil5,
	afficherNomTest('Fichier : iaDefOff.pl'),
	%testIaDefOff1,
	%testIaDefOff2,
	%testIaDefOff3,
	%testIaDefOff4,
	%testIaDefOff5,
	%testIaDefOff6,
	%testIaDefOff7,
	afficherNomTest('Fichier : jouerCoup.pl'),
	testJouerCoup1,
	testJouerCoup2,
	testJouerCoup3,
	testJouerCoup4,
	afficherNomTest('Fichier : iaMixte.pl'),
	testM1,
	testM2,
	testM3,
	testM4,
	testM5,
	afficherNomTest('Fichier : iaAleatoire.pl'),
	testIaAleatoire1,
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
