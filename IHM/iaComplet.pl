ia(X, Y, Color) :- minmax(5, Color, _, X), add(X, Y, Color).

%Rules allowing to add a pawn while preventing to insert pawn any old way which means :
%   - X and Y are in the correct range
%   - Y position is computed by incrementing the current nb of pawn in the column
%   - The computed value of Y is returned
add(X, Y, Color) :- 
    integer(X), X >= 1, X < 8,
    height(X, Count), Y is Count+1,
    integer(Y), Y >= 1, Y < 7,
    asserta(pawn(X, Y, Color)).
    
% Rules used to find a move using minmax algorithm
minmax(P, _, Value, _) :- P == 0, Value = 0, !.
minmax(P, Color, Value, Coup) :-
    Color == jaune, aggregate_all(max(V, X), simulate(P, Color, V, X), max(Value, Coup)), !.
minmax(P, Color, Value, Coup) :-
    Color == rouge, aggregate_all(min(V, X), simulate(P, Color, V, X), min(Value, Coup)), !.


%
simulate(P, Color, Value, X) :-
    (playable(X),
        Coeff is 10-P,
        once((isTerminal(X, Color, V), Value is Coeff*V ) 
        ; ((add(X, _, Color),  Pm is P - 1,
        ( Color == jaune, minmax(Pm, rouge, Value, _) 
            ; Color == rouge, minmax(Pm, jaune, Value, _)),
        remove(X) ; true )))   
    ; Value is 0
    ).

%Rules which return every column number where a pawn can be inserted
playable(X) :- between(1, 7, X), once(not(pawn(X, 6, _)) ; (X is 0, true)).

%Rule used to tell how many pawn there is in a column (returned by Count)
height(X, Count) :- aggregate_all(count, pawn(X, _, _), Count).

%Rules allowing to remove a pawn
remove(X) :- height(X, Count), retract(pawn(X, Count, _)).

% A move is terminal if it is :
%   - a winning move
%   - the last move possible
isTerminal(X, Color, Value) :- Color == rouge, height(X, Count), Y is Count+1, Y < 7, win(X, Y, rouge), Value = -1000000, !.
isTerminal(X, Color, Value) :- Color == jaune, height(X, Count), Y is Count+1, Y < 7, win(X, Y, jaune), Value = 1000000, !.



