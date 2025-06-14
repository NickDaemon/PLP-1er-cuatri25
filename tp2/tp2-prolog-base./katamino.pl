:- use_module(piezas).

% Ejercicio 1: 
sublista(Descartar, Tomar, L, R) :-
    length(D, Descartar),
    length(R, Tomar),
    append(D, Cola, L),
    append(R, _, Cola).

% Ejercicio 2:
tablero(K, T) :-
    length(T, 5),
    maplist(longitud(K), T).
   
longitud(K, L) :- length(L, K).

% Ejercicio 3:
tamaño(M, F, C) :-
    length(M, F),
    maplist(longitud(C), M).


% Ejercicio 4: 
coordenada(T, (Fila, Columna)) :-
    tamaño(T, F, C),
    between(1, F, Fila),
    between(1, C, Columna).
    
% Ejercicio 5: 
kPiezas(K, PS):-
    nombrePiezas(L),
    es_combinacion(K, L, PS).

es_combinacion(0, _, []). 

es_combinacion(K, [L|LS], [L|PS]) :- % Elegimos colocar la pieza.
    K > 0,
    K1 is K - 1,
    es_combinacion(K1, LS, PS).

es_combinacion(K, [_|LS], PS):- % Elegimos no colocar la pieza.
    K > 0,
    length(LS, Restantes),
    K =< Restantes,
    es_combinacion(K, LS, PS).

% Ejercicio 6:
seccionTablero(T, ALTO, ANCHO, (I,J), ST):-
    I1 is I-1,
    J1 is J-1,
    sublista(I1, ALTO, T, Seccion),
    maplist(es_sublista(J1, ANCHO), Seccion, ST).

es_sublista(J1, ANCHO, SubSeccion, STs) :-
    sublista(J1, ANCHO, SubSeccion, STs).

% Ejercicio 7:
ubicarPieza(T, I) :-
    pieza(I, P),
    tamaño(P, Alto, Ancho),
    coordenada(T, IJ),
    seccionTablero(T, Alto, Ancho, IJ, P).

% Ejercicio 8:
ubicarPiezas(_, _, []).

ubicarPiezas(T, Poda, [X|XS]) :-
    poda(Poda, T),
    ubicarPieza(T, X),
    ubicarPiezas(T, Poda, XS).

% Ejercicio 9:
llenarTablero(Poda, Columnas, T):-
    tablero(Columnas, T),
    kPiezas(Columnas, PS),
    ubicarPiezas(T, Poda, PS).

% Ejercicio 10:
cantSoluciones(Poda, Columnas, N):-
    findall(T, llenarTablero(Poda, Columnas, T), TS),
    length(TS, N).

% ?- time(cantSoluciones(sinPoda, 3, N))
% 23,133,757 inferences, 2.233 CPU in 2.235 seconds (100% CPU, 10358363 Lips)
% N = 28.

% ?- time(cantSoluciones(sinPoda, 4, N))
% 857,742,024 inferences, 80.867 CPU in 80.956 seconds (100% CPU, 10606874 Lips)
% N = 200.

% Ejercicio: 11
poda(sinPoda, _).
poda(podaMod5, T):- todosGruposModulo5(T).

todosGruposModulo5(T):-
    findall(IJ, (coordenada(T, IJ),estaLibre(T, IJ)), L),
    agrupar(L, G),
    maplist(mod5, G).

estaLibre(T, (I,J)) :-
    seccionTablero(T,1,1,(I,J), [[X]]),
    var(X).

mod5(L) :-
    length(L, N),
    0 is N mod 5.

% ?- time(cantSoluciones(podaMod5, 3, N)).
% 15,017,297 inferences, 1.592 CPU in 1.595 seconds (100% CPU, 9434132 Lips)
% N = 28.

% ?- time(cantSoluciones(podaMod5, 4, N)).
% 327,406,225 inferences, 34.763 CPU in 34.799 seconds (100% CPU, 9418209 Lips)
% N = 200.
   
