data AIH a = Hoja a | Bin (AIH a) (AIH a)

-- Ejemplo Arbol
arbol :: AIH Integer
arbol = Bin (Bin (Hoja 4) (Bin (Hoja 5) (Hoja 6))) (Hoja 3)

-- I

foldAIH :: (a -> b) -> (b -> b -> b) -> AIH a -> b
foldAIH fHoja fBin ab = case ab of
    Hoja a -> fHoja a
    Bin izq der -> fBin (rec izq) (rec der)
    where
        rec = foldAIH fHoja fBin

-- II

altura :: AIH a -> Integer
altura = foldAIH (const 1) step
    where
        step ri rd = 1 + max ri rd

-- III

tamaño :: AIH a -> Integer
tamaño = foldAIH (const 1) step
    where
        step ri rd = ri + rd