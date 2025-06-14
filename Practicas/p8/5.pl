% I:
last(L, X) :- append(_, [X], L).

%II:
reverse([], []).
reverse([X|Xs], R):- reverse(Xs, Rs), append(Rs, [X], R).
/*
?-reverse([a,b,c], [c,b,a])
|__?- reverse([b,c], Rs)
|   |__?- reverse([c], Rs1)      
|   |   |__?- reverse([], Rs2)      {Rs2 := []}
|   |   |__?- append([], [c], Rs1)  {Rs1 := [c]}  
|   |__?- append([c], [b], Rs)      {Rs  := [c,b]}
|__?- append([c,b], [a], [c,b,a])
   |__ [c,b,a] =? [c,b,a] --> true.        
*/

%III:
prefijo(L, P):- append(P,_,L).

%IV:
sufijo(L, S):- append(_,S,L).

%V:
sublista([], _).
sublista(S, L) :- 
    append(_, S1, L), 
    append(S, _, S1),  
    S \= [].

%VI:
pertenece(X, L) :- 
    prefijo(L, P),
    append(P, [X], Xs),
    append(Xs, _, L).
    