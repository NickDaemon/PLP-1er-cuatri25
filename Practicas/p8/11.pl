nil. 
bin(_, _, _).  

vacio(nil).

raiz(bin(_,R,_), R).

altura(nil, 0).
altura(bin(I, _, D), A) :-
    altura(I, AI),
    altura(D, AD),
    Max is max(AI, AD),
    A is 1 + Max.

cantidadDeNodos(nil,0).
cantidadDeNodos(bin(I,_,D),N):-
    cantidadDeNodos(I,CI),
    cantidadDeNodos(D,CD),
    N is 1 + CI + CD.
    
