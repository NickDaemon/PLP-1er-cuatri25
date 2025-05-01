-- I
elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs
                                    then [x]
                                    else x : elementosEnPosicionesPares (tail xs)

{-

La recursión de elementosEnPosicionesPares es global, ya que accede a un
resultado anterior: el de la recursión sobre la cola de la cola de la lista (es decir
tail xs).

-}

-- II
entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys
                    then x : entrelazar xs []
                    else x : head ys : entrelazar xs (tail ys)

{-

Es recursión estructural en ambas listas, porque cada llamada avanza de modo “natural” 
por la estructura de cada una (tomando su cabeza y recurriendo sobre su cola).

-}

-- Con foldr seria:
entrelazarF :: [a] -> [a] -> [a]
entrelazarF xs ys = foldr step id xs ys
    where
        step x rec ys = case ys of
            [] -> x : rec []
            (y:ys') -> x : y : rec ys'

