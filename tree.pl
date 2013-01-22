isBinaryTree(node(_, X, Y)) :- isBinaryTree(X), isBinaryTree(Y).
isBinaryTree(leaf(_)).

nnodes(leaf(_),1).
nnodes(node(_, X, Y) ,N) :- nnodes(X, M), nnodes(Y, L) , N is M + L + 1.

makeBinary(0,leaf(0)).
makeBinary(N,node(N,X,Y)) :- M is N - 1, makeBinary(M,X), makeBinary(M,Y).

isTree(leaf(_)).
isTree(node([X|[]],_)) :- isTree(X).
isTree(node([X|Y],N)) :- isTree(X), isTree(node(Y,N)).

nnodes(node([X|[]],_),N) :- nnodes(X,M),  N is M + 1.
nnodes(node([X|Y],N), M) :- nnodes(X,Z), nnodes(node(Y,N),A),  M is A + Z.