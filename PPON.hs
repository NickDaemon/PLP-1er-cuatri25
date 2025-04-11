module PPON where

import Documento

data PPON
  = TextoPP String
  | IntPP Int
  | ObjetoPP [(String, PPON)]
  deriving (Eq, Show)

pponAtomico :: PPON -> Bool
pponAtomico ppon = case ppon of
  ObjetoPP _ -> False
  _          -> True

pponObjetoSimple :: PPON -> Bool
pponObjetoSimple ppon = case ppon of
  ObjetoPP lista -> foldr (\(_,ppon') acc -> pponAtomico ppon' && acc) True lista
  _              -> False


intercalar :: Doc -> [Doc] -> Doc
intercalar s [] = vacio    -- > Como foldr1 no maneja el caso de la lista vacia , lo incluimos.
intercalar s d1 = foldr1 (\t acc -> t <+> s <+> acc) d1

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

aplanar :: Doc -> Doc
aplanar = foldDoc vacio fTexto fLinea 
  where
    fTexto t acc = texto t <+> acc
    fLinea s acc = texto " " <+> acc

pponADoc :: PPON -> Doc
pponADoc ppon = case ppon of
  TextoPP s      -> texto (show s)
  IntPP i        -> texto (show i)
  ObjetoPP lista -> if pponObjetoSimple (ObjetoPP lista) then fSimple lista else fRec lista
  where
    fSimple lista      = aplanar (entreLlaves (map parAdoc lista))
    fRec lista         = entreLlaves (map parAdoc lista)
    parAdoc (s, ppon') = texto (show s) <+> texto ": " <+> pponADoc ppon'

-- Es recursion estructural por que:
-- En los casos bases no recurrimos a funciones recursivas ya que no contienen subcomponentes de tipo PPON. 
-- La función simplemente combina los parámetros en un valor del tipo Doc.

-- En los casos recursivos la construccion del resultado solo se realiza utilizando los parámetros que no son de tipo PPON. 
-- (las claves s que se obtienen en cada par).
-- Y se invoca recursivamente pponADoc exclusivamente sobre cada parametro de tipo PPON.
-- Sin hacer otros llamados recursivos, y sin usar estos parametros.




    
