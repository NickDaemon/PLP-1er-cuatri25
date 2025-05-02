## 2.1

```haskell
flip . flip = id

-- Usando extensionalidad funcional quiero ver que:
∀ f :: (a -> b -> c)
flip . flip f = id f 

-- Definiciones:
{f}: f = \x y -> f x y
{F}: flip f  = \a b -> f b a
{(.)}: f . g x = f (g x)
{B}: (\x -> Y) Z = Y --> reemplazando a x por Z

-- Usando principio de reemplazo , demuestro la igualdad por definicion.

-- Lado izq:
flip . flip f 
= {(.)}
flip (flip f) 
= {F}
flip (\a b -> f b a)
= {F}
(\c d -> (\a b -> f b a) d c)
= {sintaxis de haskell}
(\c d -> (\a -> (\b -> f b a) d c))
= {B}
(\c d -> (\b -> f b d) c)
= {B}
(\c d -> f c d)
= {f}
f

--Lado der:
id f 
= {ID}
f  
-- Como Lado izq = Lado der , queda demostrado que flip . flip f = id f
```

## 2.2
```haskell
∀ f :: (a, b) -> c .uncurry (curry f) = f

-- Definiciones:
{f} f = \(x,y) -> f (x,y)
{C} curry f = \a b -> f (a,b)
{U} uncurry f = \(c,d) -> f c d
{B}: (\x -> Y) Z = Y  --> reemplazando a x por Z

-- Por extensionalidad funcional quiero ver que:
∀ p :: (a,b)
uncurry (curry f) p = f p

-- Por lema de generacion de pares
∃ x :: a && ∃ y :: b tal que p = (x,y)

-- Entonces quiero ver que:
uncurry (curry f) (x,y) = f (x,y)

-- Lado izq:
uncurry (curry f) (x,y)
= {C}
uncurry (\a b -> f (a,b)) (x,y)
= {U}
(\(c,d) -> (\a b -> f (a,b)) c d) (x,y)
= {sintaxis de haskell}
(\(c,d) -> (\a -> (\b -> f (a,b))) c d) (x,y)
= {B}
(\(c,d) -> (\b -> f (c,b)) d) (x,y)
= {B}
(\(c,d) -> f (c,d)) (x,y)
= {B}
f (x,y)
-- Como lado izq = lado der , queda demostrado que uncurry (curry f) (x,y) = f (x,y).
```

## 2.3
```haskell
flip const = const id

-- Por extensionalidad funcional quiero ver que:
∀ x :: a . flip const x = const id x

-- Definiciones:
{F}: flip f = (\a b -> f b a)
{C}: const x = (\y -> x)
{ID}: id = (\a -> a)
{B}: (\x -> Y) Z = Y --> reemplazando a x por Z

-- Por principio de reemplazo , veo que la igualdad vale por definicion.

-- Lado izq:
flip const x
= {F}
(\a b -> const b a) x
= {sintaxis de haskell}
(\a -> (\b -> const b a)) x
= {B}
(\b -> const b x)
= {C}
(\b -> (\y -> b) x)
= {B}
\b -> b
= {ID}
id

-- Lado der:
const id x
= {C}
(\y -> id) x
= {B}
id

-- Como lado izq = lado der, queda demostrado que flip const x = const id x
```
## 2.4
```haskell
∀ f :: a -> b , g :: b -> c, h :: c -> d 
((h . g) . f) = (h . (g . f))

-- Por extensionalidad funcional quiero ver que:
∀ x :: a
((h . g) . f) x = (h . (g . f)) x

Lado izq:
((h . g) . f) x 
= {(.)}
(h . g) (f x)
= {(.)}
h (g (f x))

Lado der:
(h . (g . f)) x
= {(.)}
h ((g . f) x)
= {(.)}
h (g (f x)) -- > Como lado izq = lado der , queda demostrado.
