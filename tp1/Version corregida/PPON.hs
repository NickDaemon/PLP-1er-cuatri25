module PPON where

import Documento

data PPON
  = TextoPP String
  | IntPP Int
  | ObjetoPP [(String, PPON)]
  deriving (Eq, Show)

-- Ejercicio 5
pponAtomico :: PPON -> Bool
pponAtomico ppon = case ppon of
  ObjetoPP _ -> False
  _          -> True

-- Ejercicio 6
pponObjetoSimple :: PPON -> Bool
pponObjetoSimple (ObjetoPP lista) = all (pponAtomico . snd) lista
pponObjetoSimple _                = False


-- Ejercicio 7
intercalar :: Doc -> [Doc] -> Doc
intercalar _ [] = vacio    -- > Como foldr1 no maneja el caso de la lista vacia , lo incluimos.
intercalar s ds = foldr1 (\t acc -> t <+> s <+> acc) ds

entreLlaves :: [Doc] -> Doc
entreLlaves [] = texto "{ }"
entreLlaves ds =
  texto "{"
    <+> indentar
      2
      ( linea
          <+> intercalar (texto "," <+> linea) ds
      )
    <+> linea
    <+> texto "}"

-- Ejercicio 8
aplanar :: Doc -> Doc
aplanar = foldDoc vacio fTexto fLinea 
  where
    fTexto s acc = texto s <+> acc
    fLinea _ acc = texto " " <+> acc

-- Ejercicio 9

pponAdoc :: PPON -> Doc
pponAdoc ppon = case ppon of
  TextoPP s      -> texto (show s)
  IntPP i        -> texto (show i)
  ObjetoPP lista -> if pponObjetoSimple ppon then aplanar docs else docs
    where
      docs = entreLlaves (foldr parAdoc [] lista)
      parAdoc (s, ppon') rec = (texto (show s) <+> texto ": " <+> pponAdoc ppon') : rec

