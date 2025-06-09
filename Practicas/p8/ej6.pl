aplanar([], []).
aplanar([X|XS], [X|YS]) :- X \= [_|_], X \= [], aplanar(XS, YS).
aplanar([X|XS], YS) :- 
    aplanar(X, REC),
    append(REC, XS, L),
    aplanar(L, YS).

    