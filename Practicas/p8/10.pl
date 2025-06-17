intercalar([], L, L).

intercalar(L,[],L).

intercalar([X|Xs], [Y|Ys], [X,Y|Zs]):-
    intercalar(Xs, Ys, Zs).

% Todos los parámetros son reversibles.