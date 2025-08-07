variablesLibres(var(X), [X]).

variablesLibres(lam(X, M), L) :-
    variablesLibres(M, L1),
    delete(L1, X, L). 

variablesLibres(app(M, N), L) :-
    variablesLibres(M, LM),
    variablesLibres(N, LN),
    append(LM, LN, L0),
    sort(L0, L). 


tamano(var(_), 1).

tamano(lam(_, M), T) :-
    tamano(M, TM),
    T is 1 + TM.

tamano(app(M, N), T) :-
    tamano(M, TM),
    tamano(N, TN),
    T is 1 + TM + TN.


generarLambdaTerminos(Xs, M) :-
    between(1, inf, T),  % genera tamaños crecientes
    generarTamano(Xs, T, M).

% Casos de generación por tamaño:
generarTamano(Xs, 1, var(X)) :-
    member(X, Xs).

generarTamano(Xs, T, lam(X, M)) :-
    T > 1,
    member(X, Xs),
    T1 is T - 1,
    generarTamano(Xs, T1, M).

generarTamano(Xs, T, app(M, N)) :-
    T > 1,
    T1 is T - 1,
    between(1, T1, TM),
    TN is T1 - TM,
    generarTamano(Xs, TM, M),
    generarTamano(Xs, TN, N).

