aplanar([], []).
aplanar(X, [X]):- X \= [], X \= [_|_].

aplanar([X|Xs], R) :-
    aplanar(X, RX),
    aplanar(Xs, RXs),
    append(RX, RXs, R).
