%I: Intersección.
noEsta(_, []).
noEsta(E, [X|Xs]) :-
    E \= X,
    noEsta(E, Xs).

interseccion([], _, []).

interseccion([X|Xs], Ys, [X|Zs]) :-
    member(X, Ys),
    borrar(Ys, X, SinRep),
    interseccion(Xs, SinRep, Zs).

interseccion([X|Xs], Ys, Zs) :-
    noEsta(X, Ys),
    interseccion(Xs, Ys, Zs).

% II Partir:
partir(N, L, L1, L2) :-
    length(L1, N),
    append(L1, L2, L).
/*
Como length y append son reversibles , partir es totalmente reversible.
Funciona pasando o no todos los argumentos.
*/

% III Borrar:
borrar([], _, []).
borrar(L, E, L) :-
    noEsta(E, L).
    
borrar(L, E, R) :-
    append(Prefijo, [E|Sufijo], L),
    append(Prefijo, Sufijo, L1),
    !,
    borrar(L1, E, R).


% IV sacarDuplicados:
sacarDuplicados([], []).
sacarDuplicados([X|XS], [X|R]) :-
    borrar(XS, X, R1),
    sacarDuplicados(R1, R).

%V permutacion:
permutacion([], []).

permutacion([X|Xs], P) :-
    permutacion(Xs, R),
    length(R, N),
    between(0, N, I),
    partir(I, R, L1, L2),
    append(L1, [X|L2], P).

%VI reparto:
reparto(L, 1, [L]).
reparto(L, N, [X|Xs]) :-
    N > 1,
    append(X, Resto, L),
    N1 is N - 1,
    reparto(Resto, N1, Xs).


%VII repartoSinVacias
repartoSinVacias(L, 1, [L]) :-
    L \= [].  

repartoSinVacias(L, N, [X|Xs]) :-
    N > 1,
    append(X, Resto, L),
    X \= [],          
    N1 is N - 1,
    repartoSinVacias(Resto, N1, Xs).
