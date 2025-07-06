-- I
elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs
                                    then [x]
                                    else x : elementosEnPosicionesPares (tail xs)

{-

No es estructural por que accede a la subestructura xs en 'if null xs' antes del llamado recursivo.
No es primitiva por que accede a resultados de recursiones anteriores cuando hace 'tail xs'.
Por lo tanto se puede considerar recursion global.
Si el llamado fuera sobre xs y no sobre tail xs se podria considerar primitiva.

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
entrelazarF = foldr step id 
    where
        step x rec ys = case ys of
            [] -> x : rec []
            (y:ys') -> x : y : rec ys'