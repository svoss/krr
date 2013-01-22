% append has been renamed to conc
% as append is already built-in in
% SWI-Prolog (the same holds for concat)

conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
   conc(L1,L2,L3).
