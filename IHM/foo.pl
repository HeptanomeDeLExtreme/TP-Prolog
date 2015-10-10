%% pion(colonne,ligne,joueur).

%% pion(1,1,1).
%% pion(2,1,2).
%% pion(3,1,1).
%% pion(4,1,1).
%% pion(5,1,2).
%% pion(6,1,1).
%% pion(7,1,2).

%% Initialisation de la fenetre
init :- jpl_new( 'MainFrame', [], F),nb_setval('FENETRE',F).

%% Predicat pour faire le coup d'un joueur
coupJoueur(X,Y,Z) :- assert(pion(X,Y,Z)).

%% Predicat a appeler lorsqu'on veut rafraichir le plateau
print :- nb_getval('FENETRE',F),jpl_call( F, print, [], _).

%% Predicat a appeler en cas de victoire 
victoire :- nb_getval('FENETRE',F),jpl_call( F, victoire, [], _).

%% Predicat a appeler en cas d'echec
echec :- nb_getval('FENETRE',F),jpl_call( F, echec, [], _).