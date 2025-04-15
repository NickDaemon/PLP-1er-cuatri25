## 3.1
```haskell
∀ xs::[a] .length (duplicar xs) = 2 * length xs
-- Definiciones:

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- duplicar :: [a] -> [a]
{D0} duplicar [] = []
{D1} duplicar (x:xs) = x : x : duplicar xs

-- Por induccion estructural sobre xs basta ver que valen:
1) Caso base: P([])

2) Caso inductivo: 
∀ x :: a, xs :: [a]. (P(xs) => P(x:xs))
con P(xs) ≡ length (duplicar xs) = 2 * length xs

-- Caso base
length (duplicar []) = 2 * length []
= {D0}
length [] = 2 * length []
= {L0}
0 = 2 * length []
= {L0}
0 = 0   -- > Vale el caso base

-- Caso inductivo:
{HI} : length (duplicar xs) = 2 * length xs

-- Qvq:
{TI} : length (duplicar (x:xs)) = 2 * length (x:xs)

-- Lado izq:
length (duplicar (x:xs))
= {D1}
length (x : x : duplicar xs)
= {L1}
1 + (length (x : duplicar xs))
= {L1}
1 + (1 + (length (duplicar xs)))
= {HI}
1 + (1 + 2 * length xs) = 2 + 2 * length xs

-- Lado der:
2 * length (x:xs)
= {L1}
2 * (1 + length xs) = 2 + 2 * length xs

-- Como lado izq = lado der, queda demostrado el Caso inductivo.
-- Por lo tanto queda demostrado P(xs).
```
## 3.2
```haskell
∀ xs, ys :: [a]. length (xs ++ ys) = length xs + length ys

-- Definiciones: 

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- (++) :: [a] -> [a] -> [a]
{++0} [] ++ ys = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

-- Por induccion estructural sobre xs , basta ver que valen:

1) Caso Base: P([])

2) Caso inductivo: ∀ xs::[a], ys::[a], x :: a. P(xs) => P(x:xs)
con P(x) ≡ length (xs ++ ys) = length xs + length ys

-- Caso Base:

length ([] ++ ys) = length [] + length ys
= {++0}
length ys = length [] + length ys
= {L0}
length ys = length ys  -- > Queda demostrado el Caso Base.

-- Caso inductivo:

{HI}: length (xs ++ ys) = length xs + length ys

-- Qvq:
{TI}: length ((x:xs) ++ ys) = length (x:xs) + length ys

length ((x:xs) ++ ys)     = length (x:xs) + length ys
= {++1}
length (x : xs ++ ys)     = length (x:xs) + length ys
= {L1}
1 + (length (xs ++ ys))   = length (x:xs) + length ys
= {HI}
1 + length xs + length ys = length (x:xs) + length ys
                          = {L1}
1 + length xs + length ys = 1 + length xs + length ys

-- Queda demostrado el Caso Inductivo.
-- Por lo tanto queda demostrado P(xs).
```

## 3.3
```haskell
∀ xs::[a] .∀ x::a .append [x] xs = (x:xs)

-- Definiciones:

-- append :: [a] -> [a] -> [a]
{A0} append xs ys = foldr (:) ys xs

-- Por induccion estructural sobre xs basta ver que valen:
1) Caso Base: P([])

2) Caso inductivo: ∀ xs :: [a], y :: a. P(xs) => P(y:xs)
con P(x) ≡ append [x] xs = (x:xs)

-- Caso Base:
append [x] [] = (x:[])
= {A0}
foldr (:) [] [x] = (x:[])
= {DEF foldr}
(:) x (foldr (:) [] []) = (x:[])
= {DEF foldr}
(:) x [] = (x : [])
= {(:)}
x : [] = x : []  -- > Queda demostrado el Caso Base.

-- Caso inductivo:

{HI}: append [x] xs = (x:xs)

-- Qvq:
{TI}: append [x] (y:xs) = (x:(y:xs))

append [x] (y:xs)           = (x:(y:xs))
= {A0}
foldr (:) (y:xs) [x]        = (x:(y:xs))
= {DEF foldr}
(:) x (foldr (:) (y:xs) []) = (x:(y:xs))
= {DEF foldr}
(:) x (y:xs)                = (x:(y:xs))
= {(:)}
x : (y:xs)                  = x : (y:xs)

-- > Queda demostrado el Caso Inductivo.
-- Por lo tanto queda demostrado P(xs).
```
## 3.4
```haskell
∀ xs::[a] .∀ f::(a->b) .length (map f xs) = length xs

-- Definiciones:

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- map :: (a -> b) [a] -> [b]
{M0} map f [] = []
{M1} map f (x:xs) = f x : map f xs

-- Por induccion estructural en xs quiero ver que valen:
1) Caso Base: P([])

2) Caso Inductivo: ∀ xs :: [a], x :: a. P(xs) => P(x:xs)
con P(x) ≡ length (map f xs) = length xs

-- Caso Base:
length (map f []) = length []
= {M0}
length [] = length [] -- > Queda demostrado P([])

-- Caso inductivo:

{HI}: length (map f xs) = length xs

-- Qvq:
{TI}: length (map f (x:xs)) = length (x:xs)

length (map f (x:xs))   = length (x:xs)
= {M1}
length (f x : map f xs) = length (x:xs)
= {L1}
1 + length (map f xs)   = length (x:xs)
= {HI}
1 + length xs           = length (x:xs)
                        = {L1}
1 + length xs           = 1 + length xs

-- Queda demostrado el Caso inductivo.
-- Por lo tanto queda demostrado P(xs)
```

## 3.5
```haskell
∀ xs::[a] .∀ p::a->Bool .∀ e::a .((elem e (filter p xs)) => (elem e xs)) (asumiendo Eq a)

-- Definiciones:

-- elem :: a -> [a] -> bool
{E0} elem e [] = false
{E1} elem e (x:xs) = e == x || elem e xs

-- filter :: (a -> Bool) -> [a] -> [a]
{F0} filter f [] = []
{F1} filter f (x:xs) = if f x then x : filter xs else filter xs

-- Por induccion estructural en xs quiero ver que valen:

1) Caso Base: P([])

2) Caso inductivo: ∀ xs :: [a], x :: a, p:: a -> Bool, e :: a
                   P(x) => P(x:xs)
con P(x) ≡ ((elem e (filter p xs)) => (elem e xs))

-- Caso Base
((elem e (filter p [])) => (elem e []))
= {F0}
(elem e []) => (elem e [])
= {E0}
False => False  -- > False => Q , es True para cualquier Q.
                -- Por lo tanto la implicacion vale para el Caso Base.

-- Caso Inductivo:

{HI} ((elem e (filter p xs)) => (elem e xs))
-- En particular , si elem e (filter p xs) = False , no tendria nada que probar.
-- Por lo tanto parto desde el caso elem e (filter p xs) = True.

-- Qvq:
{TI} ((elem e (filter p (x:xs))) => (elem e (x:xs)))

(elem e (filter p (x:xs))) => elem e (x:xs)
= {F1}
elem e (if p x then x : filter p xs else filter p xs) => elem e (x:xs)
-- Por lema de generacion de bool , separo en casos:
A) p x = True
B) p x = False

-- Caso A)
elem e (x : filter p xs) => elem e (x:xs)
= {E1}
e == x || elem e (filter p xs) => elem e (x:xs)
= {HI}
e == x || True => elem e (x:xs)
= {Bool}, {E1}
True => e == x || elem e xs
-- Por {HI} se que elem e filter p xs = True.
-- Por lo tanto elem e xs = True.
True => e == x || True -- > Queda demostrado caso A).

-- Caso B)
elem e (filter p xs) => elem e (x:xs)
= {HI}
True => elem e (x:xs)
= {E1}
True => e == x || elem e xs
= {HI}
True => e == x || True -- > Queda demostrado Caso B)

-- Como vale caso A) y caso B) , queda demostrado P(x).
```












   
