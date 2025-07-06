-- I:

permutaciones :: [a] -> [[a]]
permutaciones = foldr permutar []
    where
        permutar x rec = case rec of
            [] -> [[x]]
            rs -> concatMap (\xs -> [take i xs ++ [x] ++ drop i xs | i <- [0..length xs]]) rs

-- II:

partes :: [a] -> [[a]]
partes = foldr (\x rec -> map (x:) rec ++ rec) [[]]

-- III:

prefijos :: [a] -> [[a]]
prefijos = foldr prefix []
    where
        prefix x rec = case rec of
            [] -> [[], [x]]
            xs -> [] : map (x:) xs

-- IV:
subListas :: [a] -> [[a]]
subListas = foldr step [[]] 
    where 
        step x rec = rec ++ map (x:) (prefijos (last rec))