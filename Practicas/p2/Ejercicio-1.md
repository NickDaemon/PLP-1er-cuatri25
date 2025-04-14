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
```

## 1.2
```haskell
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
```

## 1.3
```haskell
∀ p::Either a b . espejar (espejar p) = p
{EL} espejar (Left x) = Right x
{ER} espejar (Right x) = Left x

-- Por lema de generacion de suma:
-- 1) E x :: a. p = Left x
-- 2) E y :: b. p = Right y

-- Caso 1)
espejar (espejar (Left x)) = Left x
= {EL}
espejar (Right x) = Left x
= {ER}
Left x = Left x  -- > Queda demostrado.

-- Caso 2)
espejar (espejar (Right x)) = Right x
= {ER}
espejar (Left x) = Right x
= {EL}
Right x = Right x  -- > Queda demostrado.
```

## 1.4
```haskell
∀ f::a->b->c . ∀ x::a . ∀ y::b . flip (flip f) x y = f x y

{F} : flip f x y = f y x

-- Qvq:
flip (flip f) x y = f x y
= {F}
(flip f) y x = f x y
= {F}
f x y = f x y  -- > Queda demostrado.
```

## 1.5
```haskell
∀ f::a->b->c . ∀ x::a . ∀ y::b . curry (uncurry f) x y = f x y

{C} : curry f x y = f (x,y)
{U} : uncurry f (x,y) = f x y

-- Qvq:
curry (uncurry f) x y = f x y
= {C}
(uncurry f) (x,y) = f x y
= {U}
f x y = f x y -- > Queda demostrado.
```
