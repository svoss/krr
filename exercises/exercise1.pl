/*1*/ element(X,[X|_]).
/*2*/ element(X,[_|Y]) :-
         element(X,Y).
