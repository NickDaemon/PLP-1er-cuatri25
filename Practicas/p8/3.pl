natural(0).
natural(suc(X)) :- natural(X).

/*
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X,X) :- natural(X).

Al realizar la consulta menorOIgual(0, X) entramos en un bucle infinito porque
instanciara X = suc(Y), luego hara menorOIgual(0, Y), luego denuevo instancia
Y = suc(Y), y asi infinitamente.

En prolog se puede colgar un programa si entra en una recursion infinita ,
ya sea por falta de un caso base o por que en cada llamada no reduzco hacia
el caso base.
*/

menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).