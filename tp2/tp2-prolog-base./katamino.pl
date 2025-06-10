:- use_module(piezas).

% Ejercicio 1: Sublista.
sublista(D, T, L, R) :-
    length(L2, D),
    append(L2, Cola, L),
    length(R, T),
    append(R, _, Cola).

% Ejercicio 2: Tablero.
tablero(K, T) :-
    length(T, 5),
    maplist(longitud(K), T).

longitud(K, L) :- length(L, K).

% Ejercicio 3: Tamaño
tamaño(M, F, C) :-
    length(M, F),
    maplist(longitud(C), M).


% Ejercicio 4: Coordenada
coordenada(T, IJ) :-
    tamaño(T, F, C),
    between(1, F, Fila),
    between(1, C, Columna),
    IJ = (Fila, Columna).


% Ejercicio 5: K-piezas
kPiezas(K, PS):-
    nombrePiezas(L),
    Techo is 12 - K,
    between(0, Techo, I),
    K1 is K-1,
    sublista(I, K1, L, R1),
    K2 is K1 + I,
    K3 is 12 - K2,
    sublista(K2, K3, L, R2),
    member(X, R2),
    append(R1, [X], PS).

    
    
   

    
