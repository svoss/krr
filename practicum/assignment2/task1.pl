% ------------------- Sample of a planning problem --------------------

% define the following predicate to print out extended information
% about the planning process at runtime. Will produce A LOT of text
% after the first 4-5 iterations, since it shows all the plans
% considered by the program!

debug(on).

% -- Include domain definitions from sample-blocks-domain.pl

:- ['domain-task1'].

% -- Define the initial state: the necessary set of eternal predicates
% and fluents that describe the situation at the beginning of the run

% positions of the agent.
at(agent,loc3-2,s0).

% position of the crates.
at(a,loc2-3,s0).
at(b,loc2-2,s0).
at(c,loc2-1,s0).

% all the connections between the locations: connection(a,b,direction).
connected(loc1-1,loc2-1,e).
connected(loc1-2,loc1-3,n).
connected(loc1-2,loc2-2,e).
connected(loc1-1,loc1-2,n).
connected(loc1-2,loc1-1,s).
connected(loc1-3,loc1-4,n).
connected(loc1-3,loc2-3,e).
connected(loc1-3,loc1-2,s).
connected(loc1-4,loc2-4,e).
connected(loc1-4,loc1-3,s).
connected(loc2-1,loc1-1,w).
connected(loc2-1,loc2-2,n).
connected(loc2-1,loc3-1,e).
connected(loc2-2,loc2-3,n).
connected(loc2-2,loc3-2,e).
connected(loc2-2,loc2-1,s).
connected(loc2-2,loc1-2,w).
connected(loc2-3,loc2-4,n).
connected(loc2-3,loc3-3,e).
connected(loc2-3,loc2-2,s).
connected(loc2-3,loc1-3;w).
connected(loc3-4,loc2-3,s).
connected(loc3-4,loc1-4,w).
connected(loc3-1,loc3-2,n).
connected(loc3-1,loc2-1,w).
connected(loc3-2,loc3-3,n).
connected(loc3-2,loc3-1,s).
connected(loc3-2,loc2-2,w).
connected(loc3-3,loc3-2,s).
connected(loc3-3,loc2-3,w).

% -- Last, the goal condition that the planner will try to reach

goal(S) :- at(a,loc1-2,S), at(b,loc1-3,S), at(c,loc1-1,S).

% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
