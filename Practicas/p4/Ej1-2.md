## Ejercicio 1:
- a) Es válido, es un termino.
- b) Es válido, es un termino.
- c) No es válido.
- d) Es válido, es un termino.
- e) Es válido, es un termino.
- f) Es valido, es un termino. (M N, con N = suc(P), con P = R S.)
- g) No es válido
- h) Es válido, es un termino. 
- i) Es válido, es un termino.
- j) No es válido.
- k) Es válido, es un tipo.
- l) Es válido, es un tipo.
- m) No es válido.
- n) No es válido.
- ñ) No es válido.
- o) No es válido.
- p) Es válido.

## Ejercicio 2:
λ x: τ. (if isZero(zero) Then succ(true) else x) pred(false)
                          |  
                      (λx:τ. M)
                          |                                            
                          |                
                          |                                         
if isZero(zero) Then succ(true) else pred(false)  pred(false)
                                    |    
                      ____________(M M)_____________ 
                     |                              |
                     |                              |
                     |                              |  
if isZero(zero) Then succ(true) else x           pred(false)    
                     |                              |          
    _________(If M then M else M)______           pred(M)  
   |                 |                 |            | 
   |                 |                 |            |
   |                 |                 |            |
isZero(zero)     succ(true)            x -> term.   false -> term  
   |                 |
isZero(M)        succ(M)
   |                 |                    
   |                 |   
   |                 |                      
  zero -> term.     true -> term          