parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).
parent(bob,pat).
parent(pat,jim).

childs(Parent,[X|[]]) :- parent(Parent,X).
childs(Parent,[_|RC]) :- childs(Parent,RC).

/*1*/ predecessor1(X,Z) :-
          parent(X,Z).
/*2*/ predecessor1(X,Z) :-
          parent(X,Y),
          predecessor1(Y,Z).

/*3*/ predecessor2(X,Z) :-
          parent(X,Y),
          predecessor2(Y,Z).
/*4*/ predecessor2(X,Z) :-
          parent(X,Z).

/*5*/ predecessor3(X,Z) :-
          parent(X,Z).
/*6*/ predecessor3(X,Z) :-
          predecessor3(X,Y),
          parent(Y,Z).

/*7*/ predecessor4(X,Z) :-
          predecessor4(X,Y),
          parent(Y,Z).
/*8*/ predecessor4(X,Z) :-
          parent(X,Z).
