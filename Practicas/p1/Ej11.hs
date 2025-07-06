data Polinomio a = X
                | Cte a
                | Suma (Polinomio a) (Polinomio a)
                | Prod (Polinomio a) (Polinomio a)

foldPolinomio :: b -> (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b
foldPolinomio x cte sum prod pol = case pol of
    X -> x
    Cte a -> cte a
    Suma p1 p2 -> sum (foldPolinomio x cte sum prod p1) (foldPolinomio x cte sum prod p2)
    Prod p1 p2 -> prod (foldPolinomio x cte sum prod p1) (foldPolinomio x cte sum prod p2)

evaluar :: Num a => a -> Polinomio a -> a
evaluar x  = foldPolinomio x id (+) (*) 