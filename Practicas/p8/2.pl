vecino(X, Y, [X|[Y|Ls]]).
vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).

/*
?- vecino(5, Y, [5,6,5,3])
|__true  {Y:= 6}
|__?- vecino(5, Y, [5|[6,5,3]])
   |__?- vecino(5, Y, [6|[Y|[5,3]]])
      |__ false  {5 no unifica con 6}
      |__ ?- vecino(5, Y, [6|[5,3]])
         |__ ?- vecino(5, Y, [5 |[3]])
            |__ true  {Y:= 3}
            |__ ?- vecino(5, Y, [3|[]])
               |__ false  {5 no unifica con 3}
               |__ ?- vecino(5, Y, [])
                  |__ false. 

Si cambiaramos el orden a:
vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).
vecino(X, Y, [X|[Y|Ls]]).
funcionaria pero cambiaria el orden de los resultados.
*/