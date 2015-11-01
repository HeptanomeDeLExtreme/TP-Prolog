:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl').

/*affichageDebut(NomPredicat, SortieAttendue, Objectif) :-
	nl,
	writeln(['### Test du precidat ', NomPredicat, ' ###']),
	writeln(Objectif),
	writeln(['Sortie attendue : ', SortieAttendue]).*/
	
% setup : permet d'effetuer des opérations avant que le test soit
%         lancé (exemple, remplir le plateau avec initialiserPlateau.
% cleanup : permet d'effetuer des opérations après que le test se soit
%           lancé (exemple, vider le plateau de jeu avec viderPlateau.

% Tests unitaires

:- begin_tests(util).

test('du predicat incrementeX', [true(Reponse =:= 2)]) :-
	incrementeX(1, Reponse).

:- end_tests(util).

:- begin_tests(finDeJeu).

% Ajoute un pion à un endroit et regarde si la case est vide
% à cet endroit. Ce test doit échouer.	
test('du predicat caseVide sur une case pleine',
    [ cleanup(viderPlateau), fail ]):-
	assert(pion(1, 1, 1)),
	caseVide(1, 1).
	
% Ajout un pion à un endroit et regarde ailleurs si la case
% est vide. Ce test doit réussir.
test('du predicat caseVide sur une case vide', 
	[ cleanup(viderPlateau) ]):-
	assert(pion(1, 1, 1)),
	caseVide(1, 2).
	
:- end_tests(finDeJeu). 
	
