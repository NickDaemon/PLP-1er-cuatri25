-- Ejercicio 9
-- I:

foldNat :: (Integer -> b -> b) -> Integer -> b -> b
foldNat f 0 z = z
foldNat f n z = f n (foldNat f (n-1) z)

-- II:
potencia :: Integer -> Integer -> Integer
potencia n m = foldNat potenciar m 1 
    where
        potenciar m rec = rec * n

-- Ejercicio 10:
-- I:
genLista :: a -> (a -> a) -> Integer -> [a]
genLista x f n = foldNat generar n [x]
    where
        generar _ rec = rec ++ [f (last rec)]

-- II:
desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta desde hasta = genLista desde (+1) (hasta - desde)