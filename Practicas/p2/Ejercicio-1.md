## 1.1

```haskell
∀ p::(a,b) . intercambiar (intercambiar p) = p
{I} : intercambiar (x,y) = (y,x)

-- Por lema de generacion de pares:
-- ∃x::a. ∃y::b. p = (x,y).

-- Qvq:
intercambiar (intercambiar (x,y)) = (x,y)
= {I}
intercambiar (y,x) = (x,y)
= {I}
(x,y) = (x,y)   -- > Queda demostrado.

## 1.2
∀ p::(a,(b,c)) . asociarD (asociarI p) = p

{AD} : asociarD ((x,y),z) = (x,(y,z))
{AI} : asociarI (x,(y,z)) = ((x,y),z)

-- Por lema de generacion de pares:
-- ∃x::a. ∃y::b. ∃z::c. p = (x,(y,z)).

-- Qvq: 
asociarD (asociarI (x,(y,z))) = (x,(y,z))
= {AI}
asociarD ((x,y),z) = (x,(y,z))
= {AD}
(x,(y,z)) = (x,(y,z))  -- > Queda demostrado.

