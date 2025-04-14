## 1.1

```haskell
∀ p::(a,b) . intercambiar (intercambiar p) = p
{I} : intercambiar (x,y) = (y,x)

-- Por lema de generacion de pares:
-- ∃x::a. ∃y::b. p = (x,y).

-- Usando principio del reemplazo basta ver que:

intercambiar (intercambiar (x,y)) = (x,y)
= {I}
intercambiar (y,x) = (x,y)
= {I}
(x,y) = (x,y)   -- > Queda demostrado por definicion.

## 1.2
```haskell
