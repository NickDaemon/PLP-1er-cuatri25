foldu :: b -> (a -> b -> b) -> [(b -> a)] -> b
foldu z f [] = z
foldu z f (x:xs) = f (x (foldu z f xs)) (foldu z f xs)

foldru :: (a -> b -> b) -> b -> [a] -> b
foldru f z xs = foldu z f (map const xs)

foldur :: b -> (a -> b -> b) -> [(b -> a)] -> b
foldur z f xs = foldr f z (map (\fx -> fx z) xs)