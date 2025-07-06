-- I:

mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = foldr (\(x,y) rec -> f x y : rec) []

-- II:

armarPares :: [a] -> [b] -> [(a,b)]
armarPares xs ys = (foldr armar (const []) xs) ys
    where
        armar x rec ys = case ys of
            []      -> []
            (y:ys') -> (x,y) : rec ys'


{-  
    Cuando en el valor base del foldr devolvemos una función, convertimos la lista en una 
    función de primer orden que espera un argumento, y al aplicarla, se evaluará desde la 
    cabeza de la lista hacia la cola, descomponiendo el argumento pasado a medida que 
    recorre la lista.

    1 : (2 : []) [3,4,5]
    armar 1 (2 cons([])) [3,4,5]
      |   |      |          | 
      v   v      v          v
      f   x     rec         ys
    (1,3) : (armar 2 cons[]) [4,5]
               |   |   |       | 
               v   v   v       v
               f   x  rec     ys' 
               
    (1,3) : (2,4) : const [] [5]
    (1,3) : (2,4) : []
    [(1,3),(2,4)]

-}

-- III

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = foldr doble [] (armarPares xs ys)
    where
        doble (x,y) rec = f x y : rec