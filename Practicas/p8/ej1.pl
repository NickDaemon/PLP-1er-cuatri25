padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

%I: X = juan; false.

%II:
hijo(X, Y) :- padre(Y, X).
hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \= Y.
descendiente(X, Y) :- padre(Y, X).
descendiente(X, Y) :- padre(Z, X), descendiente(Z, Y).

/* III:

  descendiente(Alguien, juan)
├── padre(juan, Alguien)           ← Regla base
│   ├── Alguien = carlos
│   └── Alguien = luis
└── padre(Z, Alguien), descendiente(Z, juan)  ← Regla recursiva
    ├── padre(carlos, Alguien), descendiente(carlos, juan)
    │   ├── descendiente(carlos, juan)
    │   │   └── padre(juan, carlos) 
    │   ├── Alguien = daniel
    │   └── Alguien = diego
    ├── padre(luis, Alguien), descendiente(luis, juan)
    │   ├── descendiente(luis, juan)
    │   │   └── padre(juan, luis) 
    │   ├── Alguien = pablo
    │   ├── Alguien = manuel
    │   └── Alguien = ramiro
*/

%IV: ?- abuelo(juan, X).
%V:  ?- hermano(pablo, X). ó ?- hermano(X, pablo).

%VI: 
ancestro(X, X).
ancestro(X, Y) :-  padre(X, Z), ancestro(Z, Y).