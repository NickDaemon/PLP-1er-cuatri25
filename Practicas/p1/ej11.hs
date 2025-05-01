data Polinomio a = X 
                   | Cte a 
                   | Suma (Polinomio a) (Polinomio a) 
                   | Prod (Polinomio a) (Polinomio a)

foldPol :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPol x cte suma prod pol = case pol of
    X -> x
    Cte a -> cte a
    Suma a b -> suma (foldPol x cte suma prod a) (foldPol x cte suma prod b)
    Prod a b -> prod (foldPol x cte suma prod a) (foldPol x cte suma prod b)

evaluar :: Num a => a -> Polinomio a -> a
evaluar e = foldPol e id (+) (*) 

polinomio :: Polinomio Int
polinomio = Suma (Prod X X) (Cte 5)
