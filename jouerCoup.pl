/* Declarer les predicats dynamiques */
:- dynamic
    pion/3.
    
/* Base de faits :
pion(Colonne, Ligne, {1|2}). */

pion(1, 1, 1).
pion(1, 2, 1).
pion(1, 3, 2).
pion(1, 4, 2).
    
/* IsolerColonne permet de prendre uniquement la colonne
que le joueur/IA aura joue */
isolerColonne(NumeroColonne, Colonne) :-
    findall(pion(NumeroColonne, NumeroLigne, Joueur), pion(NumeroColonne, NumeroLigne, Joueur), Colonne).

/* Permet de recuperer le numero de ligne du dernier pion qui aura ete joue */
indexDernierPion(Colonne, NumeroLigne) :-
    last(Colonne, pion(_, NumeroLigne, _)).
    
/* Permet de savoir s_il reste encore de la place dans la colonne */
/* DEMANDER UN NOUVEL INPUT A L IA/LE JOUEUR */
colonneIndisponible(NumeroLigne, X, Xnew) :-
    NumeroLigne = 6, jouerCoup(X, Xnew, [1, 2]).

% Permet de connaitre la prochaine case a remplir dans le graphe %
calculProchaineCase(NumeroLigne, NumeroLigneSuivant) :-
    NumeroLigneSuivant is NumeroLigne + 1.
    
% Permet d ajouter le pion dans la base de faits %
% NumeroLignePlus1 represente le fait d ajouter en haut de la colonne
% selectionne par le joueur / l IA le pion.
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)).
    
/* X represente l ancien tableau de jeu
Xnew represente le nouveau tableau avec le coup joue
N represente un tableau avec [colonneSelectionnee, numeroJoueur]
jouerCoup est une disjonction car il existe deux possibilites :
- La colonne n est pas disponible pour recevoir un autre jeton. Du coup,
il faut relancer demander un autre coup et relancer "jouerCoup".
- La colonne est disponible pour recevoir un jeton supplementaire.
Dans ce cas il faut simplement ajouter le pion dans le tableau. */

% Cas ou la colonne est indisponible %
jouerCoup(X, Xnew, [NumeroColonne, Joueur]) :-
    /* Isoler la colonne jouee */
    isolerColonne(NumeroColonne, Colonne),
    
    /* Recuperer l index de la prochaine case vide */
    indexDernierPion(Colonne, NumeroLigne),
    
    /* Si la colonne est n est pas pleine, nous pouvons ajouter le nouveau coup
    dans la colonne */
    colonneIndisponible(NumeroLigne, X, Xnew).
    
% Cas ou la colonne est disponible %
jouerCoup(X, Xnew, [NumeroColonne, Joueur]) :-
    /* Isoler la colonne jouee */
    isolerColonne(NumeroColonne, Colonne),
    
    /* Recuperer l index de la prochaine case vide */
    indexDernierPion(Colonne, NumeroLigne),
    
    % Si on passe dans ce predicat, c est que la colonne est disponible
    % pour recevoir un pion (en effet, le predicat colonneIndisponible
    % retourne faux !). Pas besoin de retester la disponibilite de la colonne.
    % Donc on ajoute le pion dans la base de faits
    calculProchaineCase(NumeroLigne, NumeroLigneSuivant),
    ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    
