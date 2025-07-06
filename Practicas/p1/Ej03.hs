-- I:

sumF :: [Int] -> Int
sumF = foldr (+) 0

elemF :: Eq a => a -> [a] -> Bool
elemF e = foldr (\x rec -> e == x || rec) False 

concatF :: [a] -> [a] -> [a]
concatF xs ys = foldr (:) ys xs

filterF :: Eq a => (a -> Bool) -> [a] -> [a]
filterF p = foldr (\x rec -> if p x then x : rec else rec) []

mapF :: (a -> b) -> [a] -> [b]
mapF f = foldr ((:) . f) []

-- II:

mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun f = foldr1 (\x rec -> if f x rec then x else rec) 

-- III:

sumasParciales :: Num a => [a] -> [a]
sumasParciales xs = foldr step [] (reverse xs) 
    where
        step x rec = case rec of
            [] -> [x]
            xs -> rec ++ [last rec + x] 

sumasParcialesL :: Num a => [a] -> [a]
sumasParcialesL = foldl step []
    where
        step acc x = case acc of
            [] -> [x]
            xs -> acc ++ [last acc + x]

-- IV:

sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

-- V:

sumaAlt2 :: Num a => [a] -> a
sumaAlt2 xs = foldr (-) 0 (reverse xs)
