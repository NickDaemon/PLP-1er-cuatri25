-- I
permutaciones :: [a] -> [[a]]
permutaciones = foldr step []
    where
        step x rec = case rec of
            [] -> [[x]]
            xs -> concatMap (permutar x) xs
        permutar x rec = [take i rec ++ [x] ++ drop i rec | i <- [0..(length rec)]]

-- II
partes :: [a] -> [[a]]
partes = foldr (\x rec -> rec ++ (map (x:) rec)) [[]] 

-- III
prefijos :: [a] -> [[a]]
prefijos = foldr (\x rec -> [] : (map (x:) rec)
{-
    f 5 (f 1 [[],[2]])
    f 5 ([] : map (1:) [[], [2]])
    f 5 [[], [1], [1,2]]
    [] : map (5:) [[], [1], [1,2]]
    [[], [5], [5,1], [5,1,2]]
-}

-- IV
subListas :: [a] -> [[a]]
subListas = foldr step [[]] 
    where 
        step x rec = rec ++ map (x:) (prefijos (last rec))

{-
    subListas [5,1,2]  
    step 5 (step 1 (step 2 ([[]])))
    step 5 (step 1 ([[]] ++ map (2:) (prefijos [])))
    step 5 (step 1 ([[]] ++ map (2:) [[]])))
    step 5 (step 1 ([[], [2]]))
    step 5 ([[], [2]] ++ map (1:) (prefijos [2]))
    step 5 ([[], [2]] ++ map (1:) [[], [2]])
    step 5 ([[], [2], [1], [1,2]])
    [[], [2], [1], [1,2]] ++ map (5:) (prefijos [1,2])
    [[], [2], [1], [1,2]] ++ map (5:) [[], [1], [1,2]]
    [[], [2], [1], [1,2]] ++ [[5], [5,1], [5,1,2]]
    [[], [2], [1], [1,2], [5], [5,1], [5,1,2]]

-}

