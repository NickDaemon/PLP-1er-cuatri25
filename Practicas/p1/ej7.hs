-- I
mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = foldr (\(x,y) rec -> f x y : rec) []

-- II
armarPares :: [a] -> [b] -> [(a,b)]
armarPares xs ys = foldr step (const []) xs ys
    where
        step x rec ys = case ys of
            []      -> []
            (y:ys') -> (x,y) : rec ys'
            
{-
    armarPares [1,3] [2,4,5]
    foldr step (const []) [1,3] [2,4,5]
    step 1 (foldr step (const []) [3]) [2,4,5]
    step 1 (step 3 (foldr step (const []) [])) [2,4,5]
    step 1 (step 3 (const [])) [2,4,5]
    (1,2) : (step 3 (const []) [4,5])
    (1,2) : ((3,4) : (const []) [5])
    (1,2) : (3,4) : []
    [(1,2),(3,4)]
-}

-- III
mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = foldr step [] (armarPares xs ys)
    where
        step (x,y) rec = f x y : rec