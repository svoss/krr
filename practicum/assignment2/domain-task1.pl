% ------------------------- Domain Definition -------------------------
% This file describes a planning domain: a set of predicates and
% fluents that describe the state of the system, a set of actions and
% the axioms related to them. More than one problem can use the same
% domain definition, and therefore include this file


% --- Cross-file definitions ------------------------------------------
% marks the predicates whose definition is spread across two or more
% files
%
% :- multifile name/#, name/#, name/#, ...

:- multifile agentAt/2, blockAt/3. %clear/2.


% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
% primitive_action( dosomething(_,_) ).	% underscore means `anything'

primitive_action( move(_ ,_) ).
primitive_action( push(_,_,_) ).

% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
% poss( doSomething(...), S ) :- preconditions(..., S).

% de preconditions.
poss( move(X, Y), S ) :-
 connected(X,Y,_),
 not(blockAt(_,Y,S)),
 agentAt(X,S).
 
 
 
poss( push(Box, Y, Z), S ) :-
 connected(Y, Z, D),
 connected(X, Y, D),
 blockAt(Box,Y,S),
 not(blockAt(_,Z,S)),
 agentAt(X, S).
  
% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan. 
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)


agentAt(Y, result(A, S)) :-
	A = push(_,Y,_); %agent moves via pus action
	A = move(_, Y) ; %agent moves via move action
	
	agentAt(Y, S), not(A = move(Y,_) ; A = push(_,_,_)). % agent already is there
	
blockAt(Box, Loc, result(A, S)) :-
	A = push(Box,_, Loc),not(blockAt(Box, Loc, S));
	blockAt(Box, Loc, S) , not(A=push(Box,Loc,_)).
	
%clear(Loc, result(A,S)) :-
%	A = push(_,Loc,_), not(blockAt(Loc,S));
%	 not(A=push(_,_,Loc)), blockAt(Loc,S).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
