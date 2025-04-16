## 5
```haskell
-- Demostrar:
 zip = zip’

-- zip :: [a] -> [b] -> [(a,b)]
{Z0} zip = 
foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const[])

-- zip’ :: [a] -> [b] -> [(a,b)]
{Z’0} zip’ [] ys = []
{Z’1} zip’ (x:xs) ys = if null ys then [] else (x, head ys):zip’ xs (tail ys)

-- Por el principio de extensionalidad funcional quiero ver que:
∀ xs, ys :: [a] . zip xs ys = zip' xs ys

-- Usando induccion estructural sobre xs quiero ver que valen:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
con P(x): zip xs ys = zip' xs ys

-- Caso Base:
zip [] ys = zip' [] ys

-- Lado izq:
zip [] ys
= {Z0}
foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const[]) [] ys
= {DEF foldr}
(const [])
= {DEF const}
[]

-- Lado der:
zip' [] ys
= {Z' 0}
[]

-- > Como lado izq = lado der, Queda demostrado caso Base.

-- Caso inductivo:

{HI}: zip xs ys = zip' xs ys

-- Qvq:
{TI}: zip (x:xs) ys = zip' (x:xs) ys

-- lado izq:
zip (x:xs) ys
= {Z0} -- llamo f = (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys))
foldr f (const[]) (x:xs) ys
= {DEF foldr}
f x (foldr f (const[]) xs) ys
-- Por lema de generacion de listas separo en casos:
A) ys = []
B) ∃ z :: a, ∃ zs :: [a] ys = z:zs

-- Caso A)
f x (foldr f (const[]) xs) []
= {B}
\rec ys -> if null ys then [] else (x, head ys) : rec (tail ys) (foldr f (const[]) xs) []
= {B}
[]

-- Lado der:
zip' (x:xs) []
= {Z'1}
[]
-- Como lado der = lado izq en caso A) , queda demostrado el caso A)

-- Caso B)
f x (foldr f (const[]) xs) (z:zs)
= {B}
(\rec ys -> if null ys then [] 
            else (x, head ys) : rec (tail ys)) (foldr f (const[]) xs) (z:zs)
= {B}
(x,z) : (foldr f (const[]) xs) zs
{Z0}
(x,z) : zip xs zs
= {HI}
(x,z) : zip' xs zs

-- Lado der:
zip' (x:xs) (z:zs)
= {Z1}
(x,z) : zip' xs zs

-- Como lado izq = lado der en caso B) , queda demostrado caso B).

-- Como vale A) y B) queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado P(xs).
```