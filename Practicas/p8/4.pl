juntar([], L, L).
juntar([X|XS], L2, [X|L3]):- juntar(XS, L2, L3). 