data ABNV a = Hoja a | Uni a (ABNV a) | Bi (ABNV a) a (ABNV a)

abnv = Bi (Uni 2 (Hoja 1)) 3 (Bi (Hoja 4) 5 (Uni 2 (Hoja 7)))

-- a)
foldABNV :: (a -> b) -> (a -> b -> b) -> (b -> a -> b -> b) -> ABNV a -> b
foldABNV fHoja fUni fBi t = case t of
    Hoja x -> fHoja x
    Uni x t -> fUni x (foldABNV fHoja fUni fBi t)
    Bi i x d -> fBi (rec i) x (rec d)
       where
        rec = foldABNV fHoja fUni fBi

recABNV :: (a -> b) -> 
           (a -> ABNV a -> b -> b) -> 
           (b -> ABNV a -> a -> b -> ABNV a -> b) -> 
           ABNV a -> b
recABNV fHoja fUni fBi t = case t of
    Hoja x -> fHoja x
    Uni x t -> fUni x t (recABNV fHoja fUni fBi t)
    Bi i x d -> fBi (rec i) i x (rec d) d
        where
            rec = recABNV fHoja fUni fBi 

-- b)
elemABNV :: Eq a => a -> ABNV a -> Bool
elemABNV e = foldABNV (\x -> x == e) (\x rec -> x == e || rec) (\i x d -> x == e || i || d)

-- c)
reemplazarUno :: Eq a => a -> a -> ABNV a -> ABNV a
reemplazarUno n m =
  recABNV
    (\x -> Hoja (if x == n then m else x))
    (\x t recT -> Uni (if x == n then m else x) recT)
    (\reci i x recd d -> if x == n then (Bi i m d) else (Bi reci x recd))

-- d)

nivel :: ABNV a -> Int -> [a]
nivel = foldABNV
  (\x i -> if i == 0 then [x] else [])                            
  (\x rec i -> if i == 0 then [x] else rec (i - 1))               
  (\reci x recd i -> if i == 0 then [x] else reci (i - 1) ++ recd (i - 1)) 
  




