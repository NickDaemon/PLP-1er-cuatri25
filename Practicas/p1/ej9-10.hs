-- Ejercicio 9
-- I
foldNat :: (Integer -> b -> b) -> Integer -> b -> b
foldNat f 0 z = z
foldNat f n z = f n (foldNat f (n-1) z) 

-- II
potencia :: Integer -> Integer -> Integer
potencia n m = foldNat step m 1
    where
        step _ rec = n*rec

{-
    potencia 2 3
    foldNat step 3 1
    step 3 (foldNat step (3-1) 1)
    step 3 (step 2 (foldNat (2-1) 1))
    step 3 (step 2 (step 1 (foldNat step 0 1)))
    step 3 (step 2 (step 1 (1)))
    2 * (step 2 (step 1 1))
    2 * (2 * (step 1 1))
    2 * (2 * (2 * 1))
    8
-}

-- Ejercicio 10
-- I
genLista :: a -> (a -> a) -> Integer -> [a]
genLista x f n = foldNat step n []
    where 
        step n' rec = case rec of
            [] -> x : []
            xs -> xs ++ [f (last xs)]

{-
    genLista 1 (*2) 3   --> f = (*2)
    foldNat step 3 []
    step 3 (foldNat step 2 [])
    step 3 (step 2 (foldNat step 1 []))
    step 3 (step 2 (step 1 (foldNat step 0 [])))
    step 3 (step 2 (step 1 []))
    step 3 (step 2 (1 : []))
    step 3 ([1] ++ f last [1])
    step 3 ([1, 2])
    [1,2] ++ [f 2]
    [1,2] ++ [4]
    [1,2,4]
-}

-- II
desdeHasta :: Integer -> Integer -> [Integer]
desdeHasta desde hasta = genLista desde (+1) (hasta - desde + 1)