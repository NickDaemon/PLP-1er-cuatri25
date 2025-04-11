module Main (main) where

import Documento
import PPON
import Test.HUnit

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests =
  test
    [ "Ejercicio 1" ~: testsEj1,
      "Ejercicio 2" ~: testsEj2,
      "Ejercicio 3" ~: testsEj3,
      "Ejercicio 4" ~: testsEj4,
      "Ejercicio 5" ~: testsEj5,
      "Ejercicio 6" ~: testsEj6,
      "Ejercicio 7" ~: testsEj7,
      "Ejercicio 8" ~: testsEj8,
      "Ejercicio 9" ~: testsEj9
    ]

texto1, texto2 :: Doc
texto1 = texto "ab" <+> linea <+> texto "cd"
texto2 = vacio

testsEj1 :: Test
testsEj1 =
  test
    [ foldDoc 0 (\_ acc -> 1 + acc) (\_ acc -> acc) texto1  ~?= 2,
      foldDoc 0 (\_ acc -> 1 + acc) (\_ acc -> acc) texto2 ~?= 0,
      foldDoc 0 (\_ acc -> acc) (\_ acc -> 1 + acc) texto1 ~?= 1,
      foldDoc 0 (\_ acc -> acc) (\_ acc -> 1 + acc) texto2 ~?= 0
    ]

testsEj2 :: Test
testsEj2 =
  test
    [ vacio <+> vacio ~?= vacio,
      texto "a" <+> texto "b" ~?= texto "ab",
      (texto "a" <+> linea) <+> texto "b" ~?= texto "a" <+> (linea <+> texto "b"),
      -- Test propios:
      texto "a" <+> vacio ~?= texto "a",
      vacio <+> texto "b" ~?= texto "b",
      texto "a" <+> vacio <+> linea <+> texto "b" ~?= texto "a" <+> (linea <+> texto "b")
    ]

testsEj3 :: Test
testsEj3 =
  test
    [ indentar 2 vacio ~?= vacio,
      indentar 2 (texto "a") ~?= texto "a",
      indentar 2 (texto "a" <+> linea <+> texto "b") ~?= texto "a" <+> indentar 2 (linea <+> texto "b"),
      indentar 2 (linea <+> texto "a") ~?= indentar 1 (indentar 1 (linea <+> texto "a")),
      -- Test propios:
      mostrar (indentar 2 (linea <+> texto "a")) ~?= "\n  a",
      mostrar (indentar 2 (texto "a" <+> vacio)) ~?= "a",
      mostrar (indentar 1 (texto "a" <+> indentar 1 linea <+> texto "b" <+> linea <+> texto "c")) ~?= "a\n  b\n c"
    ]

testsEj4 :: Test
testsEj4 =
  test
    [ mostrar vacio ~?= "",
      mostrar linea ~?= "\n",
      mostrar (indentar 2 (texto "a" <+> linea <+> texto "b")) ~?= "a\n  b",
      -- Test propios:
      mostrar (texto "a" <+> texto "b") ~?= "ab",
      mostrar (linea <+> texto "a" <+> indentar 2 linea <+> texto "b") ~?= "\na\n  b",
      mostrar (vacio <+> texto "a" <+> indentar 2 linea) ~?= "a\n  "
    ]

atomicoT, atomicoI :: PPON
atomicoT = TextoPP "Soy un ppon Atomico"
atomicoI = IntPP 5

testsEj5 :: Test
testsEj5 =
  test
    [ pponAtomico pericles ~?= False,
      pponAtomico atomicoT ~?= True,
      pponAtomico atomicoI ~?= True
    ]

pericles, merlina, addams, familias :: PPON
pericles = ObjetoPP [("nombre", TextoPP "Pericles"), ("edad", IntPP 30)]
merlina = ObjetoPP [("nombre", TextoPP "Merlina"), ("edad", IntPP 24)]
addams = ObjetoPP [("0", pericles), ("1", merlina)]
familias = ObjetoPP [("Addams", addams)]

testsEj6 :: Test
testsEj6 =
  test
    [ pponObjetoSimple pericles ~?= True,
      pponObjetoSimple addams ~?= False,
      -- Test propios:
      pponObjetoSimple atomicoT ~?= False,
      pponObjetoSimple familias ~?= False
    ]

a, b, c :: Doc
a = texto "a"
b = texto "b"
c = texto "c"

testsEj7 :: Test
testsEj7 =
  test
    [ mostrar (intercalar (texto ", ") []) ~?= "",
      mostrar (intercalar (texto ", ") [a, b, c]) ~?= "a, b, c",
      mostrar (entreLlaves []) ~?= "{ }",
      mostrar (entreLlaves [a, b, c]) ~?= "{\n  a,\n  b,\n  c\n}",
      -- Test propios
      mostrar (intercalar (texto ", ") [texto1, a]) ~?= "ab\ncd, a",
      mostrar (intercalar (texto ", ") [texto2, b]) ~?= ", b",
      mostrar (entreLlaves [texto1, a, texto2]) ~?= "{\n  ab\n  cd,\n  a,\n  \n}"
    ]

testsEj8 :: Test
testsEj8 =
  test
    [ mostrar (aplanar (a <+> linea <+> b <+> linea <+> c)) ~?= "a b c",
      -- Test propios
      mostrar (aplanar texto1) ~?= "ab cd",
      mostrar (aplanar (a <+> texto2 <+> texto1)) ~?= "aab cd",
      mostrar (aplanar (linea <+> a <+> linea)) ~?= " a "
    ]

testsEj9 :: Test
testsEj9 =
  test
    [ mostrar (pponADoc pericles) ~?= "{ \"nombre\": \"Pericles\", \"edad\": 30 }",
      mostrar (pponADoc addams) ~?= "{\n  \"0\": { \"nombre\": \"Pericles\", \"edad\": 30 },\n  \"1\": { \"nombre\": \"Merlina\", \"edad\": 24 }\n}",
      mostrar (pponADoc familias) ~?= "{\n  \"Addams\": {\n    \"0\": { \"nombre\": \"Pericles\", \"edad\": 30 },\n    \"1\": { \"nombre\": \"Merlina\", \"edad\": 24 }\n  }\n}",
      -- Test propios
      mostrar (pponADoc atomicoT) ~?= "\"Soy un ppon Atomico\"",
      mostrar (pponADoc atomicoI) ~?= "5"
    ]
