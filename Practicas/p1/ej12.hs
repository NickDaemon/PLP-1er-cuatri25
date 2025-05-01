data AB a = Nil | Bin (AB a) a (AB a)

-- Arbol ejemplo
arbol :: AB Int
arbol = Bin (Bin (Nil) 3 (Bin (Nil) 4 (Nil))) 5 (Bin (Nil) 10 (Nil))

-- I

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB fNil _ Nil = fNil
foldAB fNil fBin (Bin i r d) = fBin (rec i) r (rec d)
    where
        rec = foldAB fNil fBin 

recAB :: b -> (b -> AB a -> a -> b -> AB a -> b) -> AB a -> b
recAB fNil _ Nil = fNil
recAB fNil fBin (Bin i r d) = fBin (rec i) (i) r (rec d) (d)
    where
        rec = recAB fNil fBin

-- II

esNil :: AB a -> Bool
esNil bin = case bin of
    Nil -> True
    _   -> False

altura :: AB a -> Int
altura = foldAB 0 (\ri r rd -> 1 + max ri rd)

cantNodos :: AB a -> Int
cantNodos = foldAB 0 (\ri r rd -> 1 + ri + rd)

-- III
mejorSegun :: (a -> a -> Bool) -> AB a -> a
mejorSegun _ Nil = error "No tiene sentido con Nil"
mejorSegun f (Bin izq r der) = foldAB r step (Bin izq r der)
    where
        step ri x rd = if f x (mejor f ri rd) then x else (mejor f ri rd)
        mejor f izq der = if f izq der then izq else der

-- IV
esABB :: Ord a => AB a -> Bool
esABB = recAB True step 
    where
        step ri i x rd d = esMayor x i && esMenor x d && ri && rd
        esMayor x i = case i of
            Nil -> True
            bin -> x >= mejorSegun (>) bin

        esMenor x d = case d of
            Nil -> True
            bin -> x < mejorSegun (<) bin


