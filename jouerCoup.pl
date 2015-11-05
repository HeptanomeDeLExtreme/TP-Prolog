/* ----------- Jouer Coup ----------- */

%% Met tout les pions de la colonne NumeroColonne dans la liste Colonne
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

%% Unifie NumeroLigne à la ligne du dernier pion dans la colonne Colonne
indexDernierPion(Colonne, NumeroLigne) :-
	(Colonne = []-> NumeroLigne is 0;last(Colonne, pion(_, NumeroLigne, _))).
    
%% Unifie NumeroLigneSuivant à NumeroLigne + 1
calculProchainepion(NumeroLigne, NumeroLigneSuivant) :-
    NumeroLigneSuivant is NumeroLigne + 1.
    
%% Ajoute un pion pour sur la colonne NumeroColonne
%% Pour le joueur Joueur
jouerCoup([NumeroColonne, Joueur]) :-
    isolerColonne(NumeroColonne, Colonne),
    indexDernierPion(Colonne, NumeroLigne),
    calculProchainepion(NumeroLigne, NumeroLigneSuivant),
    ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    











