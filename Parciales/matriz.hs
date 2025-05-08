data Matriz a = NuevaMatriz a | Agregar a Int Int (Matriz a)
-- Ejemplos:
m1 = Agregar 5 1 2 $ Agregar 2 2 1 $ Agregar 3 1 1 $ NuevaMatriz 0

m3 = Agregar 0 1 2 $ Agregar 4 0 0 $ Agregar 2 1 1 $ NuevaMatriz 1

-- a)
foldMatriz :: (a -> b) -> (a -> Int -> Int -> b -> b) -> Matriz a -> b
foldMatriz fNueva fAgregar m = case m of
    NuevaMatriz a -> fNueva a
    Agregar a x y m' -> fAgregar a x y (foldMatriz fNueva fAgregar m')

-- b)
ver :: Int -> Int -> Matriz a -> a
ver x y = foldMatriz id view
    where
        view v x' y' rec = if (x' == x && y' == y) then v else rec

{- ver 1 1 m2 = foldMatriz id view
   view 'a' 1 2 (fold id view tail)
   view 'a' 1 2 (view 'b' 1 2 (fold id view tail))
   view 'a' 1 2 (view 'b' 1 2 (view 'c' 1 1 (view id 'd')))
   (view 'b' 1 2 (view 'c' 1 1 (view id 'd')))
   (view 'c' 1 1 (view id 'd')))
   'c'
-}

-- c)
mapMatriz :: (a -> b) -> Matriz a -> Matriz b
mapMatriz fMatriz = foldMatriz fBase fAdd
  where
    fBase v = NuevaMatriz (fMatriz v)
    fAdd v x y rec = Agregar (fMatriz v) x y rec


suma :: Num a => Matriz a -> Matriz a -> Matriz a
suma xs ys = foldMatriz fNew fRec xs
  where
    -- en el "caso base", sumo el valor por defecto de xs (v)
    -- con el valor por defecto de ys (v')
    fNew v = mapMatriz (\v' -> v + v') ys

    -- en cada Agregar de xs, sumo su valor v con el de ys en (x,y)
    fRec v x y rec = Agregar (v + ver x y ys) x y rec

{-
    Mi idea es:
    - Usando foldMatriz en m1 , voy a obtener todos los valores que esten
      en esa matriz.
    - Usando (ver x y m3) sumo el valor que tenga la segunda matriz en esa posición.
    - Esto me asegura que se sumen correctamente todos los valores presentes en m1.
    - PERO si devolviera esta matriz perdería los valores que estén en coordenadas
      distinas en m3.
    - Por ejemplo 0 0 no esta en m1 pero si en m3, entonces la nueva matriz ignoraría
      el valor en 0 0 por que no esta en m1 y pondria el valor por defecto.
    - Para evitar esto "fusiono" la matriz recorrida con foldMatriz con m3 modificada.
    - Usando mapMatriz devuelvo m3 sumando todos sus valores con el valor por defecto
      de m1.
    - Esta matriz va a tener todos los valores que no estaban en m1 sumados correctamente
      con su valor por defecto.
    - Y como solo cuenta el ultimo valor agregado, ignorara las repeticiones pero devolvera
      correctamente los valores que no estaban en m1.
    - Y como es la matriz base tendra el correcto valor por defecto que es la suma de m1 y m3.
-}

-- Ejercicio d)
matrizDeSumas :: Matriz Int
matrizDeSumas = foldr (\(v, x, y) m -> Agregar v x y m) (NuevaMatriz 0) lista
  where
    lista = [(s, x, s - x) | s <- [1..], x <- [0..s]]
