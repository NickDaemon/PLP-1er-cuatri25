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
1) Caso Base. P([])

2) Caso Inductivo. 
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

1) Caso Base. P([])

2) Caso Inductivo. ∀ xs::[a], ys::[a], x :: a. P(xs) => P(x:xs)
con P(xs) ≡ length (xs ++ ys) = length xs + length ys

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
1) Caso Base. P([])

2) Caso Inductivo. ∀ xs :: [a], y :: a. P(xs) => P(y:xs)
con P(xs) ≡ append [x] xs = (x:xs)

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
1) Caso Base. P([])

2) Caso Inductivo. ∀ xs :: [a], x :: a. P(xs) => P(x:xs)
con P(xs) ≡ length (map f xs) = length xs

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

1) Caso Base. P([])

2) Caso Inductivo. ∀ xs :: [a], x :: a
                   P(x) => P(x:xs)
con P(xs) ≡ ((elem e (filter p xs)) => (elem e xs))

-- Caso Base
((elem e (filter p [])) => (elem e []))
= {F0}
(elem e []) => (elem e [])
= {E0}
False => False  -- > False => Q , es True para cualquier Q.
                -- Por lo tanto la implicacion vale para el Caso Base.

-- Caso Inductivo:

{HI} ((elem e (filter p xs)) => (elem e xs))

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
                               = {E1}
e == x || elem e (filter p xs) => e == x || elem e xs
-- Por lema de generacion de bool , separo en casos:
A.1) e == x
A.2) e != x

-- Caso A.1)
True || elem (filter p xs) => True || elem e xs
= {Bool}
True => True -- > Queda demostrado A.1)

-- Caso A.2)
False || elem (filter p xs) => False || elem e xs
= {Bool}
elem (filter p xs) => elem e xs
= {HI}
True -- > Queda demostrado A.2)

-- Caso B)
elem e (filter p xs) => elem e (x:xs)
                     = {E1}
elem e (filter p xs) => e == x || elem e xs
-- Por lema de generacion de Bool separo en casos:
B.1) elem e (filter p xs) = True
B.2) elem e (filter p xs) = False

-- Caso B.1)
-- Por {HI} si elem e (filter p xs) = True entonces
-- elem e xs = True
True => e == x || True -- > Queda demostrado caso B.1)

-- Caso B.2)
False => e == x || elem e xs
-- False => Q , es True para cualquier Q, Queda demostrado B.2)
-- Por lo tanto vale caso B).

-- Como vale caso A) y caso B) , queda demostrado P(xs).
```
## 3.6
```haskell
∀ xs::[a] .∀ x::a .ponerAlFinal x xs = xs ++ (x:[])

-- Definiciones:
-- ponerAlFinal :: a -> [a] -> [a]
{P0} ponerAlFinal x = foldr (:) (x:[])

-- (++) :: [a] -> [a] -> [a]
{++0} [] ++ ys = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

-- Por induccion estructural en xs quiero ver que valen:

1) Caso Base. P([])

2) Caso Inductivo. ∀ y :: a
                   P(xs) => P(y:xs)
con P(xs) ≡ ponerAlFinal x xs = xs ++ (x:[])

-- Caso Base:
ponerAlFinal x [] = [] ++ (x:[])
= {P0}
foldr (:) (x:[]) [] = [] ++ (x:[])
= {DEF foldr}
(x:[]) = [] ++ (x:[])
       = {++0}
(x:[]) = (x:[])   -- > Queda demostado el caso base.

-- Caso inductivo:

{HI}: ponerAlFinal x xs = xs ++ (x:[])

-- Qvq:
{TI}: ponerAlFinal x (y:xs) = (y:xs) ++ (x:[])

ponerAlFinal x (y:xs)       = (y:xs) ++ (x:[])
= {P0}
foldr (:) (x:[]) (y:xs)     = (y:xs) ++ (x:[])
= {DEF foldr}
(:) y (foldr (:) (x:[]) xs) = (y:xs) ++ (x:[])
= {P0}
(:) y (ponerAlFinal x xs)   = (y:xs) ++ (x:[])
= {HI}
(:) y (xs ++ (x:[]))        = (y:xs) ++ (x:[])
                            = {++1}
(:) y (xs ++ (x:[]))        = y : (xs ++ (x:[]))
= {(:)}
y : (xs ++ (x:[]))          = y : (xs ++ (x:[])) 
-- Con esto queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado P(xs).
```

## 3.7
```haskell
reverse = foldr (\x rec -> rec ++ (x:[])) []

-- Definiciones:
{R0} reverse = foldl (flip (:)) []

-- Por extensionalidad funcional Quiero ver que:
∀ xs :: [a]. reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Por induccion estructural en xs quiero ver que valen:

1) Caso Base. P([])

2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
Con P(xs) ≡ reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Caso Base:
reverse []             = foldr (\x rec -> rec ++ (x:[])) [] []
= {R0}
foldl (flip (:)) [] [] = foldr (\x rec -> rec ++ (x:[])) [] []
= {DEF foldl}
[]                     = foldr (\x rec -> rec ++ (x:[])) [] []
                       = {DEF foldr}
[]                     = []  -- > Queda demostrado el caso base.  

-- Caso inductivo:

{HI} reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Qvq:
{TI} reverse (x:xs) = foldr (\x rec -> rec ++ (x:[])) [] (x:xs)

-- Lado izq:
reverse (x:xs)                      
= {R0}
foldl (flip (:)) [] (x:xs)          
= {DEF foldl}
foldl (flip (:)) (flip (:) [] x) xs 
= {DEF flip}
foldl (flip (:)) [x] xs  
= {Lema}
reverse xs ++ [x]  

-- Lado der:
foldr (\x rec -> rec ++ (x:[])) [] (x:xs)
= {DEF foldr}
(\x rec -> rec ++ (x:[])) x (foldr (\x rec -> rec ++ (x:[])) [] xs)
= {HI}
(\x -> (\rec -> rec ++ (x:[]))) x (reverse xs)
= {B}
(\rec -> rec ++ ([x])) reverse xs
= {B}
reverse xs ++ [x]

-- Pruebo Lema
{Lema}: ∀ xs, ys :: [a]. reverse xs ++ ys = foldl (flip (:)) ys xs

-- Por induccion estructural sobre ys quiero ver que valen:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)

-- Caso Base.
reverse [] ++ ys             = foldl (flip (:)) ys []
= {R0}
foldl (flip (:)) [] [] ++ ys = foldl (flip (:)) ys []
= {DEF flip}
[] ++ ys                     = foldl (flip (:)) ys []
= {++0}                         
ys                           = foldl (flip (:)) ys []
                             = {DEF foldl}
ys                           = ys   -- > Queda demostrado el caso base.

-- Caso inductivo

{HI}: reverse xs ++ ys = foldl (flip (:)) ys xs

-- Qvq:
{TI} reverse (x:xs) ++ ys = foldl (flip (:)) ys (x:xs)

-- Lado izq:
reverse (x:xs) ++ ys 
= {R0}
foldl (flip (:)) [] (x:xs) ++ ys
= {DEF foldl}
foldl (flip (:)) (flip (:) [] x) xs ++ ys
= {Aplicacion flip}
foldl (flip (:)) (x:[]) xs ++ ys
= {HI}
reverse xs ++ (x:[]) ++ ys
= {++1}
reverse xs ++ (x: ([] ++ ys))
= {++0}
reverse xs ++ (x:ys)

-- Lado der:
foldl (flip (:)) ys (x:xs)
= {DEF foldl}
foldl (flip (:)) (flip (:) ys x) xs
= {Aplicacion flip}
foldl (flip (:)) (x:ys) xs
= {HI}
reverse xs ++ (x:ys) 

-- Como lado izq = lado der ,  queda demostrado el Caso inductivo.
-- Por lo tanto queda demostrado P(xs) , entonces queda probado el lema.

-- Falta probar A ++ B ++ C = A ++ (B ++ C) uwu.
```

## 3.8 
```haskell
∀ xs::[a] .∀ x::a .head (reverse (ponerAlFinal x xs)) = x
-- Definiciones:

-- ponerAlFinal :: a -> [a] -> [a]
{P0} ponerAlFinal x = foldr (:) (x:[])
{P1} ponerAlFinal x xs = xs ++ (x:[])

-- reverse :: [a] -> [a]
{R0} reverse xs = foldl (flip (:)) [] xs
{R1} reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- Por induccion estructural sobre xs quiero ver que valen:
1) Caso Base. P([])

2) Caso Inductivo. ∀ y :: a. P(xs) => P(y:xs)
con P(xs) ≡ head (reverse (ponerAlFinal x xs)) = x

-- Caso Base:
head (reverse (ponerAlFinal x []))                                         = x
= {P1}
head (reverse ([] ++ [x]))                                                 = x
= {++0}
head (reverse [x])                                                         = x
= {R1}
head (foldr (\x rec -> rec ++ (x:[])) [] [x])                              = x
= {DEF foldr}
head ((\x rec -> rec ++ (x:[])) x (foldr (\x rec -> rec ++ (x:[])) [] [])) = x
= {DEF foldr}
head (((\x -> \rec -> rec ++ (x:[])) x []))                                = x
= {B}
head ((\rec -> rec ++ [x]) [])                                             = x
= {B}
head ([] ++ [x])                                                           = x
= {++0}
head [x]                                                                   = x 
-- > Queda demostrado el caso base.

-- Caso Inductivo:
{HI}: head (reverse (ponerAlFinal x xs)) = x

-- Qvq:
{TI}: head (reverse (ponerAlFinal x (y:xs))) = x

-- Lado izq:
head (reverse (ponerAlFinal x (y:xs)))
= {P0}
head (reverse (foldr (:) (x:[]) (y:xs)))
= {foldr}
head (reverse ((:) y (foldr (:) (x:[]) xs)))
= {P0}
head (reverse (y : (ponerAlFinal x xs)))
= {R0}
head (foldr (\x rec -> rec ++ (x:[])) [] (y : (ponerAlFinal x xs))) 
= {foldr} -- > llamo f a (\x rec -> rec ++ (x:[]))
head (f y (foldr f [] (ponerAlFinal x xs)))
= {B}
head (\rec -> rec ++ [y]) (foldr f [] (ponerAlFinal x xs))
= {R0}
head (\rec -> rec ++ [y]) (reverse (ponerAlFinal x xs))
= {B}
head (reverse (ponerAlFinal x xs) ++ [y])
= {Lema}
head (reverse (ponerAlFinal x xs))
= {HI}
x  -- > Queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado P(xs)

-- Demuestro Lema
{Lema}: ∀ xs, ys :: [a], x :: a. head ((x:xs) ++ ys) = head (x:xs)

-- Por induccion estructural sobre xs quiero ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ y :: a. P(xs) => P(y:xs)

-- Caso Base:
head ((x:[]) ++ ys)   = head (x:xs)
= {++1}
head (x : ([] ++ ys)) = head (x:xs)
= {DEF head}
x                     = x    -- > Queda demostrado el caso base.

-- Caso inductivo:

{HI}: head ((x:xs) ++ ys) = head (x:xs)

-- Qvq:
{TI}: head ((x:(y:xs)) ++ ys) = head (x:(y:xs))

head ((x:(y:xs)) ++ ys)       = head (x:(y:xs))
= {++1}
head (x : ((y:xs) ++ ys))     = head (x:(y:xs))
= {DEF head}
x                             = x

-- > Queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado P(xs)
```













   
