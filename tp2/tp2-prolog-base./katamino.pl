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
      ya sea que este instanciado o no.
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
  - De esa manera podemos frenar las consultas cuando Descartar supere el tamaño de L.
  - Y si quisieramos usar sublista para saber todas las sublistas posibles de L junto
    con cuanto hay que descartar y tomar podriamos instanciar las variables primero con
    append, de esa manera trabajaríamos con combinaciones finitas de Prefijo, Sufijo y R.
    
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
coordenada(T, (Fila, Columna)) :-
    tamaño(T, F, C),
    between(1, F, Fila),
    between(1, C, Columna).
    
% Ejercicio 5: 
kPiezas(K, PS):-
    nombrePiezas(L),
    es_combinacion(K, L, PS).

es_combinacion(0, _, []). 

es_combinacion(K, [L|LS], [L|PS]) :- 
    K > 0,
    K1 is K - 1,
    es_combinacion(K1, LS, PS).

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
% 23,133,566 inferences, 2.148 CPU in 2.157 seconds (100% CPU, 10769635 Lips)
% N = 28.

% ?- time(cantSoluciones(sinPoda, 4, N))
% 857,741,729 inferences, 77.608 CPU in 77.623 seconds (100% CPU, 11052199 Lips)
% N = 200.

% Ejercicio: 11
poda(sinPoda, _).
poda(podaMod5, T):- todosGruposModulo5(T).

todosGruposModulo5(T):-
    findall(IJ, (coordenada(T, IJ),estaLibre(T, IJ)), L),
    agrupar(L, G),
    forall(member(X, G), (length(X, N), 0 is N mod 5)).
    
estaLibre(T, (I,J)) :-
    seccionTablero(T,1,1,(I,J), [[X]]),
    var(X).

% ?- time(cantSoluciones(podaMod5, 3, N)).
% 14,801,907 inferences, 1.496 CPU in 1.497 seconds (100% CPU, 9892608 Lips)
% N = 28.

% ?- time(cantSoluciones(podaMod5, 4, N)).
% 326,698,373 inferences, 33.511 CPU in 33.516 seconds (100% CPU, 9748972 Lips)
% N = 200.
   
