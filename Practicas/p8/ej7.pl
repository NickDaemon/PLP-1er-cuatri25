%I:
noEsta(_, []).
noEsta(X, [Y|YS]) :- X \= Y, noEsta(X, YS).

interseccion(XS, YS, L) :- sinRepetidos(XS, YS, [], L).

sinRepetidos([], _, _, []).

sinRepetidos([X|XS], YS, Vistos, [X|L3]) :- 
    member(X, YS),
    noEsta(X, Vistos),
    sinRepetidos(XS, YS,[X|Vistos],L3).

sinRepetidos([X|XS], YS, Vistos, L3) :- 
    member(X, YS),
    member(X, Vistos),
    sinRepetidos(XS, YS, Vistos,L3).

sinRepetidos([X|XS], YS, Vistos, L3) :- 
    noEsta(X, YS),
    sinRepetidos(XS, YS, Vistos, L3).

partir(0, L, [], L).
partir(N, L, XS, YS):- 
    N > 0,
    N1 is N-1,
    append(XS, YS, L),
    append(L2, [X], XS),
    partir(N1, L, L2, [X|YS]). 

%------------------------------------------------------------------------------------------
%II:
borrar([], _, []).
borrar([X|XS], E, [X|L3]) :- 
    X \= E,
    borrar(XS, E, L3).

borrar([E|XS], E, L3) :-
    borrar(XS, E, L3).

%------------------------------------------------------------------------------------------
%III:
sacarDuplicados([],[]).
sacarDuplicados([X|XS], [X|L]):-
    borrar(XS, X, L2),
    sacarDuplicados(L2, L).

%------------------------------------------------------------------------------------------
%IV:
permutacion([], []).
permutacion([X|XS], YS):- 
    


