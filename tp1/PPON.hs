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
foldPPON :: (String -> b) -> (Int -> b) -> ([(String, b)] -> b) -> PPON -> b 
foldPPON fString fInt fLista ppon = case ppon of
  TextoPP s   -> fString s
  IntPP i     -> fInt i
  ObjetoPP xs -> fLista (map fPPON xs)
    where
      fPPON (s',ppon') = (s', foldPPON fString fInt fLista ppon')

pponADoc :: PPON -> Doc
pponADoc ppon = if pponObjetoSimple ppon then aplanar docs else docs
  where
    docs = foldPPON (texto . show) (texto . show) aDoc ppon
    aDoc xs = entreLlaves (map (\(s, d) -> texto (show s) <+> texto ": " <+> d) xs)
            
      
      
      


