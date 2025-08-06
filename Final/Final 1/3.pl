desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

arbolGeneral(A) :-
    desde(1,N),
    arbolTamaño(A,N).

arbolTamaño(x, 1).
arbolTamaño([], 1).

arbolTamaño(A, N) :-
    N > 1,
    N1 is N - 1,
    between(1, N1, M),
    arbolTamaño(B, M),
    M2 is N - M,
    arbolTamaño(C, M2),
    append(B, [C], A).
   


    

