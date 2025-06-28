notas([(juan, plp, 3), (juan, plp, 9), (maria, tlen, 2), (nico, plp, 10)]).

estudiante(juan).
estudiante(maria).
estudiante(nico).

% a)
tieneMateriaAprobada(E,M) :-
    notas(XS),
    member((E,M,N), XS),
    N >= 4.

%b)
eliminarAplazos([],[]).

eliminarAplazos([(Ex,Mx,Nx)|NS], [(Ex,Mx,Nx)| RS]) :-
    Nx >= 4,
    eliminarAplazos(NS, RS).

eliminarAplazos([(Ex,Mx,Nx)|NS], [(Ex,Mx,Nx)| RS]) :-
    Nx < 4,
    not(tieneMateriaAprobada(Ex,Mx)),
    eliminarAplazos(NS, RS).

eliminarAplazos([(Ex, Mx, Nx)|NS], RS) :-
    Nx < 4,
    tieneMateriaAprobada(Ex, Mx),
    eliminarAplazos(NS, RS).

%c)
promedio(A, P) :-
    notas(NS),
    eliminarAplazos(NS, Notas),
    notasEstudiante(A, Notas, NE),
    length(NE, N),
    sum_list(NE, Promedio),
    P is Promedio / N.

notasEstudiante(_, [],  []).

notasEstudiante(A, [(A, _, Nx)|XS], [Nx | RS]) :-
    notasEstudiante(A, XS, RS).

notasEstudiante(A, [(E,_,_)| XS], RS) :-
    A \= E,
    notasEstudiante(A, XS, RS).

%d)
mejorEstudiante(A) :-
    estudiante(A),
    promedio(A, P),
    not((estudiante(B), promedio(B, P2), P2 > P)).
    
