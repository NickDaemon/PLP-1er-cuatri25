-- Ejercicio 17
{-
    [ x | x <- [1..3], y <- [x..3], (x + y) `mod` 3 == 0 ]
    [1,3]
-}


-- Ejercicio 18
paresDeNat :: [(Int, Int)]
paresDeNat = [(x, s - x) | s <- [1..], x <- [0..s]]


-- Ejercicio 19

pitagoricas :: [(Integer, Integer, Integer)]
pitagoricas = [(a, b, c) | c <- [1..], a <- [1..c], b <- [1..a], a*a + b*b == c*c ]

{- 

- Se que a y b estan acotados por c ya que si a o b fueran mas grandes que c no 
  tendria sentido.
- Ademas haciendo que (b <= a) evito permutaciones redundantes como:
  (4,3,5) (3,4,5) --> (4*4 + 3*3 = 5*5) == (3*3 + 4*4 = 5*5)

-}