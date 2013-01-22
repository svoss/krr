element1(X,[X|_]).
element1(X,[_|Y]) :-
     element1(X,Y).

all_elements1(L) :-
     element1(X,L),
     write(X),
     nl,
     fail.
all_elements1(_).

element2(X,[X|_]) :- !.
element2(X,[_|Y]) :-
     element2(X,Y).

all_elements2(L) :-
     element2(X,L),
     write(X),
     nl,
     fail.
all_elements2(_).
