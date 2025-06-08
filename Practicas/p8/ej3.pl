/*
I:
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
menorOIgual(X,X) :- natural(X).

  Al realizar la consulta menorOIgual(0, X), prolog instanciara X = suc(Y1).
  Luego en el siguiente paso instanciara Y1 = suc(Y2).
  Y asi infinitamente , osea 
  

II:
   Un programa se cuelga cuando entro en una clausula recursiva y no tengo un caso base
   definido.
   Y tmb puede colgarse si apesar de tener un caso base definido, en las llamadas recursivas
   nunca me acerco al caso base, osea sino disminuyo los parametros que entran.
   El orden es fundamental para evitar esto ya que prolog se ejecuta de arriba abajo.
*/

natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
