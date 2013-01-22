/*1*/ branch(a,b).
/*2*/ branch(a,c).
/*3*/ branch(c,d).
/*4*/ branch(c,e).

/*5*/ path(X,X).
/*6*/ path(X,Y) :-
         branch(X,Z),
         path(Z,Y).
