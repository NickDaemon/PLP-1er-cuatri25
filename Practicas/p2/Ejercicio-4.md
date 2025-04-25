## 4.1
```haskell
reverse . reverse = id

-- Definiciones:
-- reverse :: [a] -> [a]
{R0} reverse xs = foldl (flip (:)) [] xs
{R1} reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs
{R2} reverse xs ++ ys = foldl (flip (:)) ys xs

-- Por extensionalidad funcional quiero ver que:
∀ xs :: [a]. reverse . reverse xs = id xs

-- Usando induccion estructural sobre xs quiero ver que vale:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a, xs :: [a]. P(x) => P(x:xs)

-- Caso Base:
reverse . reverse []             = id []
= {(.)}
reverse (reverse [])             = id []
= {R0}
reverse (foldl (flip (:)) [] []) = id []
= {DEF foldl}
reverse []                       = id []
= {R0}
foldl (flip (:)) [] []           = id []
= {DEF foldl}
[]                               = id []
                                 = {ID}
[]                               = []  -- > Queda demostrado el caso base.

-- Caso Inductivo:

{HI}: reverse . reverse xs = id xs

-- Qvq:
{TI}: reverse . reverse (x:xs) = id (x:xs)

reverse . reverse (x:xs)                            = id (x:xs)
= {(.)}
reverse (reverse (x:xs))                            = id (x:xs)
= {R1}
reverse (foldr (\x rec -> rec ++ (x:[])) [] (x:xs)) = id (x:xs)
= {foldr} -- > llamo f = (\x rec -> rec ++ (x:[]))
reverse (f x (foldr f [] xs))                       = id (x:xs)
= {R0}
reverse (f x reverse xs)                            = id (x:xs)
= {B}
reverse (reverse xs ++ [x])                         = id (x:xs)
= {Lema}
x : reverse (reverse xs)                            = id (x:xs)
= {HI}
x : id xs                                           = id (x:xs)
= {ID}
(x:xs)                                              = (x:xs)

-- Lema
∀ xs :: [a], x :: a
reverse (xs ++ [x]) = x : reverse xs

-- Uso induccion estructural en xs:

-- Caso base
reverse ([] ++ [x]) = (x : reverse [])
reverse [x] = x : reverse []
[x] = [x]

-- Caso inductivo
{HI}: reverse (xs ++ [x]) = x : reverse xs
reverse (y:xs ++ [x]) = (x : reverse (y:xs))

-- Lado izq:
reverse ((y:xs) ++ [x])
= {++1}
reverse (y:(xs ++ [x]))
= {R1} -- > f = (\x rec -> rec ++ [x])
foldr f [] (y:(xs ++ [x]))
= {foldr}
f y (foldr f [] (xs ++ [x]))
= {B}
(\rec -> rec ++ [y]) (foldr f [] (xs ++ [x]))
= {R0}
(\rec -> rec ++ [y]) (reverse (xs ++ [x]))
= {B}
reverse (xs ++ [x]) ++ [y]
= {HI}
(x : reverse xs) ++ [y]
= {++1}
x : (reverse xs ++ [y])

-- Lado der:
x : (reverse (y:xs))
= {R1} -- > f = (\x rec -> rec ++ [x])
x : (foldr f [] (y:xs))
= {foldr}
x : (f y (foldr f [] xs))
= {R0}
x : (f y (reverse xs))
= {B}
x : (reverse xs ++ [y])

-- Como lado izq = lado der , queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado el lema.
```
## 4.2
```haskell
append = (++)

-- Por extensionalidad funcional quiero ver que:
∀ xs,ys :: [a]
append xs ys = (++) xs ys

-- Definiciones:
-- append :: [a] -> [a] -> [a]
{A0} append xs ys = foldr (:) ys xs

-- (++) :: [a] -> [a] -> [a]
{++0} [] ++ ys = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

-- Usando induccion estructural sobre xs quiero ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
con P(x) : append xs ys = (++) xs ys

-- Caso Base:
append [] ys    = (++) [] ys
= {A0}
foldr (:) ys [] = (++) [] ys
= {DEf foldr}
ys              = (++) [] ys
                = {++0}
ys              = ys -- > Queda demostrado el caso base.

-- Caso Inductivo:

{HI} : append xs ys = (++) xs ys

-- Qvq:
{TI} : append (x:xs) ys = (++) (x:xs) ys

-- Lado izq:
append (x:xs) ys
= {A0}
foldr (:) ys (x:xs)
= {foldr}
(:) x (foldr (:) ys xs)
= {A0}
(:) x (append xs ys)
= {HI}
(:) x ((++) xs ys)
= {(:)}
x : ((++) xs ys)

-- Lado der:
(++) (x:xs) ys
= {++1}
x : ((++) xs ys)

-- > Como lado izq = lado der , queda demostrado el caso inductivo
-- Por lo tanto queda demostrado P(xs).
```
## 4.3
```haskell
map id = id

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
{HI}: map id xs = id xs

-- Qvq:
{TI}: map id (x:xs) = id (x:xs)

-- lado izq:
map id (x:xs)
= {M1}
id x : map id xs
= {HI}
id x : id xs
= {DEF id}
(x : xs)  -- > Como lado izq = lado der , queda probado el caso inductivo.
-- Por lo tanto queda demostrado P(xs)
```
## 4.4
```haskell
∀ f :: a->b .∀ g::b->c .map (g . f) = map g . map f

-- Definiciones:
{M0} : map f [] = []
{M1} : map f (x:xs) = f x : map xs

-- Por extensionalidad funcional quiero ver que:
∀ xs :: a
map (g . f) xs = map g . map f xs

-- Usando induccion estructural en xs quiero ver que valen:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)

-- Caso base
map (g . f) [] = map g . map f []
= {M0}
[]             = map g . map f []
               = {DEF (.)}
[]             = map g (map f [])
               = {M0}
[]             = map g []
               = {M0}
[]             = []  -- > Queda demostrado el caso base.

-- Caso inductivo

{HI}: map (g . f) xs = map g . map f xs

-- Qvq:
{TI}: map (g . f) (x:xs) = map g . map f (x:xs)

-- Lado izq:
map (g . f) (x:xs)
= {M1}
(g . f) x : map (g . f) xs
= {HI}
(g . f) x : map g . map f xs
= {DEF (.)}
g (f x) : map g (map f xs)

-- Lado der:
map g . map f (x:xs)
= {DEF (.)}
map g (map f (x:xs))
= {M1}
map g (f x : map f xs)
= {M1}
g (f x) : map g (map f xs)

-- > Como lado der = lado izq , queda probado el caso inductivo
-- Por lo tanto queda demostrado P(xs)
```
## 4.5
```haskell
∀ f::a->b .∀ p::b->Bool .map f . filter (p . f) = filter p . map f

-- Definiciones:
{M0} : map f [] = []
{M1} : map f (x:xs) = f x : map xs

{F0} : filter p [] = []
{F1} : filter p (x:xs) = if p x then x : filter p xs else filter p xs
 
-- Por extensionalidad funcional quiero ver que

∀ xs :: [a]. map f . filter (p . f) xs = filter p . map f xs

-- Usando induccion estructural sobre xs quiero ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
con P(xs): map f . filter (p . f) xs = filter p . map f xs

-- Caso Base:
map f . filter (p . f) [] = filter p . map f []

-- Lado izq:
map f . filter (p . f) []
= {DEF (.)}
map f (filter (p . f) [])
= {F0}
map f []
= {M0}
[]

-- Lado der:
filter p . map f []
= {DEF (.)}
filter p (map f [])
= {M0}
filter p []
= {F0}
[]   
-- Como lado der = lado izq , queda demostrado el caso base.

-- Caso inductivo:
{HI}: map f . filter (p . f) xs = filter p . map f xs

-- Qvq:
{TI}: map f . filter (p . f) (x:xs) = filter p . map f (x:xs)

-- Lado izq:
map f . filter (p . f) (x:xs)
= {DEF (.)}
map f (filter (p . f) (x:xs))
= {F1}
map f (if (p . f) x then x : filter (p . f) xs else filter (p . f) xs)
-- Por lema de generacion de booleanos separo en casos:
A) (p . f) x = p (f x) = True
B) (p . f) x = p (f x) = Falase

-- Caso A)
map f (x : filter (p . f) xs)
= {M1}
f x : map f (filter (p . f) xs)
= {DEF (.)}
f x : map f . filter (p . f) xs
= {HI}
f x : filter p . map f xs

-- Caso B)
map f (filter (p . f) xs)
= {HI}
filter p . map f xs

-- Lado der:
filter p . map f (x:xs)
= {DEF (.)}
filter p (map f (x:xs))
= {M1}
filter p (f x : map f xs)
= {F1}
(if p (f x) then f x : filter p map f xs else filter p (map f xs))
-- Por lema de generacion de bool separo en casos:
A) p (f x) = True
B) p (f x) = False

-- Caso A)
f x : filter p map f xs 
-- > Como ambos casos A) coinciden y cuando es True en uno es True en el otro
--   queda demostrado el caso A)

-- Caso B)
filter p (map f xs)
= {DEF (.)}
filter p . map f xs
-- > Como ambos casos B) coinciden y cuando es False en uno es False en el otro
--   queda demostrado el caso B) 

-- Por lo tanto queda demostrado caso inductivo.
```
## 4.6
```haskell
∀ f::a->b .∀ e::a .∀ xs::[a] .((elem e xs) ⇒ (elem (f e) (map f xs)))
(asumiendo Eq a y Eq b)

-- DEfinciones
{M0} : map f [] = []
{M1} : map f (x:xs) = f x : map xs

{E0} : elem e [] = False
{E1} : elem e (x:xs) = e == x || elem e xs

-- Usando induccion estructural en xs quiero ver que valen:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
con P(x): ((elem e xs) ⇒ (elem (f e) (map f xs)))

-- Caso Base:
((elem e []) => (elem (f e) (map f [])))
= {E0}
False => (elem (f e) (map f []))
-- False implica Q es True para cualquier Q , queda demostrado el caso Base.

-- Caso inductivo:

{HI}: ((elem e xs) => (elem (f e) (map f xs)))

-- Qvq:
{TI}: ((elem e (x:xs)) => (elem (f e) (map f (x:xs))))

elem e (x:xs) => elem (f e) (map f (x:xs))
= {E1}
e == x || elem e xs => elem (f e) (map f (x:xs))
= {M1} -- LLamo P = e == x || elem e xs
P => elem (f e) (f x : map f xs)
= {E1}
e == x || elem e xs => (f e) == (f x) || elem (f e) (map f xs)
-- Por lema de generacion de bool separo en casos:
A) e == x
B) e != x

-- Caso A)
True || elem e xs => (f e) == (f x) || elem (f e) (map f xs)
-- Como e == x --> f e == f x
True || elem e xs => True || elem (f e) (map f xs)
= {Bool}
True => True -- > Queda demostrado caso A)

-- Caso B)
False || elem e xs => False || elem (f e) (map f xs)
= {Bool}
elem e xs => elem (f e) (map f xs)
-- Por lema de generacion de bool separo en casos:
B.1) elem e xs = False
B.2) elem e xs = True

-- Caso B.1)
False => elem (f e) (map f xs) -- > False => Q , es True para todo Q , queda demostrado.

-- Caso B.2)
elem e xs => elem (f e) (map f xs)
= {HI}
True -- > Queda demostrado el caso B.2) , por lo tanto queda demostrado caso B)

-- Como esta demostrado A) Y B) queda demostrado el paso inductivo.
-- Por lo tanto queda demostrado P(xs).
```