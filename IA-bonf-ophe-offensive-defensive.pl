:- dynamic pion/3.
:- dynamic dernpion/3.

%% pion(c,l,j).

% Test : Ajout d'un pion sur le haut de la colonne 1
% Chemin de 3 sur la colonne 1
%pion(1,1,1).
%pion(1,2,1).
%pion(1,3,1).

% Test : Ajout d'un pion à gauche de la ligne 1
% Chemin de 3 sur la ligne 1
%pion(5,1,1).
%pion(6,1,1).
%pion(7,1,1).

% Test : Ajout d'un pion à droite de la ligne 1
% Chemin de 3 sur la ligne 1
%pion(1, 1, 1).
%pion(2, 1, 1).
%pion(3, 1, 1).

% Test : Ajout d'un pion sur le haut de la colonne 2
%pion(2, 1, 1).
%pion(2, 2, 1).

% Test : Ajout d'un pion sur la gauche de la ligne 1
%pion(2, 1, 1).
%pion(3, 1, 1).

% Test : Ajout d'un pion du Joueur 1 sur la droite de la ligne 2
%pion(1, 1, 2).
%pion(2, 1, 2).
%pion(1, 2, 1).
%pion(2, 2, 1).
%pion(3, 1, 1).

% Incrémentation
incrementerX(X,X1):- X1 is X+1.

% Décrémentation
decrementerX(X,X1):- X1 is X-1.

% Mise à jour du dernier pion dans la base de faits
majDernierPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    nonvar(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).
majDernierPion(NumeroColonne, NumeroLigneSuivant, Joueur):-
    retract(dernpion(_,_,_)),
    assert(dernpion(NumeroColonne, NumeroLigneSuivant, Joueur)).

% Ajoute le pion dans la base de faits
ajouterPion(NumeroColonne, NumeroLigneSuivant, Joueur) :-
    assert(pion(NumeroColonne, NumeroLigneSuivant, Joueur)),
    majDernierPion(NumeroColonne, NumeroLigneSuivant, Joueur).
    
% Trouve tous les pions du plateau
findAllPion(Joueur, ListePion) :- 
    findall([Colonne, Ligne], pion(Colonne, Ligne, Joueur), ListePion), write(ListePion).

% Parcourir la liste colonne
% Permet de parcourir la liste représentant les chemins de pions en colonne.
% Ajoute le pion au-dessus du chemin, à la première occurence de chemin trouvée
% lorsqu'il n'y a pas de pions au-dessus du chemin et que l'ajout du pion se 
% fait dans le plateau de jeu (Ligne1 < 7).
parcoursListeColonne([], Joueur) :- true.
parcoursListeColonne([[Colonne,Ligne]|Queue], Joueur) :- 
    incrementerX(Ligne, Ligne1), 
    (nonvar(pion(Colonne, Ligne1, Joueur)), Ligne1<7->ajouterPion(Colonne, Ligne1, Joueur) ; parcoursListeColonne(Queue, Joueur)).

% Parcourir la liste ligne
% Permet de parcourir la liste représentant les chemins de pions en ligne.
% Ajoute le pion à gauche si c'est possible pour le premier chemin trouvé,
% sinon, essaye d'ajouter à droite. Si ces deux essais sont infructeux,
% on continue de parcourir la liste pour tenter d'ajouter les pions sur les
% autres chemins.
% "Si c'est possible" : ajoute s'il n'y a pas de pion à l'endroit analysé,
% ou si le pion est bien sur le plateau (0 < X < 8). Il faut voir s'il y
% a un pion juste au-dessous de l'endroit où on souhaite mettre le pion.
parcoursListeLigne([], Joueur) :- true.
parcoursListeLigne([[Ligne, ColonneGauche, ColonneDroite]|Queue], Joueur) :-
    tenterAjoutAGauche(Ligne, ColonneGauche, Joueur).
parcoursListeLigne([[Ligne, ColonneGauche, ColonneDroite]|Queue], Joueur) :-
    tenterAjoutADroite(Ligne, ColonneDroite, Joueur).
parcoursListeLigne([[Ligne, ColonneGauche, ColonneDroite]|Queue], Joueur) :-
    parcoursListeLigne(Queue, Joueur).

% Permet de vérifier si un pion est bien en-dessous du futur pion qu'on
% souhaite ajouter pour faire une ligne
verificationPionDessous(ColonnePionAAjouter, LigneDuChemin) :-
    LigneDuChemin == 1. % Pion vide à gauche/droite déjà vérifié
verificationPionDessous(ColonnePionAAjouter, LigneDuChemin) :-
    LigneDuChemin \== 1,
    decrementerX(LigneDuChemin, LigneDessous),
    LigneDessous > 0,
    nonvar(pion(ColonnePionAAjouter, LigneDessous, _)).

% Permet d'essayer d'ajouter le pion à gauche du chemin en ligne déjà présent
tenterAjoutAGauche(Ligne, ColonneGauche, Joueur) :-
    decrementerX(ColonneGauche, CaseAGaucheDuChemin),
    nonvar(pion(CaseAGaucheDuChemin, Ligne, _)),
    CaseAGaucheDuChemin > 0,
    verificationPionDessous(CaseAGaucheDuChemin, Ligne),
    ajouterPion(CaseAGaucheDuChemin, Ligne, Joueur).

% Permet d'essayer d'ajouter le pion à droite du chemin en ligne déjà présent
tenterAjoutADroite(Ligne, ColonneDroite, Joueur) :-
    incrementerX(ColonneDroite, CaseADroiteDuChemin),
    nonvar(pion(CaseADroiteDuChemin, Ligne, _)),
    CaseADroiteDuChemin < 8,
    verificationPionDessous(CaseADroiteDuChemin, Ligne),
    ajouterPion(CaseADroiteDuChemin, Ligne, Joueur).

% Permet de trouver tous les chemins présents de longueur 3 dans les colonnes 
% pour un Joueur donné.
% Ce prédicat retourne une liste de coordonnées de pions. Le pion représente le
% pion le plus haut dans un chemin en colonne.
% Xcolonne : n° de la colonne.
% Ycolonne : n° de la ligne.
findCheminsColonne3(Joueur, ListeColonne) :-
    findall([Xcolonne, Ycolonne], (pion(Xcolonne, Ycolonne, Joueur), decrementerX(Ycolonne, Y1colonne), pion(Xcolonne, Y1colonne, Joueur), decrementerX(Y1colonne, Y2colonne), pion(Xcolonne, Y2colonne, Joueur)), ListeColonne), write(ListeColonne).

% Permet de trouver tous les chemins présents de longueur 2 dans les colonnes
% pour un Joueur donné.
% Mêmes remarques que pour findCheminsColonne3
findCheminsColonne2(Joueur, ListeColonne) :-
    findall([Colonne, Ligne], (pion(Colonne, Ligne, Joueur), decrementerX(Ligne, Ligne1), pion(Colonne, Ligne1, Joueur)), ListeColonne), write(ListeColonne).

% TODO : findCheminsColonne1

% Permet de trouver tous les chemins présents de longueur 3 dans les lignes
% pour un Joueur donné.
% Ce prédicat retourne une liste représentant un chemin en ligne (les bouts
% du chemin à droite et à gauche, ainsi que le numéro de ligne).
% Colonne : n° de colonne (pion de gauche du chemin)
% Colonne2 : n° de colonne (pion de droite du chemin)
% Ligne : n° de ligne
findCheminsLigne3(Joueur, ListeLigne) :-
    findall([Ligne, Colonne2, Colonne], (pion(Colonne, Ligne, Joueur), decrementerX(Colonne, Colonne1), pion(Colonne1, Ligne, Joueur), decrementerX(Colonne1, Colonne2), pion(Colonne2, Ligne, Joueur)), ListeLigne), write(ListeLigne).

% Permet de trouver tous les chemins présents de longueur 2 dans les lignes
% pour un Joueur donné.
% Mêmes remarques que pour findCheminsLigne3.
findCheminsLigne2(Joueur, ListeLigne) :-
    findall([Ligne, Colonne1, Colonne],(pion(Colonne, Ligne, Joueur), decrementerX(Colonne, Colonne1), pion(Colonne1, Ligne, Joueur)), ListeLigne), write(ListeLigne).

% TODO : findCheminsLigne1

% Trouver tous les chemins de longueur 3 (Colonnes + Lignes + Diagonales)
findAllPath3(Joueur, ListeColonne, ListeLigne) :-
    % Trouver les colonnes de longueur 3
    findCheminsColonne3(Joueur, ListeColonne),
    % Trouver les lignes de longueur 3
    findCheminsLigne3(Joueur, ListeLigne).
    % TODO : Trouver les diagonales gauches de longueur 3
    % TODO : Trouver les diagonales droites de longueur 3

% Trouver tous les chemins de longueur 2 (Colonnes + Lignes + Diagonales)
findAllPath2(Joueur, ListeColonne, ListeLigne) :-
    % Trouver les colonnes de longueur 2
    findCheminsColonne2(Joueur, ListeColonne),
    % Trouver les lignes de longueur 2
    findCheminsLigne2(Joueur, ListeLigne).
    % TODO : Trouver les diagonales gauches de longueur 2
    % TODO : Trouver les diagonales droites de longueur 2

% TODO : findAllPath1

%% Test l ajout d un pion pour les chemins de longueur 3
testLength3(Joueur) :-
    findAllPath3(Joueur, ListeColonne, ListeLigne),
    parcoursListeColonne(ListeColonne, Joueur),
    parcoursListeLigne(ListeLigne, Joueur).

%% Test l'ajout d'un pion pour les chemins de longueur 2
testLength2(Joueur) :-
    findAllPath2(Joueur, ListeColonne, ListeLigne),
    parcoursListeColonne(ListeColonne, Joueur),
    parcoursListeLigne(ListeLigne, Joueur).    

%% Test l'ajout d'un pour pour les chemins de longueur 1
testLength1(Joueur) :-
    findAllPath1(Joueur, ListeColonne, ListeLigne),
    parcoursListeColonne(ListeColonne, Joueur),
    parcoursListeLigne(ListeLigne, Joueur).

% Permet de tester si les listes sont vides pour analyser d'autres chemins
% plus petits
% TODO : testListesVides, si toutes les listes sont vides, renvoyer false.

% Structure pour utiliser l'IA offensive
% Retourne le numéro de colonne sur lequel l'IA doit jouer : Colonne.
% TODO : Modifier les prédicats existants pour récupérer la colonne.
% On enverra ensuite à jouerCoup les paramètres Colonne et NumeroJoueurIA
iaOffensive(NumeroJoueurIA, Colonne) :-
    % Trouver les chemins de longueur 3
    findAllPath3(NumeroJoueurIA, ListeColonne, ListeLigne),
    % Parcourir ces listes jusqu'à trouver une place pour un pion, s'il n'y
    % a aucun chemin, il faut passer aux autres chemins plus petits
    % TODO : testListesVides.
    parcoursListeColonne(ListeColonne, NumeroJoueurIA),
    parcoursListeLigne(ListeLigne, NumeroJoueurIA).
iaOffensive(NumeroJoueurIA) :-
    % Trouver les chemins de longueur 2
    findAllPath2(NumeroJoueurIA, ListeColonne, ListeLigne),
    % TODO : testListesVides.
    parcoursListeColonne(ListeColonne, NumeroJoueurIA),
    parcoursListeLigne(ListeLigne, NumeroJoueurIA).
iaOffensive(NumeroJoueurIA) :-
    % Trouver les chemins de longueur 1
    findAllPath1(NumeroJoueurIA, ListeColonne, ListeLigne)
    % TODO : testListesVides.
    parcoursListeColonne(ListeColonne, NumeroJoueurIA),
    parcoursListeLigne(ListeLigne, NumeroJoueurIA).
iaOffensive(NumeroJoueurIA) :-
    % TODO : Faire un coup random avec l'IA random si aucun chemin n'existe.
    .

% Structure pour utiliser l'IA défensive
% Retourne le numéro de colonne sur lequel l'IA doit jouer : Colonne.
% TODO : Modifier les prédicats existants pour récupérer la colonne.
% On enverra ensuite à jouerCoup les paramètres Colonne et (3 - NumeroJoueurIA) 
iaDefensive(NumeroJoueurEnFace, Colonne) :-
    % Trouver les chemins de longueur 3
    findAllPath3(NumeroJoueurEnFace, ListeColonne, ListeLigne),
    % Parcourir ces listes jusqu'à trouver une place pour un pion, s'il n'y
    % a aucun chemin, il faut passer aux autres chemins plus petits
    % TODO : testListesVides.
    parcoursListeColonne(ListeColonne, NumeroJoueurEnFace),
    parcoursListeLigne(ListeLigne, NumeroJoueurEnFace).
iaDefensive(NumeroJoueurEnFace) :-
    % Trouver les chemins de longueur 2
    findAllPath2(NumeroJoueurEnFace, ListeColonne, ListeLigne),
    % TODO : testListesVides.
    parcoursListeColonne(ListeColonne, NumeroJoueurEnFace),
    parcoursListeLigne(ListeLigne, NumeroJoueurEnFace).
iaDefensive(NumeroJoueurEnFace) :-
    % Trouver les chemins de longueur 1
    findAllPath1(NumeroJoueurEnFace, ListeColonne, ListeLigne)
    % TODO : testListesVides.
    parcoursListeColonne(ListeColonne, NumeroJoueurEnFace),
    parcoursListeLigne(ListeLigne, NumeroJoueurEnFace).
iaDefensive(NumeroJoueurEnFace) :-
    % TODO : Faire un coup random avec l'IA random si aucun chemin n'existe.
    .
