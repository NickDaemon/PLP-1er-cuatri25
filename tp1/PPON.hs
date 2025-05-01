module PPON where

import Documento

data PPON
  = TextoPP String
  | IntPP Int
  | ObjetoPP [(String, PPON)]
  deriving (Eq, Show)

-- Ejercicio 5
pponAtomico :: PPON -> Bool
pponAtomico = foldPPON (const True) (const True) (const False)

-- Ejercicio 6
pponObjetoSimple :: PPON -> Bool
pponObjetoSimple ppon = case ppon of
  ObjetoPP xs -> all (pponAtomico . snd) xs
  _           -> False

-- Ejercicio 7
intercalar :: Doc -> [Doc] -> Doc
intercalar s [] = vacio    -- > Como foldr1 no maneja el caso de la lista vacia , lo incluimos.
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
    fTexto t acc = texto t <+> acc
    fLinea s acc = texto " " <+> acc

-- Ejercicio 9

            
      
      
      


