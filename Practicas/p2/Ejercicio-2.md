## 2.1

```haskell
flip . flip = id

-- Usando extensionalidad funcional quiero ver que:
∀ f :: (a -> b -> c)
flip . flip f = id f 

-- Definiciones:
-- {F} : flip f  = (\x y -> f y x)
-- {(.)} : f . g x = f (g x)

-- Lado izq:
flip . flip f 
= {(.)}
flip (flip f) 
= {F}
flip (\x y -> f y x)
= {F}
(\x y -> (\a b -> f b a) y x)
= {B} dos veces
(\x y -> f x y)


--Lado der:
id f 
= {ID}
f  
= {DEf f}
(\x y -> f x y)  -- > Como lado izq = lado der queda demostrado.
```

## 2.2
```haskell
∀ f :: (a, b) -> c .uncurry (curry f) = f

-- Por extensionalidad funcional quiero ver que:
∀ x :: a, y :: b
uncurry (curry f) x y = f x y
= {U}
curry f (x y) = f x y
= {C}
f x y = f x y  -- > Queda demostrado.
```

## 2.3
```haskell
flip const = const id

-- Por extensionalidad funcional quiero ver que:
∀ x :: a, y :: b

flip const x y = const id x y

Lado izq:
flip const x y
= {F}
const y x
= {DEF const}
y

Lado der:
const id x y
= {DEF const}
id y
= {ID}
y   -- > Como lado izq = lado der, queda demostrado.
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
