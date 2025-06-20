:- use_module(piezas).

% Ejercicio 1: 
sublista(Descartar, Tomar, L, R) :-
    length(Prefijo, Descartar),
    append(Prefijo, Sufijo, L),
    length(R, Tomar),
    append(R, _, Sufijo).

/*
- Ejercicio 12:
  - Para ver si sublista(+Descartar, +Tomar, +L, -R) puede averiguar si una lista dada 
    es sublista de otra , tenemos que ver si R puede ser reversible en este contexto.

  - Basta ver si sublista(+Descartar, +Tomar, +L, +R) produce el resultado correcto:
    - Como Descartar y L estan instanciados, en los primeros pasos Prefijo y Sufijo se 
      instancian correctamente.
    - Luego como R esta instanciado ,length puede relacionar correctamente a R con Tomar,
      ya sea que Tomar este instanciado o no.
    - Por último, como R es una lista de tamaño Tomar y Sufijo esta instanciado, append
      puede verificar si R efectivamente unifica con los primeros "Tomar" elementos de 
      Sufijo.
    - Por lo tanto R es reversible y sublista(+Descartar, +Tomar, +L, ?R) puede decirnos
      si una lista es sublista de otra.

  - Ahora para ver si puede decirnos cuantos elementos tiene que descartar, tenemos que
    ver si Descartar es reversible.
  - Basta ver si sublista(-Descartar, +Tomar, +L, +R) produce el resultado correcto:
    - Como Descartar no esta instanciado, length instanciará en un inicio a Prefijo con
      tamaño 0, luego 1 ,2 y así sucesivamente.
    - Como Prolog hace busqueda en profundidad (DFS) ,si hay una solución la encuentra.
    - Pero luego de encontrarla o no , como Prefijo y Descartar no estaban instanciados,
      length se vuelve un generador infinito por lo que Prolog seguirá generando nuevas 
      ramas de busqueda con Prefijos cada vez mas grandes.
    - Cuando empieze a consultar con Prefijos de tamaño mayor a la longitud de la lista
      L, no podrá unificar nunca Prefijo ++ Sufijo con L , lo que resulta en consultas
      infinitas.
    - Por lo tanto Descartar en este contexto no es reversible.

  - Por lo dicho anteriormente ,no se puede usar sublista(-Descartar, ?Tomar, +L, +R).
  - Si quisieramos usar sublista con Descartar no instanciado, podriamos limitarlo a la
    longitud de la lista L agregando dos predicados:
          length(L, N),
          between(0, N, Descartar).
*/

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
coordenada([X|_], (I,J)) :-
    length(X,N),
    between(1,5,I),
    between(1,N,J).

% Ejercicio 5: 
kPiezas(K, PS):-
    nombrePiezas(L),
    es_combinacion(K, L, PS).

es_combinacion(0, _, []). 

% Elegimos colocar la pieza.
es_combinacion(K, [L|LS], [L|PS]) :- 
    K > 0,
    K1 is K - 1,
    es_combinacion(K1, LS, PS).

% Elegimos no colocar la pieza.
es_combinacion(K, [_|LS], PS):- 
    K > 0,
    length(LS, Restantes),
    K =< Restantes,
    es_combinacion(K, LS, PS).

% Ejercicio 6:
seccionTablero(T, ALTO, ANCHO, (I,J), ST):-
    I1 is I-1,
    J1 is J-1,
    sublista(I1, ALTO, T, Seccion),
    maplist(sublista(J1, ANCHO), Seccion, ST).

% Ejercicio 7:
ubicarPieza(T, I) :-
    pieza(I, P),
    tamaño(P, Alto, Ancho),
    coordenada(T, IJ),
    seccionTablero(T, Alto, Ancho, IJ, P).

% Ejercicio 8:
ubicarPiezas(_, _, []).

ubicarPiezas(T, Poda, [X|XS]) :-
    ubicarPieza(T, X),
    poda(Poda, T),
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
% 22,384,415 inferences, 2.306 CPU in 2.310 seconds (100% CPU, 9707472 Lips)
% N = 28.

% ?- time(cantSoluciones(sinPoda, 4, N))
% 837,341,601 inferences, 84.647 CPU in 84.788 seconds (100% CPU, 9892139 Lips)
% N = 200.

% Ejercicio: 11
poda(sinPoda, _).
poda(podaMod5, T):- todosGruposModulo5(T).

todosGruposModulo5(T):-
    findall(IJ, (coordenada(T, IJ),estaLibre(T, IJ)), L),
    agrupar(L, G),
    maplist(esMod5, G).

estaLibre(T, (I,J)) :-
    nth1(I, T, Fila),
    nth1(J, Fila, X),
    var(X).

esMod5(L):-
  length(L, N),
  0 is N mod 5.

% ?- time(cantSoluciones(podaMod5, 3, N)).
% 11,333,634 inferences, 1.210 CPU in 1.214 seconds (100% CPU, 9370334 Lips)
% N = 28.

% ?- time(cantSoluciones(podaMod5, 4, N)).
% 243,211,202 inferences, 26.514 CPU in 26.549 seconds (100% CPU, 9173090 Lips)
% N = 200.
