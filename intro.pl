board([4]).

play :- gameover,!

play :- board(X),
	display(X,)
	CoupIA(X,N),
	jouerCoup(X,Xnew,N),
	jouerMemoire(X,Xnew),
	play

jouerMemoire(X,Y) :- retract(Board(X)), assert(board(Y)).

gameover :- board(X), reverse(X,Xr), Xr = [1|_].

CoupIA(X,C) :- C is random(10).
