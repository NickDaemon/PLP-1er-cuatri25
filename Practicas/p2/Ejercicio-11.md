## 11
```haskell
-- Definiciones:

-- foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
{F0} foldAB f z Nil = z
{F1} foldAB f z (Bin izq dato der) = f (foldAB f z izq) dato (foldAB f z der)

-- inorder :: AB a -> [a]
{I0} inorder = foldAB [] (\ri x rd -> ri ++ (x:rd))

-- elemAB :: Eq a => a -> AB a -> Bool
{A0} elemAB e = foldAB (\ri x rd -> (e == x) || ri || rd) False 

-- elem :: Eq a => [a] -> Bool
{E0} elem e = foldr (\x rec -> (e == x) || rec) False

-- Usando extensionalidad funcional quiero ver que:
Eq a => ∀ e::a , ∀ t :: AB a. elemAB e t = elem e . inorder t

-- Usando induccion estructural en t quiero ver que vale:
1) Caso Base. P(Nil)
2) Caso Inductivo. ∀ i, d :: AB a, ∀ r :: a. ((P(i) && P(d)) => P(Bin i r d))
con P(t) = ∀ t :: AB a, ∀ e :: a. elemAB e t = elem e . inorder t

-- Caso Base:
elemAB e Nil = elem e . inorder Nil

-- Lado izq:
elemAB e Nil
= {A0}
foldAB False (\ri x rd -> (e == x) || ri || rd) Nil
= {F0}
False

-- Lado der:
elem e . inorder Nil
= {(.)}
elem e (inorder Nil)
= {I0}
elem e (foldAB [] (\ri x rd -> ri ++ (x:rd)) Nil)
= {F0}
elem e []
= {EF}
foldr (\x rec -> (e == x) || rec) False []
= {F0}
False
-- Queda demostrado el caso base.

-- Caso Inductivo:
{HI}: elemAB e t = elem e . inorder t

-- Qvq:
{TI}: elemAB e (Bin i r d) = elem e . inorder (Bin i r d)

-- Lado Izq:
elem e (Bin i r d)
= {A0}
foldAB (\ri x rd -> (e == x) || ri || rd) (Bin i r d) False
= {F1} -- > llamo f = (\ri x rd -> (e == x) || ri || rd)
f (foldAB f False i) r (foldAB f False d)
= {A0}
f (elemAB e i) r (elemAB e d)
= {HI}
f (elem e . inorder i) r (elem e . inorder d)
= {B} 3 veces
(e == r) || (elem e . inorder i) || (elem e . inorder d)

-- Lado Der:
elem e . inorder (Bin i r d)
= {(.)}
elem e (inorder (Bin i r d))
= {I0}
elem e (foldAB (\ri x rd -> ri ++ (x:rd)) [] (Bin i r d))
= {F1} -- > llamo g = (\ri x rd -> ri ++ (x:rd))
elem e (g (foldAB g [] i) r (foldAB g [] d))
= {I0}
elem e (g (inorder i) r (inorder d))
= {B} 3 veces
elem e ((inorder i) ++ (r:inorder d))
= {lema}
elem e (inorder i) || elem e (r:inorder d)
= {E0}
elem e (inorder i) || foldr (\x rec -> (e == x) || rec) False (r:inorder d)
= {F1} -- > llamo h = (\x rec -> (e == x) || rec)
elem e (inorder i) || h r (foldr h False inorder d)
= {EF}
elem e (inorder i) || (\x -> (rec -> (e == x) || rec)) r (elem e (inorder d))
= {B}
elem e (inorder i) || (\rec -> (e == r) || rec) (elem e (inorder d))
= {B}
elem e (inorder i) || (e == r) || elem e (inorder d)
= {Por Bool y (.)}
(e == r) || (elem e . inorder i) || (elem e . inorder d)

-- Como lado izq = lado der , queda demostrado el caso inductivo.


-- Pruebo lema
∀ xs, ys :: [a], e :: a. elem e (xs ++ ys) = elem e xs || elem e ys

-- Uso induccion en xs
Caso Base.
elem e ([] ++ ys) = elem e [] || elem e ys
= {++0}
elem e ys = elem [] || elem e ys
= {E0}
elem e ys = False || elem e ys
= {Por Bool}
elem e ys = elem e ys
-- Caso base demostrado

Caso Inductivo.
{HI}: elem e (xs ++ ys) = elem e xs || elem e ys

-- Qvq:
{TI}: elem e ((x:xs) ++ ys) = elem e (x:xs) || elem e ys

-- Lado izq:
elem e ((x:xs) ++ ys)
= {++1}
elem e (x : (xs ++ ys))
= {E0}
foldr (\x rec -> (e == x) || rec) False (x:(xs ++ ys))
= {Def Foldr}
(\x rec -> (e == x) || rec) x (foldr (\x rec -> (e == x) || rec) False (xs ++ ys))
= {EF}
(\x rec -> (e == x) || rec) x (elem e (xs ++ ys))
= {B} dos veces
(e == x) || elem e (xs ++ ys)
= {HI}
(e == x) || elem e xs || elem e ys 

-- Lado der:
elem e (x:xs) || elem e ys
= {EF}
(\x rec -> (e == x) || rec) x (foldr (\x rec -> (e == x) || rec) False xs) || elem e ys
= {EF}
(\x rec -> (e == x) || rec) x (elem e xs) || elem e ys
= {B} dos veces
(e == x) || elem e xs || elem e ys

-- Como lado izq = lado der, queda demostrado el lema.
```