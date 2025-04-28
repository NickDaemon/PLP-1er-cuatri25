-- Ejercicio 1:
-- 1.1
max2 (x,y) | x >= y = x
           | otherwise = y
{- Tipo: Ord a => (a, a) -> a -}


-- 1.2
normaVectorial (x, y) = sqrt (x^2 + y^2)
{- Tipo: (Float, Float) -> Float -}

-- 1.3
subtract1 = flip (-)
{- Tipo: Num a => a -> a -> a -}

-- 1.4
predecesor = subtract 1
{- Tipo: Num a => a -> a -}

-- 1.5
evaluarEnCero = \f -> f 0
{- Tipo: (Int -> a) -> a -}

-- 1.6
dosVeces = \f -> f . f
{- Tipo: (a -> a) -> a -> a -}

-- 1.7
flipAll = map flip
{- Tipo: [(a -> b -> c)] -> [(b -> a -> c)] -}

-- 1.8
flipRaro = flip flip
{- Tipo: b -> (a -> b -> c) -> a -> c
   ¿Por qué?
    - flip tiene tipo: (a -> b -> c) -> b -> a -> c
    - Si le paso como primer argumento otro flip, como las flechas asocian a derecha,
      infiere lo siguiente:
    - a' = (a -> b -> c), b' = b, c' = a -> c
    - Entonces flip :: (a' -> b' -> c') -> b' -> a' -> c'
    - Reemplazando a', b' y c' por sus definiciones:
    - flip :: ((a -> b -> c) -> b -> (a -> c)) -> b -> (a -> b -> c) -> (a -> c)
    - Por lo tanto:
    - flip flip :: b -> (a -> b -> c) -> (a -> c)
    - Denuevo como las flechas asocian a derecha, podemos omitir los ultimos parentesis.
    - flip flip :: b -> (a -> b -> c) -> a -> c
 -}

 -- II
 {- No estan currificadas las funciones 1.1 y 1.2 -}

-- 1.1 currificada:
max2Curry :: Ord a => a -> a -> a
max2Curry x y = if x >= y then x else y

-- 1.2 currificada:
normaVectorialCurry :: Float -> Float -> Float
normaVectorialCurry x y = sqrt (x^2 + y^2)

-- Ejercicio 2:
-- I
curryF :: (a -> b -> c) -> (a, b) -> c
curryF f = (\(a,b) -> f a b)

-- II
uncurryF :: ((a,b) -> c) -> a -> b -> c
uncurryF f = (\a b -> f (a,b))

-- II
{- 
  En Haskell no existe una tupla de tamaño arbitrario de forma genérica 
  (tipo (a, b, c, d, ..., n)) sin nombrarlo explícitamente.
  Por lo tanto considero que no seria posible un curryN.
-}