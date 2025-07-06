data AIH a = Hoja a | Bin (AIH a) (AIH a)

-- a)

foldAIH :: (a -> b) -> (b -> b -> b) -> AIH a -> b
foldAIH fHoja fBin ab = case ab of
    Hoja a -> fHoja a
    Bin izq der -> fBin (foldAIH fHoja fBin izq) (foldAIH fHoja fBin der)

-- b)

altura :: AIH a -> Integer
altura = foldAIH (const 1) alto
    where
        alto ri rd = 1 + max ri rd

tamaño :: AIH a -> Integer
tamaño = foldAIH (const 1) tamañoAB
    where
        tamañoAB ri rd = ri + rd

       