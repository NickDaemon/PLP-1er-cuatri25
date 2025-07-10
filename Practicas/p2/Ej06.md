## 6.1
```haskell
-- Definiciones:
{E0} elem e [] = False
{E1} elem e (x:xs) = e == x || elem e xs

{F0} filter p [] = []
{F1} filter p (x:xs) = if p x then x : filter p xs else filter p xs

-- Probar:
Eq a => ∀ xs::[a] .∀ e::a .∀ p::a -> Bool .elem e xs && p e = elem e (filter p xs)
-- Uso induccion estructural sobre xs:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)

-- Caso base:
elem e [] && p e = elem e (filter p [])
= {E0}
False && p e = elem e (filter p [])
= {F0} y {Bool}
False = elem e []
= {E0}
False = False -- > Se cumple el caso base.

-- Caso inductivo:
{HI}: elem e xs && p e = elem e (filter p xs)

-- Qvq:
{TI}: elem e (x:xs) && p e = elem e (filter p (x:xs))


-- Lado der:
elem e (filter p (x:xs))
= {F1}
elem e (if p x then x : filter p xs else filter p xs)
-- Por lema de bool separo en casos:
A) p x = True
B) p x = False

-- Caso A.1)
-- Lado der
elem e (x : filter p xs)
= {E1}
e == x || elem e (filter p xs)
-- Por lema de bool separo en casos:
A.1) e == x
A.2) e != x

-- Caso A.1)
-- Lado der
True || elem e (filter p xs)
= {Bool}
True

-- Lado izq:
elem e (x:xs) && p e
= {E1}
e == x || elem e xs && p e
-- Como e == x , p e = p x , y estamos en caso A) donde p x = True
True || elem e xs && True
= {Bool}
True  -- > Queda demostrado A.1)

-- Caso A.2
-- lado der:
False || elem e (filter p xs)
= {Bool}
elem e (filter p xs)

-- lado izq:
elem e (x:xs) && p e
= {E1}
e == x || elem e xs && p e
= {Bool}
elem e xs && p e
= {HI}
elem e (filter p xs) -- > Queda demostrado A.2) por lo tanto tmb vale A).

-- Caso B)
-- lado der
elem e (filter p xs)
= {HI}
elem e xs && p e

-- lado izq:
elem e (x:xs) && p e
(e == x || elem e xs) && p e
-- Por lema de bool separo en casos:
B.1) e == x
B.2) e != x

-- Caso B.1)
-- lado izq
(True || elem e xs) && p e
= {Bool} -- como e == x , p e = p x y como estamos en caso B) 
True && False
= {Bool}
False

-- lado der
elem e xs && p e
= {Bool} -- Por la misma razon que en lado izq
elem e xs && False
= {Bool}
False  -- > Queda demostrado Caso B.1)

-- Caso B.2)
-- lado izq
(False || elem e xs) && p e
= {Bool}
elem e xs && p e

-- lado der
elem e xs && p e  -- > Queda demostrado Caso B.2) por lo tanto queda probado caso B)

-- Como valen A) y B) queda demostrado el paso inductivo
-- Por lo tanto queda probado P(xs)
```

## 6.2
```haskell
Eq a => ∀ xs::[a] .∀ e::a .elem e xs = elem e (nub xs)

-- Definiciones:
{E0} elem e [] = False
{E1} elem e (x:xs) = e == x || elem e xs

-- nub :: Eq a => [a] -> [a]
{N0} nub [] = []
{N1} nub (x:xs) = x : filter (\y -> x /= y) (nub xs)
 
{F0} filter p [] = []
{F1} filter p (x:xs) = if p x then x : filter p xs else filter p xs

-- Tiene sentido que si un elemento esta en una lista , tmb va a estar 
-- En la misma lista sin repetidos.
-- Uso induccion estructural en xs

-- Quiero ver que:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
con P(xs): elem e xs = elem e (nub xs)

-- Caso base:
elem e [] = elem e (nub [])
= {E0}
False = elem e (nub [])
= {N0}
False = elem e []
= {E0}
False = False -- > Queda probado el caso base.

-- Caso inductivo:
{HI}: elem e xs = elem e (nub xs)

-- Qvq:
{TI}: elem e (x:xs) = elem e (nub (x:xs))

-- lado izq:
elem e (x:xs)
= {E1}
e == x || elem e xs

-- lado der:
elem e (nub (x:xs))
= {N1}
elem e (x : filter (\y -> x /= y) (nub xs))
= {E1}
e == x || elem e (filter (\y -> x /= y) (nub xs))
-- Por propiedad de bool separo en casos:
A) e == x
B) e != x

-- Caso A)
-- lado izq:
True || elem e xs
= {Bool}
True

-- lado der:
True || elem e (filter (\y -> x /= y) (nub xs))
= {Bool}
True  -- > Queda probado caso A)

-- Caso B)
-- lado izq:
False || elem e xs
= {Bool}
elem e xs
= {HI}
elem e (nub xs)


-- lado der
False || elem e (filter (\y -> x /= y) (nub xs))
= {Bool}
elem e (filter (\y -> x /= y) (nub xs))
= {--}
-- Como e != x , filter (\y -> x \= y) (nub xs) ,no va a filtrar e de (nub xs).
-- Por lo tanto si e estaba en nub xs lo seguira estando despues del filtro.
-- Entonces si e != x :
-- e ∈ nub xs  <-->  e ∈ filter (\y -> x /= y) (nub xs)
-- En este caso, elem e (nub xs) = elem e (filter (\y -> x /= y) (nub xs))
elem e (nub xs)

-- Como lado izq = lado der queda demostrado caso B)
-- como vale A) y B) , queda demostrado el caso inductivo.

-- Por lo tanto queda demostrado P(xs).
```

## 6.3
```haskell
Eq a => ∀ xs::[a] .∀ ys::[a] .∀ e::a .elem e (union xs ys) = (elem e xs) || (elem e ys)


-- Definiciones:
-- nub :: Eq a => [a] -> [a]
{N0} nub [] = []
{N1} nub (x:xs) = x : filter (\y -> x /= y) (nub xs)

--union :: Eq a => [a] -> [a] -> [a]
{U0} union xs ys = nub (xs++ys)

-- Tiene sentido que si un elemento esta en la union de dos listas filtrando repetidos
-- tiene que estar en una de esas dos listas unidas

-- Uso induccion estructural en xs
-- Qvq:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)

-- Caso base:
elem e (union [] ys)    = (elem e []) || (elem e ys)
= {U0}
elem e (nub ([] ++ ys)) = (elem e []) || (elem e ys)
= {++0}
elem e (nub ys)         = (elem e []) || (elem e ys)
                        = {E0}
elem e (nub ys)         = False || (elem e ys)
                        = {Bool}
elem e (nub ys)         = elem e ys
= {Lema 6.2}
elem e ys               = elem e ys
-- Queda demostrado el caso base

-- Caso inductivo:

{HI}: elem e (union xs ys) = (elem e xs) || (elem e ys)

-- Qvq:
{TI}: elem e (union (x:xs) ys) = (elem e (x:xs)) || (elem e ys)

-- lado izq:
elem e (union (x:xs) ys)
= {U0}
elem e (nub ((x:xs) ++ ys))
= {++1}
elem e (nub (x:(xs ++ ys)))
= {N1}
elem e (x : filter (\y -> x /= y) (nub (xs ++ ys)))
= {E1}
e == x || elem e (filter (\y -> x /= y) (nub (xs ++ ys)))
= {U1}
e == x || elem e (filter (\y -> x /= y) (union xs ys))

-- lado der:
(elem e (x:xs)) || (elem e ys)
= {E1}
(e == x || elem e xs) || (elem e ys)

-- Por lema de generacion de bool separo en casos:
A) e == x
B) e != x

-- Caso A)
-- lado izq:
e == x || elem e (filter (\y -> x /= y) (union xs ys))
= {Bool}
True || ... -- > True o Q es true para todo Q.
= {Bool}
True

-- lado der:
(True || elem e xs) || (elem e ys)
= {Bool}
True || ... -- > idem item anterior
= {Bool}
-- Queda demostrado caso A)

-- Caso B)
-- lado izq:
False || elem e (filter (\y -> x /= y) (union xs ys))
= {Bool}
elem e (filter (\y -> x /= y) (union xs ys))
= -- como e != x , e ∈ union xs ys  <-->  e ∈ filter (\y -> x /= y) (union xs ys)
elem e (union xs ys)
= {HI}
(elem e xs) || (elem e ys)

-- lado der:
(False || elem e xs) || (elem e ys)
= {Bool}
(elem e xs) || (elem e ys)
-- Queda demostrado caso B)
-- Queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado P(xs).
```
## 6.4
```haskell
∀ xs::[a] .∀ ys::[a] .∀ e::a .elem e (intersect xs ys) = (elem e xs) && (elem e ys)
asumiendo Eq => a

-- definiciones:
-- intersect :: Eq a => [a] -> [a] -> [a]
{I0} intersect xs ys = filter (\e -> elem e ys) xs

-- Por definicion de la interseccion un elemento pertenece a ella si esta en ambos.

-- Uso induccion estructural en xs:

-- Qvq:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: P(xs) => P(x:xs)
con P(xs) : elem e (intersect xs ys) = (elem e xs) && (elem e ys)

-- Caso Base:
elem e (intersect [] ys) = (elem e []) && (elem e ys)
= {I0}
elem e (filter (\e -> elem e ys) []) = elem e [] && elem e ys
= {F0}
elem e [] = elem e [] && elem e ys
= {E0}
False = False && elem e ys
-- Queda demostrado el caso base

-- Caso inductivo:

{HI}: elem e (intersect xs ys) = (elem e xs) && (elem e ys)

-- Qvq:
{TI}: elem e (intersect (x:xs) ys) = (elem e (x:xs)) && (elem e ys)

-- Lado der:
(elem e (x:xs)) && elem e ys
= {E1}
((e == x) || (elem e xs)) && elem e ys

-- Lado izq:
elem e (intersect (x:xs) ys)
= {I0}
elem e (filter (\e -> elem e ys) (x:xs))
= {F1}
elem e (if elem x ys then x : filter (\e -> elem e ys) xs else filter (\e -> elem e ys) xs)
-- Por lema de generacion de bool separo en casos:
A) elem x ys = True
B) elem x ys = False

-- Caso A)
-- lado izq:
elem e (x : filter (\e -> elem e ys) xs)
= {I0}
elem e (x : intersect xs ys)
= {E1}
e == x || elem e intersect xs ys
-- Por lema de bool separo en casos:
A.1) e == x
A.2) e != x

-- Caso A.1)
-- lado izq:
True || elem e (intersect xs ys)
= {Bool}
True

-- lado der:
(True || (elem e xs)) && elem e ys
= {Bool}
True && elem e ys
-- Como estoy en caso A) y en particular A.1) se cumple que:
-- e == x y elem x ys = True , como e == x, puedo hacer elem x ys = elem e ys
-- entonces:
True && True  -- > Se cumple caso A.1)

-- Caso A.2)
-- lado izq:
False || elem e (intersect xs ys)
= {Bool}
elem e (intersect xs ys)

-- lado der:
(False || (elem e xs)) && elem e ys
= {Bool}
(elem e xs) && (elem e ys)
= {HI}
elem e (intersect xs ys) -- > Se cumple caso A.2) por lo tanto se demuestra caso A)

-- Caso B)
-- lado izq:
elem e (filter (\e -> elem e ys) xs)
= {I0}
elem e (intersect xs ys)
= {HI}
(elem e xs) && (elem e ys)

-- lado der:
((e == x) || (elem e xs)) && elem e ys
-- Por lema de generacion de bool separo en casos:
B.1) e == x
B.2) e != x

-- Caso B.1)
-- lado der
(True || (elem e xs)) && (elem e ys)
= {Bool}
True && (elem e ys)
-- > como e == x , y estoy en caso B) elem x ys = False se que :
--   elem e ys = elem x ys = False
True && False
= {Bool}
False

-- lado izq:
(elem e xs) && (elem e ys)
-- Como e == x y estoy en caso B) elem x ys = False se que :
-- elem e ys = elem x ys = False
(elem e xs) && False
{Bool}
False   -- > Queda demostrado caso B.1)

-- Caso B.2)
-- lado der:
(False || (elem e xs)) && (elem e ys)
= {Bool}
(elem e xs) && (elem e ys)

-- lado izq:
(elem e xs) && (elem e ys)  -- > Queda demostrado B.2)

-- Como valen A) y B) queda demostrado el caso inductivo.
-- Por lo tanto queda demostrado P(xs).
```

## 6.5
```haskell
Eq a => ∀ xs::[a] .∀ ys::[a] .length (union xs ys) = length xs + length ys
-- A simple vista se ve que la longitud de la union de A y B no siempre es l(A) + l(B).
-- ContraEjemplo:
A = [1,2,3]
B = [1,4,5]

union A B = [1,2,3,4,5]
Length (union A B) = 5
Length (A) + Length (B) = 6
```
## 6.6
```haskell
Eq a => ∀ xs::[a] .∀ ys::[a] .length (union xs ys) ≤ length xs + length ys

-- Definiciones:
-- nub :: Eq a => [a] -> [a]
{N0} nub [] = []
{N1} nub (x:xs) = x : filter (\y -> x /= y) (nub xs)

-- union :: Eq a => [a] -> [a] -> [a]
{U0} union xs ys = nub (xs++ys)

-- Esto si tiene sentido a diferencia de 6.5
-- Uso induccion estructural en xs:

1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)

-- Caso Base:
length (union [] ys) ≤ length [] + length ys
= {U0}
length (nub ([] ++ ys)) ≤ length [] + length ys
= {++0}
length (nub ys) ≤ length [] + length ys
= {L0}
length (nub ys) ≤ length ys
-- Habria que probarlo con un lema , pero se entiende la idea 
-- nub tiene todos los elementos de ys como maximo , x lo tanto en peor caso
-- su longitud sera menor o igual que ys, uwu.

-- Caso inductivo:

{HI}: length (union xs ys) ≤ length xs + length ys

-- Qvq:
{TI}: length (union (x:xs) ys) ≤ length (x:xs) + length ys

length (union (x:xs) ys)                            ≤ length (x:xs) + length ys
= {U0}
length (nub ((x:xs) ++ ys))                         ≤ length (x:xs) + length ys
= {++1}
length (x : (xs ++ ys))                             ≤ length (x:xs) + length ys
= {N1}
length (x : filter (\y -> x /= y) (nub (xs ++ ys))) ≤ length (x:xs) + length ys
= {L1}
1 + length (filter (\y -> x /= y) (nub (xs ++ ys))) ≤ length (x:xs) + length ys
= {U0}
1 + length (filter (\y -> x /= y) (union xs ys))    ≤ length (x:xs) + length ys
                                                    = {L1}
1 + length (filter (\y -> x /= y) (union xs ys))    ≤ 1 + length xs + length ys
                                                    = {HI}
1 + length (filter (\y -> x /= y) (union xs ys))    ≤ 1 + length (union xs ys)
= {Int}
length (filter (\y -> x /= y) (union xs ys))        ≤ length (union xs ys)
-- Por lema se cumple la desigualdad.

-- Pruebo lema -- Con este no se ve tan claro, agarro la pala >_<
{Lema}: ∀ xs :: [a], p :: (a -> Bool). length (filter p xs) ≤ length xs

-- Uso induccion estructural en xs:
1) Caso Base. P([])
2) Caso Inductivo. ∀ x :: a. P(xs) => P(x:xs)
con P(xs): length filter p xs ≤ length xs

-- Caso Base:
length (filter p []) ≤ length []
= {F0}
length []            ≤ length []
= {L0}
0                    ≤ 0
-- Se cumple el caso base

-- Caso inductivo:

{HI}: length (filter p xs) ≤ length xs

-- Qvq:
{TI}: length (filter p (x:xs))                        ≤ length (x:xs)

length (filter p (x:xs))                              ≤ length (x:xs)
= {F1}
length (if p x then x : filter p xs else filter p xs) ≤ length (x:xs)
                                                      = {L1}
length (if p x then x : filter p xs else filter p xs) ≤ 1 + length xs
-- Por lema de generacion de booleanos separo en casos:
A) p x = True
B) p x = False

-- Caso A)
length (x : filter p xs) ≤ 1 + length xs
= {L1}
1 + length (filter p xs) ≤ 1 + length xs
= {Int}
length (filter p xs)     ≤ length xs
-- Se cumple el caso A) por {HI}

-- Caso B)
length (filter p xs) ≤ 1 + length xs
-- Por {HI} --> length (filter p xs) ≤ length xs ≤ 1 + length xs.
-- Por transitividad length (filter p xs) ≤ 1 + length xs.
-- Se cumple caso B).

-- Por A) y B) queda demostrado el paso inductivo.
-- Por lo tanto queda demostrado el lema.
```