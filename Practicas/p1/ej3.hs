-- I
sumF :: Num a => [a] -> a
sumF = foldr (+) 0

elemF :: Eq a => a -> [a] -> Bool
elemF e = foldr (\x z -> x == e || z) False

concatF :: [a] -> [a] -> [a]
concatF xs ys = foldr (:) ys xs

filterF :: (a -> Bool) -> [a] -> [a]
filterF p = foldr (\x rec -> if p x then x : rec else rec) []

mapF :: (a -> b) -> [a] -> [b]
mapF f = foldr ((\x rec -> f x : rec)) []

-- II
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec)

-- III
sumasParciales :: Num a => [a] -> [a]
sumasParciales xs = foldr step [] (reverse xs) 
    where
        step x rec = case rec of
            [] -> [x]
            xs -> rec ++ [last rec + x] 

sumasParcialesF :: Num a => [a] -> [a]
sumasParcialesF = foldl step []
    where
        step rec x = case rec of
            [] -> [x]
            xs -> rec ++ [last rec + x]
-- IV
sumAlt :: Num a => [a] -> a
sumAlt = foldr (-) 0

-- V
sumAlt2 :: Num a => [a] -> a
sumAlt2 = foldl (flip (-)) 0