:- consult('9.pl').
cuadradoSemiMagico(N, M) :-
    desdeReversible(0,SumaFila),
    matriz_con_suma(N, N, SumaFila, M).

matriz_con_suma(0, _, _, []).
matriz_con_suma(NF, NC, SumaFila, [Fila|Resto]) :-
    NF > 0,
    fila_con_suma(NC, SumaFila, Fila),
    NF1 is NF - 1,
    matriz_con_suma(NF1, NC, SumaFila, Resto).

fila_con_suma(0, 0, []).
fila_con_suma(Len, Suma, [X|Xs]) :-
    Len > 0,
    between(0, Suma, X),
    Suma1 is Suma - X,
    Len1 is Len - 1,
    fila_con_suma(Len1, Suma1, Xs).



    
    

