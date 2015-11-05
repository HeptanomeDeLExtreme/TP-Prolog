/* ----------- IA complete ----------- */

% P is profondeur
iaComplet(J,X) :- minmax(5, J, _, X).

    
% Rules used to find a move using minmax algorithm
minmax(P, _, Value, _) :- P == 0, Value = 0, !.
minmax(P, J, Value, Coup) :-
    J == 2, aggregate_all(max(V, X), simulate(P, J, V, X), max(Value, Coup)), !.
minmax(P, J, Value, Coup) :-
    J == 1, aggregate_all(min(V, X), simulate(P, J, V, X), min(Value, Coup)), !.

    
%
simulate(P, J, Value, X) :-
    (playable(X),
        Coeff is 10-P,
        once((isTerminal(X, J, V), Value is Coeff*V ) 
        ; ((ajouterPion(X, _, J),  Pm is P - 1,
        ( J == 2, minmax(Pm, 1, Value, _) 
            ; J == 1, minmax(Pm, 2, Value, _)),
        remove(X) ; true )))   
    ; Value is 0
    ).

%Rules which return every column number where a pion can be inserted
playable(X) :- between(1, 7, X), once(not(pion(X, 6, _)) ; (X is 0, true)).

%Rule used to tell how many pion there is in a column (returned by Count)
height(X,Res) :- height2(X,Count),decrementeX(Count,Res).
height2(X, Count) :- aggregate_all(count, pion(X, _, _), Count).

%Rules allowing to remove a pion
remove(X) :- height(X, Count), retract(pion(X, Count, _)).

% A move is terminal if it is :
%   - a winning move
%   - the last move possible
isTerminal(X, J, Value) :- J == 1, height(X, Count), Y is Count+1, Y < 7, gagne(X, Y, 1), Value = -1000000, !.
isTerminal(X, J, Value) :- J == 2, height(X, Count), Y is Count+1, Y < 7, gagne(X, Y, 2), Value = 1000000, !.



