% The five types of regions that can appear in an image
region(grass). region(water). region(pavement).
region(house). region(vehicle).
% small(X) holds when region X can be small in an image.
small(vehicle).
% regular(X) holds when region X can be regular in an image.
regular(pavement). regular(house). regular(vehicle).
% border(X,Y) holds when region X can border region Y.
border(X,Y) :- \+ bad_border(X,Y), \+ bad_border(Y,X).
% Unacceptable borders
bad_border(X,X).
bad_border(house,water).
bad_border(vehicle,X) :- \+ X=pavement.
% inside(X,Y) holds when region X can be surrounded by Y.
inside(X,Y) :- \+ bad_inside(X,Y).
% Unacceptable containment
bad_inside(X,X).
bad_inside(house,water).
bad_inside(vehicle,X) :- \+ X=pavement.
bad_inside(pavement,_).

solution(R1,R2,R3,R4,R5) :-
region(R1), region(R2), region(R3), region(R4), region(R5),
% Size constraints
\+ small(R1), \+ small(R2), \+ small(R3),
\+ small(R4), small(R5),
% Regularity constraints (none for R4)
regular(R3), regular(R5), \+ regular(R2), \+ regular(R1),
% Border constraints
border(R1,R2), border(R2,R4),
% Containment constraints
inside(R3,R2), inside(R5,R4).
% The definitions of region, small, border, etc. are elsewhere.