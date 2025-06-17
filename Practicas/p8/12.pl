nil.
bin(_,_,_).

inorder(nil,[]).
inorder(bin(I,R,D), L):-
    inorder(I,LI),
    inorder(D,LD),
    append(LI,[R],LR),
    append(LR, LD, L).

arbolConInorder([], nil).
arbolConInorder(L, bin(I, R, D)) :-
    append(LI, [R|LD], L),
    arbolConInorder(LI, I),
    arbolConInorder(LD, D).

esABB(nil).
esABB(bin(I,R,D)):-
    inorder(bin(I,R,D),L),
    append(Izq, [R|Der],L),
    forall(member(X,Izq), R >= X),
    forall(member(X,Der), R < X),
    esABB(I),
    esABB(D).

aBBInsertar(X, nil, bin(nil, X, nil)).  

aBBInsertar(X, bin(I, R, D), bin(I2, R, D)) :-
    X < R,
    aBBInsertar(X, I, I2).              

aBBInsertar(X, bin(I, R, D), bin(I, R, D2)) :-
    X >= R,
    aBBInsertar(X, D, D2).  

/*   aBBInsertar(+X, +T1, ?T2)
   - X no es reversible por que usa comparaciones aritméticas.
   - T1 no es reversible por que consultaría infinitos arboles.
   - T2 si es reversible:
        - Si T2 es una variable, se unifica con el resultado del árbol insertado.
        - Si T2 está instanciado, Prolog intenta unificar la estructura con lo que va 
          generando durante el recorrido.
   
*/            



    


