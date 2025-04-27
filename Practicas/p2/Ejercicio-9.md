## 9
```haskell
∀ x :: AB a . altura x ≤ cantNodos x

-- Definiciones:

data AB a = Nil | Bin (AB a) a (AB a)
-- foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
{F0} foldAB f z Nil = z
{F1} foldAB f z (Bin izq dato der) = f (foldAB f z izq) dato (foldAB f z der)

-- altura :: AB a -> Int
{A} altura x = foldAB (\izq _ der -> 1 + max izq der) 0 x

-- cantNodos :: AB a -> Int 
{C} cantNodos x = foldAB (\izq _ der -> 1 + izq + der) 0 x

-- Usando induccion estructural en x quiero ver que valen:

1) Caso Base. P(Nil)
2) Caso Inductivo. ∀ i, d :: AB a. ((P(i) && P(d)) => P(Bin i d))

Con P(x) = altura x ≤ cantNodos x

-- Caso Base:
-- Lado izq:
altura Nil 
= {A}
foldAB (\izq _ der -> 1 + max izq der) 0 Nil
= {F0}
0

-- Lado Der:
cantNodos Nil
= {C}
foldAB (\izq _ der -> 1 + izq + der) 0 Nil
= {F0}
0

-- Como Lado izq ≤ Lado der , queda demostrado caso base.

-- Caso Inductivo:
{HI} : altura x ≤ cantNodos x

-- Qvq:
altura (Bin i r d) ≤ cantNodos (Bin i r d)

-- Lado izq:
altura (Bin i r d)
= {A}
foldAB (\izq _ der -> 1 + izq + der) 0 (Bin i r d)
= {F1} -- > llamo f = (\izq _ der -> 1 + max izq der)
f (foldAB f 0 i) r (foldAB f 0 d)
= {A}
f (altura i) r (altura d)
= {Def f}
(\izq _ der -> 1 + max izq der) (altura i) r (altura d)
= {B}
(\_ der -> 1 + max (altura i) der) r (altura d)
= {B}
(\der -> 1 + max (altura i) der) (altura d)
= {B}
1 + max (altura i) (altura d)

-- Lado Der:
cantNodos (Bin i r d)
= {C}
foldAB (\izq _ der -> 1 + izq + der) 0 (Bin i r d)
= {F1} -- > llamo g = (\izq _ der -> 1 + izq + der)
g (foldAB g 0 i) r (foldAB g 0 d)
= {C}
g (cantNodos i) r (cantNodos d)
= {Def g}
(\izq _ der -> 1 + izq + der) (cantNodos i) r (cantNodos d)
= {B}
(\_ der -> 1 + (cantNodos i) + der) r (cantNodos d)
= {B}
(\der -> 1 + (cantNodos i) + der) (cantNodos d)
= {B}
1 + (cantNodos i) + (cantNodos d)

-- Por {HI} altura x ≤ cantNodos x.
-- Por lo tanto 1 + max (altura i) (altura d) ≤ 1 + max (cantNodos i) (cantNodos d).
-- y por propiedad de int: 
-- 1 + max (cantNodos i) (cantNodos d) ≤ 1 + (cantNodos i) + (cantNodos d).
-- Entonces por transitividad Lado izq ≤ Lado der.
-- Queda demostrado el caso inductivo.



```