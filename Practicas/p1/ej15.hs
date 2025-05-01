data RoseTree a = Rose a [RoseTree a]

-- Arbol Ejemplo
arbol :: RoseTree Int
arbol = Rose 1 [Rose 2 [], Rose 3 [Rose 5 []], Rose 4 []]

-- I

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose fBin (Rose a xs) = fBin a (map (foldRose fBin) xs) 

-- II

hojas :: RoseTree a -> [a]
hojas = foldRose step
    where
        step a [] = [a]
        step a rec = concat rec

-- III

distancias :: RoseTree a -> [Int]
distancias = foldRose step
    where
        step _ [] = [0]
        step _ rec = map (+1) (concat rec)

-- IV

altura :: RoseTree a -> Int
altura = foldRose step
    where
        step _ [] = 1
        step _ rec = 1 + maximum rec
