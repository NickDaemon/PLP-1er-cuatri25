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
foldDoc fVacio _ _ Vacio                 = fVacio
foldDoc fVacio fTexto fLinea (Texto s x) = fTexto s (foldDoc fVacio fTexto fLinea x)
foldDoc fVacio fTexto fLinea (Linea i x) = fLinea i (foldDoc fVacio fTexto fLinea x)

   
-- Ejercicio 2:
infixr 6 <+>
(<+>) :: Doc -> Doc -> Doc
d1 <+> d2 = foldDoc d2 fTexto Linea d1 
  where
    fTexto s rec = case rec of
      Texto s' d' -> Texto (s ++ s') d'
      _           -> Texto s rec

-- Asumimos que d1 y d2 cumplen el invariante.
-- Llamamos d' a cada subestructura de d1.
-- Si d1 cumple el invariante, entonces cada d' también lo cumplirá.
-- Hay 3 casos posibles para d1: Vacio, (Texto s' d') o (Linea i d').

--- Caso 1: d1 = Vacio. ---
{-
Por definición de foldDoc, la función devuelve d2.
Como d2 cumple el invariante, este se mantiene.
-}

--- Caso 2: d1 = Texto s d' ---
{-
Como d1 cumple el invariante, s es un string no vacío y sin saltos de línea.
En este caso, la función <+> procesará fTexto s rec.
rec es el resultado de aplicar foldDoc sobre las subestructuras de d1.
Como cada subestructura de d1 cumple el invariante, rec también lo deberá cumplir.

Tenemos 2 subcasos posibles:

Subcaso A) rec = Texto s' d''.
La función procesa Texto (s ++ s') d'.
Como s y s' cumplen el invariante, la concatenación también lo hará.
Además, sabemos que d' también lo cumple.
Por lo tanto, el Doc resultante Texto (s ++ s') d' mantiene el invariante.

Subcaso B) rec = Vacio ó rec = Linea i d''.
La función procesa, en ambos casos, Texto s' rec.
Como s' cumple el invariante, el Doc resultante también lo cumplirá.
-}

--- Caso 3: d1 = Linea i d' ---
{-
Como d1 cumple el invariante, sabemos que i >= 0.
En este caso, la función simplemente procesa Linea i rec.
Análogamente al caso anterior, el invariante se mantiene.
-}

-- Ejercicio 3:
indentar :: Int -> Doc -> Doc
indentar i = foldDoc Vacio Texto (\k rec -> Linea (k+i) rec) 

{-
indentar i d1 = foldDoc Vacio Texto (\k rec -> Linea (k+i) rec) d1

Asumimos que d1 cumple el invariante, y por precondición del problema
sabemos que i >= 0.

Si d1 cumple el invariante, entonces cada una de sus subestructuras también lo cumple.

La función recorre las subestructuras de d1 usando foldDoc, y crea un nuevo Doc
a partir de ellas, modificando únicamente aquellas que sean del tipo Linea k d''.

Como Linea k d'' pertenece a d1, sabemos que k >= 0 y que d'' es un Doc que respeta
el invariante.

Al construir Linea (k+i) rec, como i >= 0 y k >= 0, su suma también es un número no negativo,
por propiedades de los enteros.

De esta forma, el nuevo Doc resultante mantiene el invariante.
-}

-- Ejercicio 4:
mostrar :: Doc -> String
mostrar = foldDoc "" fTexto fLinea 
  where
    fTexto s rec = s ++ rec
    fLinea i rec = "\n" ++ replicate i ' ' ++ rec

-- | Función dada que imprime un documento en pantalla

-- ghci> imprimir (Texto "abc" (Linea 2 (Texto "def" Vacio)))
-- abc
--   def

imprimir :: Doc -> IO ()
imprimir d = putStrLn (mostrar d)
