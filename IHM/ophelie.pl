:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl').


affichePrologue(NomPredicat,SortieAttendue, Objectif) :- 
	writeln(['### Test du precidat ', NomPredicat, ' ###']),
	writeln(Objectif),
	writeln(['Sortie attendue : ', SortieAttendue]).
	
afficheSortie(Sortie,FailOrNot) :-
	writeln(['Sortie obtenue : ',Sortie]),
	writeln(FailOrNot).

test1 :- affichePrologue('caseVide','false','Appel de caseVide sur une case ou il y a un pion'),
	assert(pion(1,1,1)),
	(caseVide(1,1)-> afficheSortie('true','Echec');
	afficheSortie('false','Reussi')
	).
