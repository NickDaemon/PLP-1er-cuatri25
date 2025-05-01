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


-- Ejercicio 13:

-- I
ramas :: AB a -> [[a]]
ramas = foldAB [] step
    where
        step [] x [] = [[x]]
        step ri x rd = map (x:) (ri ++ rd)

-- II
cantHojas :: AB a -> Int
cantHojas = recAB 0 step
    where
        step _ Nil _ _ Nil = 1
        step ri _ _ rd _ = ri + rd

-- III
espejo :: AB a -> AB a
espejo = foldAB Nil step
    where
        step ri x rd = Bin rd x ri

-- IV
mismaEstructura :: AB a -> AB a -> Bool
mismaEstructura = foldAB base step 
  where
    base t = case t of
      Nil       -> True
      Bin _ _ _ -> False

    step recIzq _ recDer t = case t of
      Nil       -> False
      Bin i _ d -> recIzq i && recDer d

{-

    mismaEstructura (Bin Nil 5 Nil) (Bin (Bin Nil 4 Nil) 4 Nil)
    foldAB base step (Bin Nil 5 Nil) (Bin (Bin Nil 4 Nil) 4 Nil)
    step (foldAB base step Nil) 5 (foldAB base step Nil) (Bin (Bin Nil 4 Nil) 4 Nil)
    step (base) 5 (base) (Bin (Bin Nil 4 Nil) 4 Nil)
    base (Bin Nil 4 Nil) && base Nil
    False && True
    False

-}
