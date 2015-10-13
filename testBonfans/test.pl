
isolerColonneIJoueurX(I,X, Colonne) :-
    findall(pion(I, Y, X), pion(I, Y, X), Colonne).
    
%%isolerLigneIJoueurX(I,X,Ligne) :- findall(pion(Y, I, X), pion(Y, I, X), Ligne).

cheminColonne(I,X) :- isolerColonneIJoueurX(I,X, Colonne),length(Colonne,T),write(T),( T == 4 -> victoire;echec). 

victoire :- write('Victoire').

echec :- write('Echec').

pion(1,1,1).
pion(1,2,1).
pion(1,3,2).
pion(1,4,1).
pion(1,5,1).


