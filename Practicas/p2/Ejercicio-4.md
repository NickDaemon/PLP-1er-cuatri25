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
2) Caso Inductivo. ∀ x :: a. P(x) => P(x:xs)

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
x : reverse (reverse xs)                          = id (x:xs)
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