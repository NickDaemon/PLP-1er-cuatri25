-- I
sumaMat :: [[Int]] -> [[Int]] -> [[Int]]
sumaMat xs ys = foldr step id xs ys
    where
        step xs rec ys = zipWith (+) xs (head ys) : rec (tail ys)

{-
    sumaMat [[1,2], [0,0]] [[1,1],[1,1]]
    foldr step id [[1,2], [0,0]] [[1,1],[1,1]]
    step [1,2] (foldr step (id) [[0,0]]) [[1,1],[1,1]]
    step [1,2] (step [[0,0]] (foldr step id [[]])) [[1,1],[1,1]]
    step [1,2] (step [[0,0]] id) [[1,1],[1,1]]
    zipWith (+) [1,2] [1,1] : (step [[0,0]] id [[1,1]])
    [2,3] : (step [0,0] id [[1,1]])
    [2,3] : (zipWith [0,0] [1,1] : id [[]])
    [2,3] : [1,1] : id [[]]
    [[2,3], [1,1]]
-}

-- II
trasponer :: [[Int]] -> [[Int]]
trasponer = foldr step [[]]
    where
        step xs rec = case rec of
            [[]] -> map (:[]) xs
            xs' -> zipWith (:) xs rec

{-
    trasponer [[1,2], [3,4]]
    foldr step [[]] [[1,2], [3,4]]
    step [1,2] (foldr step [[]] [[3,4]])
    step [1,2] (step [3,4] (foldr [[]] [[]]))
    step [1,2] (step [3,4] [[]])
    zipWith (:) [1,2] (step [3,4] [[]])
    zipWith (:) [1,2] (map (:[]) [3,4])
    zipWith (:) [1,2] ([[3],[4]])
-}
