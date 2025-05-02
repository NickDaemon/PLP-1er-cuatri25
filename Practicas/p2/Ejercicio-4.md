## 4.1
```haskell
-- Definiciones:
-- reverse :: [a] -> [a]
{R1} reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs

-- id :: a -> a
{ID} id x = x

-- foldr :: (a -> b -> b) -> b -> [a] -> b
{F0} foldr f z [] = z
{F1} foldr f z (x:xs) = f z (foldr f z xs)

-- (.) :: (a -> b) -> (c -> a) -> c -> b
{.} (f . g) x = f (g x)


-- Quiero probar que:
reverse . reverse = id

-- Usando extensionalidad funcional , basta ver que:
∀ xs :: [a]. reverse . reverse xs = id xs

-- Por induccion estructural sobre xs , quiero ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ xs :: [a], ∀ x :: a. P(xs) => P(x:xs)
con P(xs) = reverse . reverse xs = id xs

-- Caso Base:
reverse . reverse [] = id []

-- Lado izq
reverse . reverse []                            = {.}
reverse (reverse [])                            = {R0}
reverse (foldr (\x rec -> rec ++ (x:[])) [] []) = {F0}
reverse []                                      = {R0}
(foldr (\x rec -> rec ++ (x:[])) [] [])         = {F0}
[]                                              = {ID}
id []
-- Queda demostrado el caso Base.

-- Caso Inductivo:
-- Sea
{HI} : P(xs) = reverse . reverse xs = id xs

-- Qvq:
P(x:xs) = ∀ xs :: [a], ∀ x :: a. reverse . reverse (x:xs) = id (x:xs)

-- Lado izq:
reverse . reverse (x:xs)                            = {.}
reverse (reverse (x:xs))                            = {R1}
reverse (foldr (\x rec -> rec ++ (x:[])) [] (x:xs)) = {F1}
-- llamo f = (\x rec -> rec ++ (x:[]))
reverse (f x (foldr f [] xs))                       = {R1}
reverse (f x (reverse xs))                          = {B} dos veces
reverse (reverse xs ++ (x:[]))                      = {lema}
reverse (x:[]) ++ reverse (reverse xs)              = {HI}
reverse (x:[]) ++ id xs                             = {R1}
foldr f [] (x:[]) ++ id xs                          = {F1}
f x (foldr f [] []) ++ id xs                        = {F0}
f x [] ++ id xs                                     = {B} dos veces
[] ++ (x:[]) ++ id xs                               = {++0}
(x:[]) ++ id xs                                     = {ID}
(x:[]) ++ xs                                        = {++1}
(x:[] ++ xs)                                        = {++0}
(x:xs)                                              = {ID}
id (x:xs)
{- Queda demostrado el caso inductivo. -}

-- Pruebo lema:
∀ xs, ys :: [a]. reverse (xs ++ ys) = reverse ys ++ reverse xs

-- Uso induccion estructural sobre xs

-- Caso Base:
reverse ([] ++ ys) = reverse ys ++ reverse []                      = {++0}
reverse ys = reverse ys ++ reverse []                              = {R1}
reverse ys = reverse ys ++ (foldr (\x rec -> rec ++ (x:[])) [] []) = {F0} 
reverse ys = reverse ys ++ []                                      = {lema-2}
reverse ys = reverse ys
{- Queda demostrado el caso base. -}

-- Caso Inductivo:
-- Sea:
{HI}: P(xs) = ∀ ys :: [a]. reverse (xs ++ ys) = reverse ys ++ reverse xs

-- Qvq:
P(x:xs) = ∀ xs, ys :: [a], ∀ x :: a.  reverse ((x:xs) ++ ys) = reverse ys ++ reverse (x:xs)

-- Lado Izq:
reverse ((x:xs) ++ ys)             = {++1}
reverse (x:(xs ++ ys))             = {R1}
-- llamo f = (\x rec -> rec ++ (x:[]))
foldr f [] (x:(xs ++ ys))          = {F1}
f x (foldr f [] (xs ++ ys))        = {R1}
f x (reverse (xs ++ ys))           = {B} dos veces
reverse (xs ++ ys) ++ (x:[])       = {HI}
reverse ys ++ reverse xs ++ (x:[]) 

-- Lado der:
reverse ys ++ reverse (x:xs)        = {R1}
-- llamo f = (\x rec -> rec ++ (x:[]))
reverse ys ++ foldr f [] (x:xs)     = {F1}
reverse ys ++ (f x (foldr f [] xs)) = {R1}
reverse ys ++ (f x reverse xs)      = {B} dos veces
reverse ys ++ reverse xs ++ (x:[]) 

{- Queda demostrado el caso inductivo.-}

-- Pruebo lema-2
∀ xs :: [a]. xs ++ [] = xs

-- Por induccion estructural sobre xs ,quiero ver que valen
1) Caso Base. P([])
2) Caso Inductivo. P(xs) => P(x:xs)

-- Caso Base
[] ++ [] = [] = {++0}
[] = []
{- Queda demostrado Caso Base. -}

-- Caso Inductivo:

{HI} xs ++ [] = xs

-- Qvq:
(x:xs) ++ [] = (x:xs) = {++1}
x:(xs ++ []) = (x:xs) = {HI}
(x:xs) = (x:xs)
{- Queda demostrado el caso inductivo. -}
```
## 4.2
```haskell
-- Definiciones :
{A0} append [] = (\ys -> ys)
{A1} append xs = (\ys -> foldr (:) ys xs)

{++0} (++) []     = (\ys -> ys)
{++1} (++) (x:xs) = (\ys -> x : (xs ++ ys))

-- Por extensionalidad funcional quiero ver que:
∀ xs :: [a] => append xs = (++) xs

-- Uso induccion estructural en xs
-- Basta ver que

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a, xs :: [a] => (P(xs) => P(x:xs))
con P(xs) : append xs = (++) xs

-- Caso Base:
append [] = (++) []   = {A0}
(\ys -> ys) = (++) [] = {++0}
(\ys -> ys) = (\ys -> ys)
-- Se cumple el caso base

-- Caso Inductivo:
{HI} : P(xs) = append xs = (++) xs

-- Qvq:
∀ x :: a, xs :: [a]. append (x:xs) = (++) (x:xs)

-- Lado Izq:
append (x:xs) = {A1}
(\ys -> foldr (:) ys (x:xs))     = {DEF foldr}
(\ys -> (:) x (foldr (:) ys xs)) = {A1} 
-- append xs = (\ys -> foldr (:) ys xs) => append xs ys = foldr (:) ys xs
(\ys -> (:) x (append xs ys))    = {HI}
(\ys -> (:) x ((++) xs ys))      = {++1}
(\ys -> (:) x (xs ++ ys))        = 

-- Lado Der:
(++) (x:xs)
= {++1}
(\ys -> (:) x (xs ++ ys))

-- Como lado izq = lado der , demuestro el caso inductivo.
```
## 4.3
```haskell
-- Definiciones
{M0} : map f [] = []
{M1} : map f (x:xs) = f x : map xs

-- Por extensionalidad funcional quiero ver que:
∀ xs :: [a]. map id xs = id xs

-- Usando induccion estructural sobre xs quiero ver que vale:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P([]) => P(x:xs)

-- Caso base:
map id [] = id []
= {M0}
[]        = id []
          = {DEF id}
[]        = []  -- > Queda demostrado el caos base

-- Caso inductivo:
{HI}: P(xs): map id xs = id xs

-- Qvq:
P(x:xs):∀ xs :: [a],∀ x :: a. map id (x:xs) = id (x:xs)

-- lado izq:
map id (x:xs)    = {M1}
id x : map id xs = {HI}
id x : id xs     = {DEF id}
(x : xs)  
{- Como lado izq = lado der , queda probado el caso inductivo. -}
```
## 4.4
```haskell
∀ f :: a->b .∀ g::b->c .map (g . f) = map g . map f

-- Definiciones:
{M0} : map f [] = []
{M1} : map f (x:xs) = f x : map xs

-- Por extensionalidad funcional quiero ver que:
∀ xs :: [a]
map (g . f) xs = map g . map f xs

-- Usando induccion estructural en xs quiero ver que valen:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)

-- Caso base
map (g . f) [] = map g . map f [] = {M0}
[]             = map g . map f [] = {DEF (.)}
[]             = map g (map f []) = {M0}
[]             = map g []         = {M0}
[]             = []  
{- Queda demostrado el caso base. -}

-- Caso inductivo

{HI}: P(xs): ∀ xs :: [a], ∀ f :: a -> b .∀ g :: b -> c  
      map (g . f) xs = map g . map f xs

-- Qvq:
P(x:xs): ∀ xs :: [a], ∀ f :: a -> b .∀ g :: b -> c, ∀ x :: a
         map (g . f) (x:xs) = map g . map f (x:xs)

-- Lado izq:
map (g . f) (x:xs)           = {M1}
(g . f) x : map (g . f) xs   = {HI}
(g . f) x : map g . map f xs = {DEF (.)}
g (f x) : map g (map f xs)

-- Lado der:
map g . map f (x:xs)   = {DEF (.)}
map g (map f (x:xs))   = {M1}
map g (f x : map f xs) = {M1}
g (f x) : map g (map f xs)

{- Como lado der = lado izq , queda probado el caso inductivo. -}

```
## 4.5
```haskell
-- Definiciones:
{M0} : map f [] = []
{M1} : map f (x:xs) = f x : map xs

{F0} : filter p [] = []
{F1} : filter p (x:xs) = if p x then x : filter p xs else filter p xs

-- Quiero probar que:
∀ f :: a -> b .∀ p :: b -> Bool .map f . filter (p . f) = filter p . map f
 
-- Por extensionalidad funcional basta ver que
∀ xs :: [a]. ∀ f :: a -> b .∀ p :: b -> Bool .
map f . filter (p . f) xs = filter p . map f xs

-- Uso induccion estructural en xs
1) Caso Base. P([])
map f . filter (p . f) [] = filter p . map f []

-- Lado izq:
map f . filter (p . f) [] = {.}
map f (filter (p . f) []) = {F0}
map f ([])                = {M0}
[]

-- Lado der:
filter p . map f [] = {.}
filter p (map f []) = {M0}
filter p []         = {F0}
[]
{- Queda demostrado el caso base. -}

Caso Inductivo. ∀ xs :: [a].  ∀ x :: a
                P(xs) => P(x:xs)
-- Sea:
{HI}: P(xs) = ∀ f :: a -> b . ∀ p :: b -> Bool .
              map f . filter (p . f) xs = filter p . map f xs
-- Qvq:
P(x:xs) = ∀ f :: a -> b . ∀ p :: b -> Bool . ∀ xs :: [a]. ∀ x :: a
          map f . filter (p . f) (x:xs) = filter p . map f (x:xs)

-- Lado izq:
map f . filter (p . f) (x:xs)                                          = {.}
map f (filter (p . f) (x:xs))                                          = {F1}
map f (if (p . f) x then x : filter (p . f) xs else filter (p . f) xs) = {LGB}
-- Separo en casos:
A) (p . f) x = p (f x) = True
B) (p . f) x = p (f x) = False

-- Caso A:
map f (x : filter (p . f) xs)     = {M1}
f x : (map f (filter (p . f) xs)) = {HI}
f x : (filter p . map f xs)       = {.}
f x : (filter p (map f xs))

-- Lado der
filter p . map f (x:xs)                              = {.}
filter p (map f (x:xs))                              = {M1}
filter p (f x : map f xs)                            = {F1}
-- llamo g = filter p  
if p (f x) then f x : g (map f xs) else g (map f xs) = {Por estar en caso A}
f x : (filter p (map f xs))   
{- Queda demostrado caso A. -}     

-- Caso B:
map f (filter (p . f) xs) = {HI}
filter p . map f xs       = {.}
filter p (map f xs)

-- Lado der:
ilter p . map f (x:xs)                               = {.}
filter p (map f (x:xs))                              = {M1}
filter p (f x : map f xs)                            = {F1}
-- llamo g = filter p  
if p (f x) then f x : g (map f xs) else g (map f xs) = {Por estar en caso B}
filter p (map f xs)
{- Queda demostrado caso B.-}
{- Como valen caso A y B, queda demostrado caso inductivo.-}
```
## 4.6
```haskell
-- Definiciones:
-- elem :: a -> [a] -> Bool
{E0} elem e [] = False
{E1} elem e (x:xs) = e == x || elem e xs

-- map :: (a -> b) -> [a] -> [b]
{M0} map f [] = []
{M1} map f (x:xs) = f x : map f xs

-- Quiero probar que:
∀ f::a->b . ∀ e::a . ∀ xs::[a] . ((elem e xs) ⇒ (elem (f e) (map f xs)))

-- Uso induccion estructural sobre xs:

Caso Base. P([])
(elem e []) ⇒ (elem (f e) (map f [])) = {E0}
False ⇒ (elem (f e) (map f []))       = {Bool}
True
{- Queda demostrado el caso Base. -}

Caso Inductivo. 
-- Sea
{HI}: P(xs) = ∀ f::a->b . ∀ e::a. ((elem e xs) ⇒ (elem (f e) (map f xs)))

-- Qvq:
P(x:xs) = ∀ f::a->b . ∀ e::a. ∀ xs :: [a], ∀ x :: a.
          (elem e (x:xs)) ⇒ (elem (f e) (map f (x:xs)))

elem e (x:xs) ⇒ elem (f e) (map f (x:xs))           = {E1}
e == x || elem e xs ⇒ elem (f e) (map f (x:xs))     = {M1}
e == x || elem e xs ⇒ elem (f e) (f x : (map f xs)) = {LGB}
-- Separo en casos:
A) e == x
B) e != x

-- Caso A)
True || elem e xs ⇒ elem (f e) (f x : map f xs) = {Bool}
True ⇒ elem (f e) (f x : map f xs)              = {E1}
True ⇒ (f e) == (f x) || elem (f e) (map f xs)  = {Por caso A, f e == f x}
True ⇒ True || elem (f e) (map f xs)            = {Bool}
True
{- Queda demostrado caso A. -}

-- Caso B)
False || elem e xs ⇒ elem (f e) (f x : map f xs)     = {Bool}
elem e xs ⇒ elem (f e) (f x : map f xs)              = {E1}
elem e xs ⇒ (f e) == (f x) || elem (f e) (map f xs)  = {LGB}
-- Separo en casos:
B.1) elem e xs = True
B.2) elem e xs = False

-- Caso B.1)
True ⇒ (f e) == (f x) || elem (f e) (map f xs) = {HI}
True ⇒ (f e) == (f x) || True                  = {Bool}
True
{- Queda demostrado caso B.1-}

-- Caso B.2)
False ⇒ (f e) == (f x) || elem (f e) (map f xs) = {Bool}
True
{- Queda demostrado caso B.2.
   Luego, queda demostrado Caso B. 
   Por lo tanto queda demostrado caso inductivo. -}
```