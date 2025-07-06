-- I:

sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat  = foldr sumar (const [])
    where
        sumar x rec (y:ys') = zipWith (+) x y : rec ys' 

-- II:

trasponer :: [[Int]] -> [[Int]]
trasponer = foldr trasponerAux []
    where
        trasponerAux x rec = case rec of
            [] -> map (:[]) x 
            ys -> zipWith (:) x ys 