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

% Tests unitaires

:- begin_tests(finDeJeu).
	
test(caseVide, [fail]):-
	% affichageDebut('1) caseVide', 'false', 'Un pion est insere en Colonne = 1 et Ligne = 1. Cette case est donc prise.'),
	initialiserPlateau,
	assert(pion(1, 1, 1)),
	caseVide(1, 1),
	viderPlateau.
	
test(caseVide, [not(fail)]):-
	% affichageDebut('2) caseVide', 'true', 'Un pion a ete insere en Colonne = 1 et Ligne = 1. La case Colonne = 1 et Ligne =  par exemple est vide.'),
	initialiserPlateau,
	assert(pion(1, 1, 1)),
	caseVide(1, 2),
	viderPlateau.
	
:- end_tests(finDeJeu). 
