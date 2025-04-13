module Documento
  ( Doc,
    vacio,
    linea,
    texto,
    foldDoc,
    (<+>),
    indentar,
    mostrar,
    imprimir,
  )
where

data Doc
  = Vacio
  | Texto String Doc
  | Linea Int Doc
  deriving (Eq, Show)

vacio :: Doc
vacio = Vacio

linea :: Doc
linea = Linea 0 Vacio

texto :: String -> Doc
texto t | '\n' `elem` t = error "El texto no debe contener saltos de línea"
texto [] = Vacio
texto t = Texto t Vacio

-- Ejercicio 1:
foldDoc :: b -> (String -> b -> b) -> (Int -> b -> b) -> Doc -> b
foldDoc acc fTexto fLinea d = case d of
  Vacio      -> acc
  Texto s d2 -> fTexto s (rec d2)
  Linea i d2 -> fLinea i (rec d2)
  where
    rec = foldDoc acc fTexto fLinea 
   
-- Ejercicio 2:
infixr 6 <+>
(<+>) :: Doc -> Doc -> Doc
d1 <+> d2 = foldDoc d2 fTexto (\k acc -> Linea k acc) d1 -- > d2 actua como caso base ya que vamos a "concatenarle" los doc de d1.
  where
    fTexto s acc = case acc of
      Texto s' d -> Texto (s ++ s') d
      _          -> Texto s acc

-- En la función fTexto, cuando acc es un Texto s' d, sabemos que tanto s' como s son strings no vacios y sin saltos de linea.
-- Al concatenar s y s', el resultado sigue siendo un string no vacio y sin saltos de linea.
-- Por lo tanto, el nuevo Texto (s ++ s') d sigue respetando el invariante de Texto.

-- Ejercicio 3:
indentar :: Int -> Doc -> Doc
indentar i = foldDoc Vacio (\t acc -> Texto t acc) (\k acc -> Linea (i+k) acc) 

-- Sabiendo que tanto i como k seran numeros positivos , la suma (i+k) seguira siendo positiva.
-- Por lo tanto se sigue respetando el invariante de Linea. 

-- Ejercicio 4:
mostrar :: Doc -> String
mostrar = foldDoc "" fTexto fLinea 
  where
    fTexto s acc = s ++ acc
    fLinea i acc = "\n" ++ replicate i ' ' ++ acc

-- | Función dada que imprime un documento en pantalla

-- ghci> imprimir (Texto "abc" (Linea 2 (Texto "def" Vacio)))
-- abc
--   def

imprimir :: Doc -> IO ()
imprimir d = putStrLn (mostrar d)
