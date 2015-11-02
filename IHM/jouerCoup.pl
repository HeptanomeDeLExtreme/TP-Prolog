/* ----------- Ophelie et Cedric ----------- */
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

indexDernierPion(Colonne, NumeroLigne) :-
	(Colonne = []-> NumeroLigne is 0;last(Colonne, pion(_, NumeroLigne, _))).
    
calculProchainepion(NumeroLigne, NumeroLigneSuivant) :-
    NumeroLigneSuivant is NumeroLigne + 1.
    
    
jouerCoup([NumeroColonne, Joueur]) :-
    isolerColonne(NumeroColonne, Colonne),
    indexDernierPion(Colonne, NumeroLigne),
    calculProchainepion(NumeroLigne, NumeroLigneSuivant),
    ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    











