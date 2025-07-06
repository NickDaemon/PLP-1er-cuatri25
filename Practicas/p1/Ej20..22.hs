-- Ejercicio 20:

listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = [ (x:xs) | x <- [1..n], xs <- listasQueSuman (n-x)]

{-
   La recursión no es estructural por que listasQueSuman (n-x) accede a los
   resultados de recursiones anteriores, por lo tanto es global.
-}

-- Ejercicio 21:

listasEnteros :: [[Int]]
listasEnteros = [xs | n <- [1..], xs <- listasQueSuman n]


-- Ejercicio 22:

data AIH a = Hoja a | Bin (AIH a) (AIH a)

aihInfinitos :: [AIH ()]
aihInfinitos = concat [ arboles n | n <- [1..]]

arboles :: Int -> [AIH ()]
arboles 1 = [Hoja ()]
arboles n = [ Bin izq der | len <- [1..n-1], izq <- arboles len , der <- arboles (n - len) ]

{-
   Si el arbol izquierdo tiene tamaño len, entonces el derecho tiene que tener tamaño
   n - len, por que ambas ramas deben sumar n.
-}
