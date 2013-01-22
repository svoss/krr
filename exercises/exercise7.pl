/* Again append has been renamed to conc in order to prevent
   a clash with the built-in predicate append in SWI-Prolog */

bubsort(L,S) :-
       conc(X,[A,B|Y],L),
       B < A,
       conc(X,[B,A|Y],M),
       !,
       bubsort(M,S).
bubsort(L,L).
 
conc([],L,L).
conc([H|T],L,[H|V]) :-
   conc(T,L,V).
