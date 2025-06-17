desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

/*
    desde(+X, -Y).
    - X tiene que estar instanciado porque usamos lógica aritmética, y para eso es necesario 
      que su argumento esté instanciado.
    - Luego, si Y está instanciado, devolverá true en cuanto coincida con X, pero al no tener 
      una condición de corte seguirá buscando Y infinitamente. 
*/

desdeReversible(X,X).

desdeReversible(X,Y):-
    nonvar(Y),
    X =< Y.

desdeReversible(X,Y):-
    var(Y),
    N is X + 1,
    desdeReversible(N, Y).


