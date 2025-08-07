existeRefutacionSLD :: [Clausulas] -> Objetivo -> Bool
existeRefutacionSLD [] _ = False
existeRefutacionSLD (x:xs) ob = if hayVacia (x:xs) ob then True else
                                existeRefutacionSLD (x:xs) (resolvente ob x)

hayVacia :: [Clausulas] -> Objetivo -> Bool
hayVacia xs ob = foldr step False xs 
    where
        step cl rec = esVacia (resolvente ob cl) || rec