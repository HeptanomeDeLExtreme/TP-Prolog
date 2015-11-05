:- include('finDeJeu.pl').
:- include('iaAleatoire.pl').
:- include('iaDefOff.pl').
:- include('util.pl').
:- include('pionsFictifs.pl').
:- include('IHM.pl').
:- include('jouerCoup.pl').
:- include('evaluation.pl').
:- include('iaMixte').

%% Predicat appelé par l'IHM lorsqu'on demande un combat IA vs Ia
combatIA :- tourIA1.

%% Predicat appelé par l'IHM lorsqu'un humain à joué un coup
coupJoueur(X,Y,Z) :- ajouterPion(X,Y,Z),
					(gagne(X,Y,Z)-> victoire;coupIA).
