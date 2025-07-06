data AB a = Nil | Bin (AB a) a (AB a)

-- Arbol ejemplo
arbol :: AB Int
arbol = Bin (Bin (Nil) 3 (Bin (Nil) 4 (Nil))) 5 (Bin (Nil) 10 (Nil))

-- Ejercicio 12:
-- I:

foldAB :: b -> (b -> a -> b -> b) -> AB a -> b
foldAB cNil fBin Nil = cNil
foldAB cNil fBin (Bin izq dato der) = fBin (rec izq) dato (rec der)
    where
        rec = foldAB cNil fBin 

recAB :: b -> (b -> AB a -> a -> b -> AB a -> b) -> AB a -> b
recAB cNil fBin Nil = cNil
recAB cNil fBin (Bin izq dato der) =  fBin (rec izq) izq dato (rec der) der
    where
        rec = recAB cNil fBin

-- II:

esNil :: AB a -> Bool
esNil ab = case ab of
    Nil -> True
    _   -> False

altura :: AB a -> Int
altura = foldAB 0 alto
    where
        alto recIzq _ recDer = 1 + max recIzq recDer

cantNodos :: AB a -> Int
cantNodos = foldAB 0 nodos
    where
        nodos recIzq _ recDer = 1 + recIzq + recDer

-- III:

mejorSegunAB :: (a -> a -> Bool) -> AB a -> a
mejorSegunAB f Nil = error "Nil no tiene mejor"
mejorSegunAB f (Bin i dato d) = foldAB dato mejor (Bin i dato d)
    where
        mejor ri dato rd = if f dato (esMejor ri rd) then dato else (esMejor ri rd)
        esMejor ri rd = if f ri rd then ri else rd 

-- IV:

esABB :: Ord a => AB a -> Bool
esABB = recAB True esABBaux
    where
        esABBaux ri izq dato rd der = ri && rd && (esMayor dato izq) && (esMenor dato der)
        esMayor dato ab = case ab of
            Nil -> True
            izq -> dato > mejorSegunAB (>) izq
        esMenor dato ab = case ab of
            Nil -> True
            der -> dato <= mejorSegunAB (<) der 

-- Ejercicio 13:
-- I:

ramas :: AB a -> [[a]]
ramas = foldAB [] rama
    where
        rama [] dato [] = [[dato]]
        rama ri dato rd = map (dato:) (ri ++ rd)

cantHojas :: AB a -> Int
cantHojas = recAB 0 hojas
    where
        hojas _ Nil _ _ Nil = 1
        hojas ri _ _ rd _ = ri + rd 

espejo :: AB a -> AB a 
espejo = foldAB Nil espejar
    where
        espejar ri dato rd = Bin rd dato ri

-- II:

mismaEstructura :: AB a -> AB b -> Bool
mismaEstructura ab bb = (foldAB base estructura ab) bb
    where
        base tree = case tree of
            Nil -> True
            _   -> False
        estructura ri _ rd tree = case tree of
            Nil -> False
            Bin izq _ der -> ri izq && rd der 
