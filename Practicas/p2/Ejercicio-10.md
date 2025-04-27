## 10.1
```haskell
-- Definiciones:
-- foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
{F0} foldAB f z Nil = z
{F1} foldAB f z (Bin izq dato der) = f (foldAB f z izq) dato (foldAB f z der)

-- altura :: AB a -> Int
{A} altura x = foldAB (\izq _ der -> 1 + max izq der) 0 x
-- Lemas
{L1} ∀ x::Int . ∀ y::Int . ∀ z::Int . max (min x y) (min x z) = min x (max y z)
{L2} ∀ x::Int . ∀ y::Int . ∀ z::Int . z + min x y = min (z+x) (z+y)

-- Quiero probar que:
∀ t::AB a . altura t ≥ 0

-- Usando induccion estructural en t, quiero ver que valen:

1) Caso Base. P(Nil)
2) Caso Inductivo. ∀ i, d :: AB a. ∀ r :: a. ((P(i) && P(d)) => P(Bin i r d))
Con P(t) = ∀ t :: AB a => altura t ≥ 0

-- Caso Base:
altura Nil ≥ 0
= {A}
foldAB (\izq _ der -> 1 + max izq der) 0 Nil ≥ 0
= {F0}
0 ≥ 0
-- Queda demostrado el caso base.

-- Caso Inductivo:
{HI} : altura t ≥ 0

-- Qvq:
{TI} : altura (Bin i r d) ≥ 0

altura (Bin i r d)
= {A}
foldAB (\izq _ der -> 1 + max izq der) 0 (Bin i r d)
= {F1} -- > llamo f = (\izq _ der -> 1 + max izq der)
f (foldAB f 0 i) r (foldAB f 0 d)
= {A}
f (altura i) r (altura d)
= {DEF f}
(\izq _ der -> 1 + max izq der) (altura i) r (altura d)
= {B}
(\_ der -> 1 + max (altura i) der) r (altura d)
= {B}
(\der -> 1 + max (altura i) der) (altura d)
= {B}
1 + max (altura i) (altura d)

-- Por {HI} altura i ≥ 0 && altura d ≥ 0
-- Por propiedad de int -> 1 + max altura i altura d ≥ 0 
-- Ya que altura i y altura d son positivos.

-- Queda demostrado el Caso inductivo.
```
## 10.2
```haskell
-- Definiciones:
-- truncar :: AB a -> Int -> AB a
{T0} truncar Nil \_ = Nil
{T1} truncar (Bin i r d) n = 
                if n == 0 then Nil else Bin (truncar i (n-1)) r (truncar d (n-1))

-- Lemas:
{L1} : ∀ x::Int . ∀ y::Int . ∀ z::Int . max (min x y) (min x z) = min x (max y z)
{L2} : ∀ x::Int . ∀ y::Int . ∀ z::Int . z + min x y = min (z+x) (z+y)

-- Quiero ver que:
∀ t::AB a . ∀ n::Int . (n ≥ 0 => (altura (truncar t n) = min n (altura t)))

-- Si n ≥ 0 fuera False , la implicacion vale para cualquier Q.
-- Por lo tanto voy analizar cuando n ≥ 0 = True
-- En ese caso quiero probar que:
altura (truncar t n) = min n (altura t)

-- Por induccion estructural en t , basta ver que valen:

1) Caso Base. P(Nil)
2) Caso Inductivo. ∀ i, d :: AB a, ∀ r :: a. ((P(i) && P(d)) => P(Bin i r d))
Con P(t) = (altura (truncar t n) = min n (altura t))

-- Caso Base:
-- Llamo f = (\izq _ der -> 1 + max izq der) 
altura (truncar Nil n) = min n (altura Nil)
= {T0}
altura Nil = min n (altura Nil)
= {A}
foldAB f 0 Nil = min n (foldAB f 0 Nil)
= {F0}
0 = min n 0
-- Como n ≥ 0 -> min n 0 = 0
-- Por lo tanto queda demostrado el caso base.

-- Caso Inductivo:
{HI}: altura (truncar t n) = min n (altura t)

-- Qvq:
{TI}: altura (truncar (Bin i r d) n) = min n (altura (Bin i r d))

-- Lado izq:
altura (truncar (Bin i r d) n)
= {T1}
altura (if n == 0 then Nil else Bin (truncar i (n-1)) r (truncar d (n-1)))
= {Por lema de generacion de bool separo en casos}
Caso A. n == 0
Caso B. n != 0

-- Caso A
altura Nil = min 0 (altura (Bin i r d))
= {A0}
0 = min 0 (altura (Bin i r d))
= {Por lema 10.1}
0 = 0
-- Queda probado Caso A.

-- Caso B
-- Llamo f = (\izq _ der -> 1 + max izq der)

-- Lado izq:
altura (Bin (truncar i (n-1)) r (truncar d (n-1)))
= {A1} 
foldAB f 0 (Bin (truncar i (n-1)) r (truncar d (n-1)))
f (foldAB f 0 (truncar i (n-1)) r (truncar d (n-1)))
= {A}
f (altura (truncar i (n-1))) r (altura (truncar d (n-1)))
= {HI}
f (min (n-1) (altura i)) r (min (n-1) (altura d))
= {B} 3 veces 
1 + max (min (n-1) (altura i)) (min (n-1) (altura d))
= {L1}
1 + min (n-1) (max (altura i) (altura d))
= {L2}
min (1 + (n-1)) (1 + max (altura i) (altura d))
= {Por Int}
min n (1 + max (altura i) (altura d))

-- Lado der:
min n (altura (Bin i r d))
= {A1}
min n (foldAB f 0 (Bin i r d))
= {F1}
min n (f (foldAB f 0 i) r (foldAB f 0 d))
= {A1}
min n (f (altura i) r (altura d))
= {B} 3 veces
min n (1 + max (altura i) (altura d))

-- Como lado izq = lado der, Queda demostrado el caso Inductivo.
```