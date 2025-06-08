vecino(X, Y, [X|[Y|Ls]]).
vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).


/*
?- vecino(5, Y, [5,6,5,3]).
│
├─ ?- vecino(5, Y, [5|[Y|_]])        
│   └─ Y = 6                         
│
└─ ?- vecino(5, Y, [5|_])            
    └─ ?- vecino(5, Y, [6,5,3])      
        ├─ ?- vecino(5, Y, [6|[5,3]]) 
        │   ✗ Falla: 5 no unifica con 6
        │
        └─ ?- vecino(5, Y, [5,3])    
            └─ ?- vecino(5, Y, [5|[Y|_]])
                └─ Y = 3             
*/

% Si cambiamos el orden de las reglas , cambiara el orden de las respuestas.