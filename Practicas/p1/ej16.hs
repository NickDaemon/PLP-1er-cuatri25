data HashSet a = Hash (a -> Integer) (Integer -> [a])

-- I
vacio :: (a -> Integer) -> HashSet a
vacio f = Hash f (\_ -> [])

-- II
pertenece :: Eq a => a -> HashSet a -> Bool
pertenece e (Hash f g) = elem e (g (f e))

-- III
agregar :: Eq a => a -> HashSet a -> HashSet a
agregar x (Hash f g) = if pertenece x (Hash f g) then Hash f g else add f g x
  where
    add f g x = Hash f (\y -> if y == f x then x : g y else g y)

-- IV
interseccion :: Eq a => HashSet a -> HashSet a -> HashSet a
interseccion (Hash f g) (Hash h i) = Hash f (\x -> filter (`pertenece` (Hash h i)) (g x)) 

-- V
foldr11 :: (a -> a -> a) -> [a] -> a
foldr11 f []     = error "No lista vacía"
foldr11 f (x:xs) = foldr f x xs