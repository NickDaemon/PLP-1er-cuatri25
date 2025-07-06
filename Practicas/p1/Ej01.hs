-- I : Tipos

-- max2 :: Ord a => (a, a) -> a
max2 (x, y) | x >= y = x
            | otherwise = y

-- normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

-- subtract :: Num a => a -> a -> a
subtract = flip (-)

-- predecesor :: Num a => a -> a
predecesor = subtract 1

-- evaluarEnCero :: (Int -> a) -> a
evaluarEnCero = \f -> f 0

-- dosVeces :: (a -> a) -> a -> a
dosVeces = \f -> f . f

-- flipAll :: [(a -> b -> c)] -> [(b -> a -> c)]
flipAll = map flip

-- flipRaro :: 
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
    - Por lo tanto al pasar flip como argumento:
    - flip flip :: b -> (a -> b -> c) -> (a -> c)
    - Denuevo como las flechas asocian a derecha, podemos omitir los ultimos parentesis.
    - flip flip :: b -> (a -> b -> c) -> a -> c
 -}

-- II: Curry

{- No estan currificadas las funciones 1.1 y 1.2 -}

-- 1.1 currificada:
max2Curry :: Ord a => a -> a -> a
max2Curry x y = if x >= y then x else y

-- 1.2 currificada:
normaVectorialCurry :: Float -> Float -> Float
normaVectorialCurry x y = sqrt (x^2 + y^2)