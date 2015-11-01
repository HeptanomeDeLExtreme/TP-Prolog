:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl').
	
% setup : permet d'effetuer des opérations avant que le test soit
%         lancé (exemple, remplir le plateau avec initialiserPlateau.
% cleanup : permet d'effetuer des opérations après que le test se soit
%           lancé (exemple, vider le plateau de jeu avec viderPlateau.

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
% correctement en appelant viderPlateau. Ce test doit echouer.
test('du predicat viderPlateau', 
	[ all(Reponse == []),
	  cleanup(viderPlateau) ]) :-
	assert(pion(1, 1, 1)),
	assert(pion(1, 2, 2)),
	viderPlateau,
	pion(Colonne, Ligne, Joueur),
	(Reponse = Colonne ; Reponse = Ligne ; Reponse = Joueur). 
	
% Test si il existe un pion a l'endroit ou ajouterPion doit avoir
% ajoute un pion. Ce test doit reussir.
test('du predicat ajouterPion',
	[ cleanup(viderPlateau) ]) :-
	ajouterPion(1, 1, 1),
	pion(1, 1, _).
	
% Test si le plateau s initialise correctement 
test('du predicat initialiserPlateau',
	[ cleanup(viderPlateau),
	  all(Reponse == [1, 0, -10, 2, 0, -10, 3, 0, -10, 4, 0, -10, 5, 0, -10, 6, 0, -10, 7, 0, -10, -10, -10, -10])]) :-
	initialiserPlateau,
	%viderPlateau,
	pion(Colonne, Ligne, Joueur),
	(Reponse = Colonne ; Reponse = Ligne ; Reponse = Joueur).
	
:- end_tests(util).

:- begin_tests(finDeJeu).

% Le joueur 1 gagne sur la colonne 1
test('du predicat victoireColonne. Victoire du joueur 1 sur la colonne',
	[ cleanup(viderPlateau) ]) :-
	ajouterPion(1, 1, 1),
	ajouterPion(1, 2, 1),
	ajouterPion(1, 3, 1),
	ajouterPion(1, 4, 1),
	victoireColonne(1, 4, 1).
	
% Le joueur 2 ne gagne pas sur la colonne 1
test('du predicat victoireColonne. Pas de victoire sur la colonne pour le joueur 2',
	[ cleanup(viderPlateau), fail ])
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
	[ cleanup(viderPlateau) ]) :-
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 2),
	victoireLigne(4, 2, 2).
	
% Le joueur 1 ne gagne pas sur la ligne 2
test('du predicat victoireLigne. Pas de victoire du joueur 1 sur la ligne',
	[ cleanup(viderPlateau), fail ]) :-
	ajouterPion(1, 2, 2),
	ajouterPion(2, 2, 2),
	ajouterPion(3, 2, 2),
	ajouterPion(4, 2, 1),
	victoireLigne(4, 2, 1).
	
:- end_tests(finDeJeu). 
