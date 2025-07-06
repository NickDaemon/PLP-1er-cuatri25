data RoseTree a = Rose a [RoseTree a]

-- Ejemplo
r :: RoseTree Int
r = Rose 1 [ Rose 2 []
           , Rose 3 [Rose 4 [], Rose 5 []]
           , Rose 6 []
           ]

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose fRose (Rose a rs) = fRose a (map (foldRose fRose) rs)

hojas :: RoseTree a -> [a]
hojas = foldRose unir
    where
        unir x rec = case rec of
            [] -> [x]
            xs -> concat xs

distancias :: RoseTree a -> [Int]
distancias = foldRose distancia
    where
        distancia x rec = case rec of
            [] -> [0]
            xs -> map (+1) (concat xs)

altura :: RoseTree a -> Int
altura = foldRose alto
    where
        alto x rec = case rec of
            [] -> 1
            xs -> 1 + maximum xs


