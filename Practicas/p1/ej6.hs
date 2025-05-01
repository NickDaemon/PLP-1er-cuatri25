recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

-- I
sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr sacar [] 
    where
        sacar x xs rec = if x == e then xs else x : rec

-- II
{-
    Si yo usara foldr para definir sacarUna , como foldr recorre exclusivamente toda 
    la lista, al no "detenerse" , sacaría todas las apariciones y no solo una.
    Haria:
    sacarUna 1 [1,2,1]
    foldr sacar [] [1,2,1]
    sacar 1 (foldr sacar [] [2,1])
    sacar 1 (sacar 2 (foldr sacar [] [1]))
    sacar 1 (sacar 2 (sacar 1 (foldr sacar [] [])))
    sacar 1 (sacar 2 (sacar 1 ([])))
    sacar 1 (sacar 2 (if 1 == 1 then [] else 1 : []))
    sacar 1 (sacar 2 [])
    sacar 1 (if 2 == 1 then [] else 2 : [])
    sacar 1 [2]
    if 1 == 1 then [2] else 1 : [2]
    [2] 

    Usando recr puedo "detenerme" con la primer aparición ya que "corta"
    la recursion y se queda con la cola de la lista hasta ese momento.
    No sigo acumulando en la rama rec.

    sacarUna 1 [1,2,1]
    sacar 1 [2,1] (sacar 2 [1] (sacar 1 [] []))
    xs = [2,1] && rec = (sacar 2 [1] (sacar 1 [] []))
    Entonces sacar 1 hace:
    if 1 == 1 then [2,1] else (sacar 2 [1] (sacar 1 [] []))
    [2,1]
    Como ya lo encontró "detiene" la recursión y devuelve la cola acumulada hasta 
    ese instante.

    sacarUna 2 [1,2,1]
    sacar 1 [2,1] (sacar 2 [1] (sacar 1 [] []))
    if 1 == 2 then [2,1] else 1 : (sacar 2 [1] (sacar 1 [] []))
    1 : (if 2 == 2 then [1] else 2 : (sacar 1 [] []))
    1 : [1]
    [1,1]
    En este caso detiene la recursión en el segundo paso, pero denuevo
    solo saca la primer aparición y no todas.

-}

-- III
insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr insertar []
  where
    insertar x xs rec = if null xs && e > x then [x,e]           
                        else if e <= x then e : x : xs else x : rec