parteQueSuma(_, 0, []).
parteQueSuma([L|Ls], N, [L|Xs]) :-
    N > 0,
    N1 is N - L,
    parteQueSuma(Ls, N1, Xs).
parteQueSuma([_|Ls], N, Xs) :-
    N > 0,
    parteQueSuma(Ls, N, Xs).


