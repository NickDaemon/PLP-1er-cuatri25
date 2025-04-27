## 8
```haskell
-- Definiciones
-- foldNat :: (Int -> b -> b) -> b -> Int -> b
{F0} foldNat f z 0 = z
{F1} foldNat f z n = f n (foldNat f z (n-1))

-- potencia :: Int -> Int -> Int
{P} potencia n = foldNat (\_ acc -> n*acc ) 1

∀ n, m :: Int. potencia n m = n^m

-- Usando induccion estructural en m quiero ver que valen:

1) Caso Base. P(0)
2) Caso Inductivo. ∀ m :: Int, m >= 0. P(m) => P(m+1)
Con P(m) = ∀ m, n :: Int, (n >= 0 && m >= 0) => potencia n m = n^m

-- Caso Base:
potencia n 0 = n^0
= {P}
foldNat (\_ acc -> n*acc) 1 0 = n^0
= {F0}
1 = n^0
= {Por Int} 
1 = 1 -- > Queda Demostrado el caso base.

-- Caso Inductivo:
{HI} : potencia n m = n^m

-- Qvq:
{TI} : potencia n (m+1) = n^(m+1)

-- Lado Izq:
potencia n (m+1)
= {P}
foldNat (\_ acc -> n*acc) 1 (m+1)
= {F1}
(\_ acc -> n*acc) (m+1) (foldNat (\_ acc -> n*acc) 1 m)
= {P}
(\_ acc -> n*acc) (m+1) (potencia n m)
= {HI}
(\_ acc -> n*acc) (m+1) n^m
= {B}
(\acc -> n*acc) n^m
= {B}
n*(n^m)

-- Lado Der:
n^(m+1)
= {Por int}
n^m*n
= {Por int}
n*(n^m)
-- > Queda demostrado el caso inductivo.
```