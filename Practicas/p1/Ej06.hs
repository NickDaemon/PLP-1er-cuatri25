recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

-- a)
sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr (\x xs rec -> if e == x then xs else x : rec) []

-- b)
{-
    Para eliminar un elemento en la primera ocurrencia, necesitamos 
    devolver la cola de la lista a partir de ese punto, lo que requiere acceso a xs.
    Foldr al utilizar el esquema de recursión estructural no nos permite el acceso a
    xs por lo tanto recr es el esquema adecuado.
-}

-- c)

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr insertar []
  where
    insertar x xs rec = if null xs && e > x then [x,e]           
                        else if e <= x then e : x : xs else x : rec
