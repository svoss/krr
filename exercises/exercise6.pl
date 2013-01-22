end(s3).

transition(s1,a,s1).
transition(s1,a,s2).
transition(s1,b,s1).
transition(s2,b,s3).
transition(s3,b,s4).

silent(s4,s3).

accept(S,[]) :-
    end(S).
accept(S,[X|Rest]) :-
    transition(S,X,S1),
    accept(S1,Rest).
accept(S,String) :-
    silent(S,S1),
    accept(S1,String).
