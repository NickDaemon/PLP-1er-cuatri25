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
```
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
-- Definiciones:
-- reverse :: [a] -> [a]
{R0} reverse xs = foldl (flip (:)) [] xs

-- foldr :: (a -> b -> b) -> b -> [a] -> b
{F0} foldr f z [] = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)

-- foldl :: (b -> a -> b) -> b -> [a] -> b
{FL0} foldl f z [] = z
{FL1} foldl f z (x:xs) = foldl f (f z x) xs

-- flip :: (a -> b -> c) -> b -> a -> c
{F} flip f x y = f y x

-- Quiero probar que:
reverse = foldr (\x rec -> rec ++ (x:[])) []

-- Por extensionalidad funcional basta ver que:
∀ xs :: [a]. reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Usando induccion estructural sobre xs , basta ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a]. ∀ x :: a.  P(xs) => P(x:xs)
Con P(xs) = reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Caso Base:
reverse [] = foldr (\x rec -> rec ++ (x:[])) [] []

-- Lado izq:
reverse []             = {R0}
foldl (flip (:)) [] [] = {FL0}
[]                     = {F0}

-- Lado deR:
foldr (\x rec -> rec ++ (x:[])) [] [] = {F0}
[]

{- Queda demostrado el caso base. -}

-- Caso Inductivo:
-- Sea
{HI}: P(xs) = reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Qvq:
P(x:xs) = ∀ xs :: [a]. ∀ x :: a.  
          reverse (x:xs) = foldr (\x rec -> rec ++ (x:[])) [] (x:xs)

-- Lado izq:
reverse (x:xs)                      = {R0}
foldl (flip (:)) [] (x:xs)          = {FL1}
foldl (flip (:)) (flip (:) [] x) xs = {F}
foldl (flip (:)) (x:[]) xs          = {lema}
reverse xs ++ (x:[])

-- Lado der:
foldr (\x rec -> rec ++ (x:[])) [] (x:xs)                           = {F1}
(\x rec -> rec ++ (x:[])) x (foldr (\x rec -> rec ++ (x:[])) [] xs) = {B}
(\rec -> rec ++ (x:[])) (foldr (\x rec -> rec ++ (x:[])) [] xs)     = {HI}
(\rec -> rec ++ (x:[])) reverse xs                                  = {B}
reverse xs ++ (x:[])
{- Como lado izq = lado der, Queda demostrado caso inductivo. -}

-- Pruebo lema:
{lema} : ∀ xs, ys :: [a]. reverse xs ++ ys = foldl (flip (:)) ys xs

-- Uso induccion estructural en xs, quiero ver que:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a], ∀ x :: a. P(xs) => P(x:xs)
Con P(xs) = ∀ ys :: [a]. reverse xs ++ ys = foldl (flip (:)) ys xs

-- Caso Base.
reverse [] ++ ys = foldl (flip (:)) ys []

-- Lado izq:
reverse [] ++ ys             = {R0}
foldl (flip (:)) [] [] ++ ys = {F0}
[] ++ ys                     = {++0}
ys

-- Lado der:
foldl (flip (:)) ys [] = {F0}
ys
{- Queda demostrado el caso base. -}

-- Caso inductivo:
-- Sea:
{HI}: P(xs) = ∀ ys :: [a]. reverse xs ++ ys = foldl (flip (:)) ys xs

-- Qvq:
P(x:xs) = ∀ ys, xs :: [a]. ∀ x :: a.
          reverse (x:xs) ++ ys = foldl (flip (:)) ys (x:xs)

-- Lado izq:
reverse (x:xs) ++ ys                      = {R0}
foldl (flip (:)) [] (x:xs) ++ ys          = {FL1}
foldl (flip (:)) (flip (:) [] x) xs ++ ys = {F}
foldl (flip (:)) (x:[]) xs ++ ys          = {HI}
reverse xs ++ (x:[]) ++ ys                = 

-- Lado der:
foldl (flip (:)) ys (x:xs)           = {FL1}
foldl (flip (:)) (flip (:) ys x) xs  = {F}
foldl (flip (:)) (x:ys) xs           = {HI}
reverse xs ++ (x:ys)                 = {lema-2}
reverse xs ++ (x:([] ++ ys))         = {++1}
reverse xs ++ (x:[]) ++ ys

{- Como lado izq = lado der, Queda demostrado caso Inductivo. -}

-- Usando el principio de reemplazo, demuestro que vale por definicion lema-2:
∀ ys, xs :: [a]. ∀ x :: a. (x:ys) = (x:([] ++ ys))

(x:ys) = (x:([] ++ ys)) = {++0}
(x:ys) = (x:ys)
{- Queda demostrado lema-2. -}
```
## 3.8
```haskell
-- Definiciones:

-- head :: [a] -> a
{H0} head []     = error "no hay head de lista vacia"
{H1} head (x:xs) = x

-- reverse 
{R1} reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- foldr :: (a -> b -> b) -> b -> [a] -> b
{F0} foldr f z [] = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)

-- ponerAlFinal :: a -> [a] -> [a]
{P0} ponerAlFinal x = foldr (:) (x:[])

-- Quiero probar que:
∀ xs::[a] . ∀ x::a . head (reverse (ponerAlFinal x xs)) = x

-- Usando induccion estructural sobre xs , basta ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a] . ∀ y :: a. P(xs) => P(y:xs)
Con P(xs) = ∀ x :: a . head (reverse (ponerAlFinal x xs)) = x

-- Caso Base

-- Lado izq:
head (reverse (ponerAlFinal x []))               = {P0}
head (reverse (foldr (:) (x:[]) []))             = {F0}
head (reverse (x:[]))                            = {R0}
head (foldr (\x rec -> rec ++ (x:[])) [] (x:[])) = {F1} 
-- llamo f = (\x rec -> rec ++ (x:[]))
head (f x (foldr f [] []))                       = {F0}
head (f x [])                                    = {sintaxis f}
head ((\x -> (\rec -> rec ++ (x:[])) x []))      = {B}
head ((\rec -> rec ++ (x:[])) [])                = {B}
head ([] ++ (x:[]))                              = {++0}
head (x:[])                                      = {H1}
x
{- Como lado izq = lado der, queda demostrado el caso base. -}

-- Caso Inductivo
-- Sea:
{HI}: P(xs) = ∀ x :: a . head (reverse (ponerAlFinal x xs)) = x

-- Qvq:
P(y:xs) = ∀ xs :: [a] . ∀ x, y :: a . head (reverse (ponerAlFinal x (y:xs))) = x

-- Lado izq:
head (reverse (ponerAlFinal x (y:xs)))         = {P0}
head (reverse (foldr (:) (x:[]) (y:xs)))       = {F1}
head (reverse ((:) y (foldr (:) (x:[]) xs)))   = {P0}
head (reverse ((:) y (ponerAlFinal x xs)))     = {(:)}
head (reverse (y : ponerAlFinal x xs))         = {R0}
-- llamo f = (\x rec -> rec ++ (x:[]))
head (foldr f [] (y: ponerAlFinal x xs))       = {F0}
head (f y (foldr f [] (ponerAlFinal x xs)))    = {R0}
head (f y (reverse (ponerAlFinal x xs)))       = {B} y {sintaxis f}
head (\rec -> rec ++ (y:[]))                   = {B}
head ((reverse (ponerAlFinal x xs)) ++ (y:[])) = {lema}
head (reverse (ponerAlFinal x xs))             = {HI}
x
{- Como lado izq = lado der, Queda demostrado el caso Inductivo. -}

-- Pruebo lema:
∀ xs, ys :: [a] . ∀ x :: a. head ((x:xs) ++ ys) = head (x:xs)

-- Usando el principio de reemplazo , pruebo que vale la igualdad por definicion.
head ((x:xs) ++ ys) = head (x:xs) = {++1}
head (x:(xs ++ ys)) = head (x:xs) = {H1}
x = head (x:xs)                   = {H1}
x = x
{- Queda demostrado el lema.-}
 ```