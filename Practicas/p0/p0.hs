-- Ejercicio 1

-- null :: [a] -> bool
-- head :: [a] -> a
-- tail :: [a] -> [a]
-- init :: [a] -> [a]
-- last :: [a] -> a
-- take :: Int -> [a] -> [a]
-- drop :: Int -> [a] -> [a]
-- (++) :: [a] -> [a] -> [a]
-- concat :: [[a]] -> [a]
-- reverse :: [a] -> [a]
-- elem :: a -> [a] -> bool
------------------------------------------------------------------------------------------------
-- Ejercicio 2

valorAbsoluto :: Float -> Float
valorAbsoluto n = sqrt (n*n)

valorAbsoluto2 :: Float -> Float
valorAbsoluto2 n 
  | n >= 0    = n
  | otherwise = -n


bisiesto :: Int -> Bool
bisiesto n = mod n 4 == 0 && (mod n 100 /= 0 || mod n 400 == 0)


factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)


cant_divisores_primos :: Int -> Int
cant_divisores_primos n = primos n n

primos :: Int -> Int -> Int
primos n m 
    | m == 1 = 0
    | mod n m == 0 && esPrimo m m = 1 + primos n (m-1)
    | otherwise = primos n (m - 1)

esPrimo :: Int -> Int -> Bool
esPrimo m p 
    | p == 1 = True
    | m /= p && mod m p == 0 = False
    | otherwise = esPrimo m (p - 1)

------------------------------------------------------------------------------------------------
-- Ejercicio 3
inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso n = Just (1/n)

aEntero :: Either Int Bool -> Int
aEntero ab = case ab of
    Left a -> a
    Right True -> 0
    Right False -> 1

------------------------------------------------------------------------------------------------
-- Ejercicio 4

limpiar :: String -> String -> String
limpiar xs [] = []
limpiar xs (y:ys) = if elem y xs then limpiar xs ys else y : limpiar xs ys

promedio :: [Float] -> Float
promedio [] = 0
promedio n = sum n / fromIntegral (length n)

dif_promedio :: [Float] -> [Float]
dif_promedio n = map (\x -> x - promedio n) n

todos_iguales :: [Int] -> Bool
todos_iguales [] = True
todos_iguales [x] = True
todos_iguales (x:y:xs) = x == y && todos_iguales(y:xs) 

------------------------------------------------------------------------------------------------
-- Ejercicio 5
data AB a = Nil | Bin (AB a) a (AB a)

vacio :: AB a -> Bool
vacio Nil = True
vacio _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin izq dato der) = Bin (negacionAB izq) (not dato) (negacionAB der)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin izq dato der) = dato * productoAB izq * productoAB der









