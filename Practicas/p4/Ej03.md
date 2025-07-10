## A)
 - En el término `λx : Nat. succ((λx : Nat. x) x)`:

  - Aparece la variable `x` tres veces:

    1. **Primera ocurrencia**: en `λx : Nat`.  
       - Aquí `x` **no es subtérmino**, sino el **parámetro** de la abstracción.  
       - No se cuenta como una **ocurrencia del término `x` como subtérmino**.

    2. **Segunda ocurrencia**: en `λx : Nat. x` (dentro de `succ(...)`).  
       - Esta `x` **sí es un subtérmino**.  
       - Está **ligada localmente** a ese lambda.

    3. **Tercera ocurrencia**: en la aplicación `(λx : Nat. x) x`.  
       - Esta `x` también **es un subtérmino**.  
       - Está **ligada por el λ externo**.

  - ✅ Por lo tanto, el término `x` ocurre como subtérmino **dos veces**:
    - Una dentro del `λx : Nat. x`
    - Otra como argumento de la aplicación

## B)
  - En el término `λx1 : Nat. succ(x2)`:
    - x1 no aparece como variable , ni dentro ni fuera de succ(x2)-
    - Por lo tanto la respuesta es No.

## C)
  - En el término `u x (y z)`:
    - Como la aplicación asocia a izquierda tenemos:
    1. `(u x) (y z)`
    2.  Por lo tanto `x (y z)` , nunca ocurre como subtermino.
