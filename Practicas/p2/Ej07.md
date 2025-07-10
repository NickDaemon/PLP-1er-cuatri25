## 7.1
```haskell
∀ f :: a-> b-> b . ∀ z :: b . ∀ xs, ys :: [a] . 
foldr f z (xs ++ ys) = foldr f (foldr f z ys) xs

-- Definiciones:
-- foldr
{F0} foldr f z [] = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)

-- (++)
{++0} [] ++ ys     = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

-- Usando induccion estructural en xs quiero ver que:

1) Caso Base. P([]).
2) Caso Inductivo. ∀ f :: a-> b-> b . ∀ z :: b . ∀ xs, ys :: [a] , ∀ x :: a.
                   P(xs) => P(x:xs)

Con P(xs) = ∀ f :: a -> b -> b, ∀ z :: b, ∀ ys :: [a] =>
            foldr f z (xs ++ ys) = foldr f (foldr f z ys) xs

-- Caso Base:
foldr f z ([] ++ ys) = foldr f (foldr f z ys) []
= {++0}
foldr f z ys = foldr f (foldr f z ys) []
= {F0}
foldr f z ys = foldr f z ys
-- > Queda demostrado el caso base

-- Caso Inductivo:
{HI} : foldr f z (xs ++ ys) = foldr f (foldr f z ys) xs

-- Qvq:
{TI} : foldr f z ((x:xs) ++ ys) = foldr f (foldr f z ys) (x:xs)

-- Lado Izq:
foldr f z ((x:xs) ++ ys)
= {++1}
foldr f z (x : (xs ++ ys))
= {F1}
f x (foldr f z (xs ++ ys))
= {HI}
f x (foldr f (foldr f z ys) xs)

-- Lado der:
foldr f (foldr f z ys) (x:xs)
= {F1}
f x (foldr f (foldr f z ys) xs)

-- Como lado izq = lado der, se demuestra el caso inductivo.


```

## 7.2

```haskell
∀ f :: b -> a -> b . ∀ z :: b . ∀ xs, ys :: [a] . 
foldl f z (xs ++ ys) = foldl f (foldl f z xs) ys

-- Definiciones:
-- foldr
{F0} foldr f z [] = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)

-- foldl
{Fl0} foldl f z [] = z
{Fl1} foldl f z (x:xs) = foldl f (f z x) xs

-- (++)
{++0} [] ++ ys     = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

-- Usando induccion estructural en xs quiero ver que valen:

1) Caso Base. P([])
2) Caso Inductivo. ∀ f :: b -> a -> b . ∀ z :: b . ∀ xs, ys :: [a] , x :: a
                   P(xs) => P(x:xs)

Con P(xs) = ∀ f :: b -> a -> b . ∀ z :: b . ∀ ys :: [a]. =>
            foldl f z (xs ++ ys) = foldl f (foldl f z xs) ys

-- Caso Base:
foldl f z ([] ++ ys) = foldl f (foldl f z []) ys
= {++0}
foldl f z ys = foldl f (foldl f z []) ys
= {Fl0}
foldl f z ys = foldl f z ys
-- Queda demostrado el caso base.

-- Caso Inductivo:
{HI} : foldl f z (xs ++ ys) = foldl f (foldl f z xs) ys

-- Qvq:
{TI} : foldl f z ((x:xs) ++ ys) = foldl f (foldl f z (x:xs)) ys

-- Lado Izq:
foldl f z ((x:xs) ++ ys)
= {++1}
foldl f z (x : (xs ++ ys))
= {Fl1}
foldl f (f z x) (xs ++ ys)
= {HI}
foldl f (foldl f (f z x) xs) ys

-- Lado Der:
foldl f (foldl f z (x:xs)) ys
= {Fl1}
foldl f (foldl f (f z x) xs) ys

-- Como lado izq = lado der , Queda demostrado el Caso Inductivo.
```