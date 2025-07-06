{-
Ejercicio 17:

[ x | x <- [1..3], y <- [x..3], (x + y) `mod' 3 == 0 ]

Evalúa a: [1,3]

-}

-- Ejercicio 18:

paresDeNat :: [(Int, Int)]
paresDeNat = [(x, s - x) | s <- [1..], x <- [0..s]]


-- Ejercicio 19:

{-

pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a, b, c) | a <- [1..], b <-[1..], c <- [1..], a^2 + b^2 == c^2]

De esta manera solo creo las triplas (1,1,x) y no es lo que buscamos.
Rompe con la regla 1 y 2 de generación infinita.

-}

pitagoricas :: [(Integer, Integer, Integer)]
pitagoricas = [ (a, b, c) | c <- [1..], a <- [1..c], b <- [1..a], a*a + b*b == c*c]



