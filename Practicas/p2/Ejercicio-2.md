## 2.1

```haskell
flip . flip = id

-- Usando extensionalidad funcional quiero ver que:
∀ f :: (a -> b -> c), x :: a, y :: b
flip . flip f x y = id f x y

-- Definiciones:
{F} : flip f x y = f y x
{(.)} : f . g x = f (g x)

Lado izq:
flip . flip f x y
= {(.)}
flip (flip f) x y
= {F}
flip f y x
= {F}
f x y

Lado der:
id f x y
= {ID}
f x y    -- > Como lado izq = lado der queda demostrado.
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
