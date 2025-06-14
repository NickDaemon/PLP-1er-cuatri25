padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

% abuelo(X, manuel) :- X = juan.

hijo(X, Y):- padre(Y, X).

hermano(X, Y):- padre(X, Z), padre(Y, Z), Y \= X.

descendiente(X, Y):- padre(Y, X).
descendiente(X, Y):- padre(Z, X), descendiente(Z, Y). 

/*
?- descendiente(X, juan):
|__?- padre(juan, X)
|  |__ true {X:= carlos}.
|  |__ true {X:= luis}.
|
|__?- padre(Z,X), descendiente(Z, juan)
   |__?- descendiente(juan, juan)   {Z:= juan}
   |   |__?- padre(juan, juan)
   |      |__ false.
   |__?- descendiente(carlos, juan) {Z:= carlos}
   |   |__?- padre(juan, carlos)
   |      |__ true  {X:= daniel}
   |      |__ true  {X:= diego}
   |__?- descendiente(luis, juan)   {Z:= luis}
      |_?- padre(juan, luis)
        |__ true  {X:= pablo}
        |__ true  {X:= manuel}
        |__ true  {X:= ramiro}
*/

% Para encontrar los nietos de juan hay que hacer:
% ?- abuelo(juan, X).

% Todos los hermanos de pablo:
% ?- hermano(pablo, X)  ó  ?- hermano(X, pablo).

/*
ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

Con esa definición de ancestro , el primer resultado devolvera X = juan.
Luego en el caso recursivo se colgara por que , primero instanciara Y = juan 
y querra satisfacer infinitamente ancestro(Z, juan), nunca llega a satisfacer
padre(X, Z), por lo tanto se cuelga.
Para resolver esto necesitamos poder instanciar Z en algun caso base.
En este caso debemos cambiar el orden de los predicados.
*/

ancestro(X, X).
ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).