## 3.1
```haskell
-- Definiciones:

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- duplicar :: [a] -> [a]
{D0} duplicar [] = []
{D1} duplicar (x:xs) = x : x : duplicar xs

-- Quiero probar que:
∀ xs::[a] .length (duplicar xs) = 2 * length xs

-- Por induccion estructural sobre la estructura de xs basta ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a], ∀ x :: a. P(xs) => P(x:xs)

Con P(xs) ≡ length (duplicar xs) = 2 * length xs

-- Caso Base:
length (duplicar []) = 2 * length [] = {D0}
length [] = 2 * length []            = {L0}
0 = 2 * 0                            = {Int}
0 = 0
{- Queda demostrado el caso base. -}

-- Caso Inductivo:

-- Sea:
{HI}: P(xs) ≡ length (duplicar xs) = 2 * length xs

-- Qvq:
P(x:xs) ≡ ∀ xs :: [a], ∀ x :: [a]. => length (duplicar (x:xs)) = 2 * length (x:xs)

-- Lado izq:
length (duplicar (x:xs))       = {D1}
length (x : x : duplicar xs)   = {L1}
1 + length (x : duplicar xs)   = {L1}
1 + (1 + length (duplicar xs)) = {HI}
1 + (1 + (2 * length xs))      = {Int}
2 + (2 * length xs)            = {Int}
2 * (1 + length xs)            = {L1}
2 * (length (x:xs))             

{- Como Lado izq = Lado der , queda demostrado el caso inductivo. -}

## 3.2
```haskell
-- Definiciones: 

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- (++) :: [a] -> [a] -> [a]
{++0} [] ++ ys = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

-- Quiero probar que:
∀ xs, ys :: [a]. length (xs ++ ys) = length xs + length ys

-- Por induccion estructural sobre xs , basta ver que valen:

1) Caso Base. P([])

2) Caso Inductivo. ∀ xs :: [a], ys :: [a], x :: a. (P(xs) => P(x:xs))
con P(xs) ≡ ∀ ys :: [a]. length (xs ++ ys) = length xs + length ys

-- Caso Base:

-- Lado izq:
length ([] ++ ys) = {++0}
length ys         

-- Lado der:
length [] + length ys = {L0}
0 + length ys         = {Int}
length ys

{- Como lado izq = lado der, queda demostrado el caso Base. -}

-- Caso Inductivo:

-- Sea:
{HI}: P(xs) ≡ ∀ ys :: [a]. length (xs ++ ys) = length xs + length ys

-- Qvq:
P(x:xs) ≡ ∀ xs, ys :: [a], ∀ x :: a. => length ((x:xs) ++ ys) = length (x:xs) + length ys

-- Lado Izq:
length ((x:xs) ++ ys)     = {++1}
length (x:(xs ++ ys))     = {L1}
1 + length (xs ++ ys)     = {HI}
1 + length xs + length ys = {L1}
length (x:xs) + length ys 

{- Como Lado izq = Lado der, queda demostrado el caso inductivo. -}

```
## 3.3
```haskell
-- Definiciones:
-- append :: [a] -> [a] -> [a]
{A0} append xs ys = foldr (:) ys xs

-- foldr :: (a -> b -> b) -> b -> [a] -> b
{F0} foldr f z [] = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)

-- Quiero probar que:
∀ xs::[a] . ∀ x::a . append [x] xs = x:xs

-- Por induccion estructural sobre xs , quiero ver que valen.

1) Caso Base. P([])
2) Caso Inductivo. ∀ xs::[a] . ∀ y :: a. P(xs) => P(y:xs)
Con P(xs) = ∀ x :: a . => append [x] xs = x:xs

-- Caso Base
append [x] [] = x:[]

-- Lado izq:
append [x] []           = {A0}
foldr (:) [] [x]        = {F1}
(:) x (foldr (:) [] []) = {F0}
(:) x []                = {(:)}
x:[]

{- Como Lado izq = Lado der, queda demostrado el caso base. -}

-- Caso Inductivo:

-- Sea:
{HI}: P(xs) = ∀ x::a . => append [x] xs = x:xs

-- Qvq:
P(y:ys) = ∀ xs :: [a] , ∀ x, y :: a . => append [x] (y:xs) = x:(y:xs)

-- Lado Izq:
append [x] (y:xs)           = {A0}
foldr (:) (y:xs) [x]        = {F1}
(:) x (foldr (:) (y:xs) []) = {F0}
(:) x (y:xs)                = {(:)}
x:(y:xs)

{- Como lado izq = lado der, queda demostrado el caso inductivo. -}

```
## 3.4
```haskell
-- Definiciones:
-- map :: (a -> b) -> [a] -> [b]
{M0} map f [] = []
{M1} map f (x:xs) = f x : (map f xs)

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- Quiero probar que:
∀ xs :: [a] . ∀ f :: (a -> b) . length (map f xs) = length xs

-- Por induccion estructural sobre xs , quiero ver que valen:

1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a] . ∀ f :: (a -> b) . ∀ x :: a. (P(xs) => P(x:xs))
Con P(xs) = ∀ f :: (a -> b). length (map f xs) = length xs

-- Caso Base:
length (map f []) = length []

-- Lado izq:
length (map f []) = {M0}
length []         = {L0}
0

-- Lado der:
length [] = {L0}
0

{- Como lado izq = lado der, queda demostrado el caso base. -}

-- Caso Inductivo:
-- Sea:
{HI}: P(xs) = ∀ f :: (a -> b). length (map f xs) = length xs

-- Qvq:
P(x:xs) = ∀ f :: (a -> b). ∀ x :: a. ∀ xs :: [a].  length (map f (x:xs)) = length (x:xs)

-- Lado izq:
length (map f (x:xs))     = {M1}
length (f x : (map f xs)) = {L1}
1 + length (map f xs)     = {HI}
1 + length xs             = {L1}
length (x:xs)

{- Como Lado izq = lado der, queda demostrado el caso inductivo. -}

```
## 3.5
```haskell
-- Definiciones:
-- elem :: a -> [a] -> Bool
{E0} elem e [] = False
{E1} elem e (x:xs) = e == x || elem e xs

-- filter :: (a -> Bool) -> [a] -> [a]
{F0} filter p [] = []
{F1} filter p (x:xs) = if p x then x : filter p xs else filter p xs

-- Quiero probar que:
(asumiendo Eq a)
∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ((elem e (filter p xs)) ⇒ (elem e xs)) 

-- Usando induccion estructural sobre xs , basta ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ∀ x :: a
                  ((elem e (filter p (x:xs))) ⇒ (elem e (x:xs)))

Con P(xs) = ∀ p::a->Bool . ∀ e :: a. ((elem e (filter p xs)) ⇒ (elem e xs))

-- Caso Base:
(elem e (filter p [])) ⇒ (elem e []) = {F0}
elem e [] ⇒ elem e []                = {E0}
False ⇒ False                        = {Bool}
True

{- Queda demostrado el caso base. -}

-- Caso Inductivo:
-- Sea:
{HI}: P(xs) = ∀ p::a->Bool . ∀ e :: a. ((elem e (filter p xs)) ⇒ (elem e xs))

-- Qvq:
P(x:xs) = ∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ∀ x :: a
          ((elem e (filter p (x:xs))) ⇒ (elem e (x:xs)))

elem e (filter p (x:xs)) ⇒ elem e (x:xs)                              = {F1}
elem e (if p x then x : filter p xs else filter p xs) ⇒ elem e (x:xs) = {Por LGB}
-- Separo en casos:
A) p x = True
B) p x = False

-- Caso A:
elem e (x : filter p xs) ⇒ elem e (x:xs)           = {E1}
e == x || elem e filter p xs ⇒ elem e (x:xs)       = {E1}
e == x || elem e filter p xs ⇒ e == x || elem e xs = {Por LGB}
-- Separo en casos:
A.1) elem e filter p xs = False
A.2) elem e filter p xs = True

-- Caso A.1)
e == x || False ⇒ e == x || elem e xs = {Bool}
e == x ⇒ e == x || elem e xs          = {Bool}
True
{- Queda demostrado caso A.1. -}

-- Caso A.2)
e == x || True ⇒ e == x || elem e xs  = {HI}
-- Por HI si elem e filter p xs = True, entonces elem e xs = True.
e == x || True ⇒ e == x || True       = {Bool}
True ⇒ True                           = {Bool}
True
{- Queda demostrado caso A.2. -}

-- Caso B
elem e (filter p xs) ⇒ elem e (x:xs)       = {E1}
elem e (filter p xs) ⇒ e == x || elem e xs = {LGB}
-- Separo en casos:
B.1) elem e (filter p xs) = False
B.2) elem e (filter p xs) = True

-- Caso B.1
False ⇒ e == x || elem e xs = {Bool}
True
{- Queda demostrado caso B.1. -}

-- Caso B.2
True ⇒ e == x || elem e xs = {HI}
True ⇒ e == x || True      = {Bool}
True ⇒ True                = {Bool}
True
{- Queda demostrado Caso B.2
   Por lo tanto queda demostrado El caso inductivo. -}
```
## 3.6
```haskell
-- Definiciones:
-- ponerAlFinal :: a -> [a] -> [a]
{P0} ponerAlFinal x = foldr (:) (x:[])

-- (++) :: [a] -> [a] -> [a]
{++0} (++) [] ys = ys
{++1} (++) (x:xs) ys = x : (xs ++ ys)

-- Quiero Probar que:
∀ xs::[a] . ∀ x::a . ponerAlFinal x xs = xs ++ (x:[])

-- Usando induccion estructural sobre xs, basta ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a] . ∀ y :: a. (P(xs) => P(y:xs))
con P(xs) = ∀ x :: a. ponerAlFinal x xs = xs ++ (x:[])

-- Caso Base:
ponerAlFinal x [] = [] ++ (x:[])   = {P0}
foldr (:) (x:[]) [] = [] ++ (x:[]) = {F0}
x:[] = [] ++ (x:[])                = {++0}
x:[] = x:[]
{- Queda demostrado el caso base. -}

-- Caso Inductivo:
-- Sea:
{HI}: P(xs) = ∀ x :: a. ponerAlFinal x xs = xs ++ (x:[])

-- Qvq:
P(y:xs) = ∀ x, y :: a. ponerAlFinal x (y:xs) = (y:xs) ++ (x:[])

-- Lado Izq:
ponerAlFinal x (y:xs)       = {P0}
foldr (:) (x:[]) (y:xs)     = {F1}
(:) y (foldr (:) (x:[]) xs) = {P0}
(:) y (ponerAlFinal x xs)   = {HI}
(:) y (xs ++ (x:[]))        = {(:)}
y : (xs ++ (x:[]))          = {++1}
(++) (y:xs) (x:[])          = {++}
(y:xs) ++ (x:[])
{- Como lado izq = lado der, Queda demostrado el caso Inductivo. -}
```
## 3.7
```haskell
reverse = foldr (\x rec -> rec ++ (x:[])) []
```