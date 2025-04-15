## Ejercicio parcial - implicacion
```haskell
-- Definiciones:

-- data AEB a = Hoja a | Bin (AEB a) a (AEB a)

-- length :: [a] -> Int
{L0} length [] = 0
{L1} length (x:xs) = 1 + length xs

-- null :: [a] -> Bool
{N0} null [] = True
{N1} null (x:xs) = False

-- altura :: AEB a -> Int
{A0} altura (Hoja _) = 1
{A1} altura (Bin i r d) = 1 + max (altura i) (altura d)

-- esPreRama :: Eq a => AEB a -> [a] -> Bool
{E0} esPreRama (Hoja x) = \xs -> null xs || (xs == [x])
{E1} esPreRama (Bin i r d) = 
\xs -> null xs || (r == head xs && (esPreRama i (tail xs) || esPreRama d (tail xs)))

-- (==) :: Eq a [a] -> [a] -> Bool ⇒ (Escrita en 4 casos para facilitar la demostración)
{==0} [] == [] = True
{==1} [] == (_:_) = False
{==2} (_:_) == [] = False
{==3} (x:xs) == (y:ys) = (x == y) && (xs == ys)

-- Lema:
∀ t :: AEB a . 0 ≤ altura t

-- Demostrar
∀ t :: AEB a, xs :: [a]. (esPreRama t xs => length xs ≤ altura t)

-- Uso induccion estructural en t y quiero ver que valen:
1) Caso base: ∀ x :: a. P(Hoja x)

2) Caso inductivo: ∀ i , d :: AEB a, r :: a 
                   (P(i) && P(d)) => P(Bin i r d)

con P(i): (esPreRama i xs => length xs ≤ altura i)
    P(d): (esPreRama d xs => length xs ≤ altura d)

-- Caso Base:
esPreRama (Hoja x) xs => length xs ≤ altura (Hoja x)
= {E0}
(\xs -> null xs || (xs == [x])) xs => length xs ≤ altura (Hoja x)
= {B}
null xs || (xs == [x]) => length xs ≤ altura (Hoja x)
= {A0}
null xs || (xs == [x]) => length xs ≤ 1

-- Por lema de generacion de listas, separo en casos
A) xs = []
B) ∃ y :: a, ys :: [a]. xs = (y:ys)

-- Caso A)
null [] || ([] == [x]) => length [] ≤ 1
= {L0}
null [] || ([] == [x]) => 0 ≤ 1
= {Bool}
True || False => True -- > True => True = True , queda demostrado caso A)

-- Caso B)
null (y:ys) || ((y:ys) == [x]) => length (y:ys) ≤ 1
= {L1}
False || ((y:ys) == [x]) => 1 + length ys ≤ 1
= {== 3}
y == x && ys == [] => 1 + length ys ≤ 1
-- Por lema de generacion de listas,  separo en casos
B.1) ys = []
B.2) ∃ z :: a, zs :: [a]. ys = (z:zs)

-- Caso B.1)
y == x && [] == [] => 1 + length [] ≤ 1
= {L0}
y == x && [] == [] => 1 + 0 ≤ 1
-- > si y == x , la implicacion es true, si y != x , la implicacion tmb vale.
-- Queda demostrado B.1)

-- Caso B.2
y == x && (z:zs) == [] => 1 + length (z:zs) ≤ 1
-- False => Q ,  es True para cualquier Q , queda demostrado B.2)

-- Por lo tanto queda demostrado el caso Base.

-- Caso inductivo:

{HI} : P(i) && P (d), es decir:
( xs::[a].(esPreRama i xs => length xs ≤ altura i)) && 
( xs::[a].(esPreRama d xs => length xs ≤ altura d))

-- altura :: AEB a -> Int
{A0} altura (Hoja _) = 1
{A1} altura (Bin i r d) = 1 + max (altura i) (altura d)

-- esPreRama :: Eq a => AEB a -> [a] -> Bool
{E0} esPreRama (Hoja x) = \xs -> null xs || (xs == [x])
{E1} esPreRama (Bin i r d) = 
\xs -> null xs || (r == head xs && (esPreRama i (tail xs) || esPreRama d (tail xs)))

-- Qvq:
(esPreRama (Bin i r d) xs => length xs ≤ altura (Bin i r d))
= {E1}
\xs -> null xs || (r == head xs && (esPreRama i (tail xs) || esPreRama d (tail xs))) xs
= {B}
null xs || (r == head xs && (esPreRama i (tail xs) || esPreRama d (tail xs)))
-- Por lema de generacion de listas, separo en casos:
A) xs = []
B) ∃ y :: a, ys :: [a]. xs = (y:ys)

-- Caso A)
True || Q => length [] ≤ altura (Bin i r d)
= {L0}
True => 0 ≤ altura (Bin i r d)
= {Lema}
True => True -- > Queda demostrado caso A)

-- Caso B)
False || (r == head (y:ys) && (esPreRama i (tail (y:ys)) || esPreRama d (tail (y:ys))))
= {H}, {T}
r == y && (esPreRama i ys || esPreRama d ys) => length (y:ys) ≤ altura (Bin i r d)
-- Si r != y , la implicacion es verdadera.
-- Caso r == y:
(esPreRama i ys || esPreRama d ys) => length (y:ys) ≤ altura (Bin i r d)
-- Por lema de generacion de Bool , separo en casos:
B.1) esPreRama i ys = True
B.2) esPreRama i ys = False

-- Caso B.1)
True || esPreRama d ys => length (y:ys) ≤ altura (Bin i r d)
= {Bool}, {L1}, {A1} -- > Hacerlo por pasos , aca lo hago para resumir un toque uwu
True => 1 + length ys ≤ 1 + max (altura i) (altura d)
= {Int}
True => length ys ≤ max (altura i) (altura d)
-- Por HI como esPreRama i ys es True , eso significa que length ys ≤ altura i
-- Por lo tanto si altura d es mayor que altura i , se cumple la implicacion.
-- Y si altura i es mayor que altura d , tmb se cumple la implicacion.
-- Queda demostrado caso B.1)

-- Caso B.2)
esPreRama d ys => length (y:ys) ≤ altura (Bin i r d)
= {L1}, {A1}
esPreRama d ys => length ys ≤ max (altura i) (altura d)
-- Si esPreRama d ys = False , se cumple la implicacion.
-- Si esPreRama d ys = True, por HI length ys ≤ altura d
-- por lo tanto length ys ≤ max altura i altura d, es True
-- Queda demostrado caso B.2)

-- Por lo tanto queda demostrado P(t).



