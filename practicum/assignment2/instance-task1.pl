% ------------------------- Problem Instance --------------------------
% This file is a template for a problem instance: the definition of an
% initial state and of a goal. 
	% need additional debug information at runtime?


% --- Load domain definitions from an external file -------------------

:- [planner].
:- ['domain-task1'].		% Replace with the domain for this problem


% --- Definition of the initial state ---------------------------------

% position of the agent.
agentAt(loc3x3,s0).

% position of the crates.
blockAt(a,loc2x2,s0).
blockAt(b,loc2x3,s0).
blockAt(c,loc2x4,s0).

clear(loc1x1,s0).
clear(loc2x1,s0).
clear(loc3x2,s0).
clear(loc3x3,s0).
clear(loc3x4,s0).

% all the connections between the locations: connection(a,b,direction).

connected(loc1x1,loc1x2,s).
connected(loc1x1,loc2x1,e).
connected(loc1x2,loc1x3,s).
connected(loc1x2,loc1x1,n).
connected(loc1x2,loc2x2,e).
connected(loc1x3,loc1x4,s).
connected(loc1x3,loc1x2,n).
connected(loc1x3,loc2x3,e).
connected(loc1x4,loc1x3,n).
connected(loc1x4,loc2x4,e).
connected(loc2x1,loc2x2,s).
connected(loc2x1,loc1x1,w).
connected(loc2x2,loc2x3,s).
connected(loc2x2,loc2x1,n).
connected(loc2x2,loc3x2,e).
connected(loc2x2,loc1x2,w).
connected(loc2x3,loc2x4,s).
connected(loc2x3,loc2x2,n).
connected(loc2x3,loc3x3,e).
connected(loc2x3,loc1x3,w).
connected(loc2x4,loc2x3,n).
connected(loc2x4,loc3x4,e).
connected(loc2x4,loc1x4,w).
connected(loc3x2,loc3x3,s).
connected(loc3x2,loc2x2,w).
connected(loc3x3,loc3x4,s).
connected(loc3x3,loc3x2,n).
connected(loc3x3,loc2x3,w).
connected(loc3x4,loc3x3,n).
connected(loc3x4,loc2x4,w).

% --- Goal condition that the planner will try to reach ---------------

goal(S) :- blockAt(a,loc1x3,S), blockAt(b,loc1x2,S), blockAt(c,loc1x4,S).					% fill in the goal definition
%goal(S) :- blockAt(c,loc1x4,S), blockAt(a,loc1x2,S).
%goal(S) :- blockAt(a,loc1x2,S).


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
