curryF :: (a -> b -> c) -> (a, b) -> c
curryF f = (\(a,b) -> f a b)

uncurryF :: ((a, b) -> c) -> a -> b -> c
uncurryF f = (\a b -> f (a, b))

-- II
{- 
  En Haskell no existe una tupla de tamaño arbitrario de forma genérica 
  (tipo (a, b, c, d, ..., n)) sin nombrarlo explícitamente.
  Por lo tanto considero que no seria posible un curryN.
-}