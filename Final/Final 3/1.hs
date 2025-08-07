data Form = Prop String
            | And Form Form 
            | Or Form Form 
            | Neg Form

foldForm :: (String -> b) -> (b -> b -> b) -> (b -> b -> b) -> (b -> b) -> Form -> b
foldForm prop and or neg frm = case frm of
    Prop letra -> prop letra
    And f1 f2 -> and (foldForm prop and or neg f1) (foldForm prop and or neg f2)
    Or f1 f2 -> or (foldForm prop and or neg f1) (foldForm prop and or neg f2)
    Neg f -> neg (foldForm prop and or neg f)

fnn :: Form -> Bool -> Form
fnn = \f clave -> foldForm
         (\p -> if clave then Prop p else Neg (Prop p))
         (\f1 f2 -> if clave then And f1 f2 else Or f1 f2)
         (\f1 f2 -> if clave then Or f1 f2 else And f1 f2)
         (\f -> fnn f (not clave))
         f
