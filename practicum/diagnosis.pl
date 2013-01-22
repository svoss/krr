:- [tp].
% Stijn Voss, s4150511
% Leon Botros, s4160894
% Definition of logical gates, used in the examples below.
and_gate(all X:(and(X) , ~ab(X) => (in1(X), in2(X) <=> out(X)))).
or_gate( all X:(or(X)  , ~ab(X) => (in1(X) ; in2(X) <=> out(X)))).
xor_gate(all X:(xor(X) , ~ab(X) => (out(X) <=> in1(X),~in2(X);~in1(X),in2(X)))).

% Two unconnected AND gates with two inputs. It is observed that the
% inputs are true and the outputs are false.
problem1(SD, COMP, OBS) :- 
  and_gate(AND),
  SD = [ AND, and(a1), and(a2) ],
  COMP = [a1, a2],
  OBS = [in1(a1), in2(a1), ~out(a1), in1(a2), in2(a2), ~out(a2)].

% Example of wwo AND gates where the output of the first gate (a1) is
% connected to the first input (in1) of the second gate (a2). It is
% easy to see that the observations are inconsistent with the
% specification.
problem2(SD, COMP, OBS) :-
  and_gate(AND),
  SD = [ AND, and(a1), and(a2), out(a1) <=> in1(a2) ],
  COMP = [a1, a2],
  OBS = [in1(a1), ~in2(a1), out(a2)].
  
% Another wiring example, now with two AND gates and an OR gate. 
problem3(SD, COMP, OBS) :-
  and_gate(AND), or_gate(OR),
  SD = [ AND, OR, and(a1), and(a2), or(o1),
         out(a1) <=> in1(o1), out(a2) <=> in2(o1)], 
  COMP = [a1, a2, o1],
  OBS = [in1(a1), in2(a1), in1(a2), in2(a2), ~out(o1)].

% The following represents a (one-bit) full adder: a
% circuit that can be used for the addition of two bits with 
% carry-in and carry-out bits.
%
% in1(fa), in2(fa): input bits
% carryin(fa):      carry-in bit
% out(fa):          output bit
% carryout(fa):     carry-out bit
%
% returns the sum of in1(fa) + in2(fa) + carryin(fa)
% as 2 * carryout(fa) + out(fa) (i.e., as 2 bits)
fulladder(SD, COMP, OBS) :-
  and_gate(AND), or_gate(OR), xor_gate(XOR), 
  SD = [AND, OR, XOR,
	and(a1), and(a2), xor(x1), xor(x2), or(r1),
        in1(fa) <=> in1(x1), in2(fa) <=> in1(a1),
        carryin(fa) <=> in1(a2), carryin(fa) <=> in2(x2),
	out(fa) <=> out(x2), carryout(fa) <=> out(r1),
	in2(fa) <=> in2(x1), in2(fa) <=> in2(a1), 
        out(x1) <=> in2(a2), out(x1) <=> in1(x2),
        out(a2) <=> in1(r1), out(a1) <=> in2(r1) ], 
  COMP = [a1, a2, x1, x2, r1],
  OBS = [in1(fa), ~in2(fa), carryin(fa), out(fa), ~carryout(fa)]. %1+1=1?

%task I


%example query: problem1(SD,COMP,OBS), solveproblem(problem(SD,COMP,OBS),D). with D is diagnosis
solveproblem(Problem,D) :- makeHST([],Tree,Problem), allHittingSets(Tree,HS), minimumHittingSets(HS,D).

%checks if hitting set tree
isHST(node(_,[],_)).
isHST(node(_,[X|[]])) 		:- isHST(X).	
isHST(node(_,[X|Y])) 		:- isHST(X), isForest(Y).
isHST(node(CS,[X|[]],L)) 	:- \+ member(L,CS), isHST(X).
isHST(node(CS,[X|Y],L)) 	:- \+ member(L,CS), isHST(X), isForest(Y).

isForest([]).
isForest([X|Y]) :- isHST(X), isForest(Y).

%get Conflict set given hitting set and problem
getCS(HS,[],problem(SD,COMP,OBS)) :-  \+ tp(SD,COMP,OBS,HS,_).
getCS(HS,CS,problem(SD,COMP,OBS)) :-  tp(SD,COMP,OBS,HS,CS).

%makes hitting set tree given problem
makeHST([],node(CS,CHILDS,nil),Problem) :- getCS([],CS,Problem), makeChilds([],CS,CHILDS,Problem).
makeHST([EDGE|REST],node(CS,CHILDS,EDGE),Problem) :- getCS([EDGE|REST],CS,Problem), makeChilds([EDGE|REST],CS,CHILDS,Problem).

%makes childs of hitting set tree node
makeChilds(_,[],[],_).
makeChilds(HS,[X|Y],[C|RC],Problem) :- makeHST([X|HS],C,Problem), makeChilds(HS,Y,RC,Problem).

%checks if something is a valid hitting set trace(or branch)
isTrace(node(_,[],_),[]).
isTrace(node(_,[X|XS],_),[T|TS]) :- X = node(_,_,T), isTrace(X,TS) ; isTraceRest(XS,[T|TS]).

isTraceRest(_,[]).
isTraceRest([X|XS],T) :- isTrace(X,T) ; isTraceRest(XS,T).

%all Hitting sets in a given tree that do not give conflicts
allHittingSets(Tree,HS) :- setof(X,isTrace(Tree,X),HS).


%breath first search improvement - not complete not in use
edges([],[]).
edges([C|Childs],[E|Edges]) :- C = node(_,_,E), edges(Childs,Edges).

bindEdges([],_,[]).
bindEdges([E|Edges],HS,[[E|HS]|RNHS]) :- bindEdges(Edges,HS,RNHS).

bindTree(node(_,Childs,_),HS,NHS) :- edges(Childs,Edges), bindEdges(Edges,HS,NHS).

nextLevel([], [],[],[],[]).
nextLevel(node(_,Childs,nil), [],Childs,[[]],[]).
nextLevel([T|Trees], [HS|THS],NTrees,NTHS,Completes) :- bindTree(T,HS,NHS), nextLevel(Trees,THS,RT,RH,RestCompletes), T = node(_,Childs,_),append(Childs,RT,NTrees), append(NHS,RH,NTHS), isComplete(T,HS,RestCompletes,Completes).

isComplete(node(_,[],_),HS,RHS,[HS|RHS]).
isComplete(_,_,RHS,RHS).

findHittingSets(_,_,Completes) :- nextLevel(Tree,HS,NTrees,NTHS,Completes), length(Completes,N), N > 0.
findHittingSets(Tree,HS,Completes) :- nextLevel(Tree,HS,NTrees,NTHS,_), findHittingSets(NTrees,NTHS,Completes).
% end implementation

minHS(HS,NHS) :- minLength(HS,L), elementsWithLength(L,HS,NHS).

minLength([E|[]],M) :- length(E,M).
minLength([E|REST],M) :- length(E,N), minLength(REST,N2), M is min(N,N2).

elementsWithLength(_,[],[]).
elementsWithLength(L,[E|REST],NEW) :- elementsWithLength(L,REST,NREST), validElement(E,L,NE), append(NE,NREST,NEW).

validElement(E,L,[E]) :- length(E,N), N == L.
validElement(_,_,[]).

%1. set of hitting sets
%2. set of hitting sets with minimum length
%list with one element gives that elements
minimumHittingSets([FHS|[]],[FHS]). 
%if the first hitting set of the hittingSets is smaller than the rest of the hitting sets this HS forms the smallest set of hitting sets
minimumHittingSets([FHS|RS],[FHS]):- minimumHittingSets(RS,MHS), lengthOfHittingSets(MHS,N), length(FHS,M), M < N.
%if this element is as large as the minimum of the rest of the hitting sets, than this HS should be added to the list
minimumHittingSets([FHS|RS],[FHS|MHS]):- minimumHittingSets(RS,MHS), lengthOfHittingSets(MHS,N), length(FHS,M), M = N.
%otherwise we want to skip this element
minimumHittingSets([_|RS],RHS):- minimumHittingSets(RS,RHS).

%length of hitting set in list of hitting sets, assumes that sizes of all hitting sets are equal
lengthOfHittingSets([H|_],L) :- length(H,L).

%taks II 
%additional COMP types definition:
power_gate(all X:(power(X) , ~ab(X) => (out(X)) )).
conv_gate(all X:(conv(X) , ~ab(X) => (in1(X) <=> out(X),~in1(X) <=> ~out(X)))).

%problem definition:
room(SD,COMP,OBS) :-
	and_gate(AND), power_gate(POWER), conv_gate(CONV), 
	SD = [AND, POWER, CONV
	,and(a1),and(a2),and(a3),
	power(ps),
	conv(gs),conv(ms),conv(rc),conv(l1),conv(l2),
	 out(ps) <=> in2(a1), out(gs) <=> in1(a1),out(rc) <=> in1(a2),
	out(a1) <=> in2(a2), out(a1) <=> in2(a3),out(ms) <=> in1(a3),
	out(a2) <=> in1(l1), out(a3) <=> in1(l2), in2(a3) <=> in2(a2)
	],
	COMP = [a1,a2,a3,gs,ms,rc,l1,l2,ps],
	OBS = [~out(l2),out(l1),in1(rc),in1(gs),in1(ms)].


	
