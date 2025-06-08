%I:
last(L, X) :- append(_, [X], L).  

%II:
reverse([], []).
reverse([X|XS], R) :- reverse(XS, R1), append(R1, [X], R).

%III:
prefijo(P, L) :- append(P, _ , L).

%IV:
sufijo(S, L) :- append(_, S, L).

%V:
sublista([], _).
sublista(S, L) :- 
    append(_, S1, L), 
    append(S, _, S1),  
    S \= [].

%VI:
pertenece(X, L) :- append(S1, _, L), append(_, [X], S1). 


