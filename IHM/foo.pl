:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('pionsFictifs.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('debug.pl').
:- include('evaluation.pl').
:- include('ia2FenouilSec').


combatIA :- tourIA1.

coupJoueur(X,Y,Z) :- ajouterPion(X,Y,Z),
					(gagne(X,Y,Z)-> victoire;coupIA).
