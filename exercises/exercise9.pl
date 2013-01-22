sentence(X) :- noun_phrase(X,Y),
               verb_phrase(Y,[]).

noun_phrase([X|Y],Y) :-
          noun(X).
noun_phrase([X1,X2,X3|Y],Y) :-
          article(X1),
          adjective(X2),
          noun(X3).

verb_phrase([X|Y],Z) :-
          verb(X),
          noun_phrase(Y,Z).
