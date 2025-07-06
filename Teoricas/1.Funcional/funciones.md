## foldr, foldl, foldr1, foldl1
| Función | Qué hace                                                   | Ejemplo                    | Tipo                             |
| ------- | ---------------------------------------------------------- | -------------------------- | -------------------------------- |
| foldr   | Reduce una lista de der a izq con función y valor inicial  | `foldr (+) 0 [1,2,3] == 6` | `(a -> b -> b) -> b -> [a] -> b` |
| foldl   | Reduce una lista de izq a der con función y valor inicial  | `foldl (+) 0 [1,2,3] == 6` | `(b -> a -> b) -> b -> [a] -> b` |
| foldr1  | Igual que foldr pero usa el último elem como valor inicial | `foldr1 (+) [1,2,3] == 6`  | `(a -> a -> a) -> [a] -> a`      |
| foldl1  | Igual que foldl pero usa el primer elem como valor inicial | `foldl1 (+) [1,2,3] == 6`  | `(a -> a -> a) -> [a] -> a`      |

## map, zipWith
| Función | Qué hace                                   | Ejemplo                                | Tipo                                 |
| ------- | ------------------------------------------ | -------------------------------------- | ------------------------------------ |
| map     | Aplica una función a cada elem de la lista | `map (+1) [1,2,3] == [2,3,4]`          | `(a -> b) -> [a] -> [b]`             |
| zipWith | Aplica función a pares de dos listas       | `zipWith (+) [1,2] [10,20] == [11,22]` | `(a -> b -> c) -> [a] -> [b] -> [c]` |

## all, any, null
| Función | Qué hace                               | Ejemplo                    | Tipo                         |
| ------- | -------------------------------------- | -------------------------- | ---------------------------- |
| all     | Verifica si todos cumplen el predicado | `all even [2,4,6] == True` | `(a -> Bool) -> [a] -> Bool` |
| any     | Verifica si alguno cumple el predicado | `any odd [2,4,5] == True`  | `(a -> Bool) -> [a] -> Bool` |
| null    | Verifica si la lista está vacía        | `null [] == True`          | `[a] -> Bool`                |


## nub, sort, sortBy
| Función | Qué hace                | Ejemplo                                                              | Tipo                                 |
| ------- | ----------------------- | -------------------------------------------------------------------- | ------------------------------------ |
| nub     | Elimina duplicados      | `nub [1,2,2,3] == [1,2,3]`                                           | `Eq a => [a] -> [a]`                 |
| sort    | Ordena de menor a mayor | `sort [3,1,2] == [1,2,3]`                                            | `Ord a => [a] -> [a]`                |
| sortBy  | Ordena con comparador   | `sortBy (comparing length) ["hi","hello","a"] == ["a","hi","hello"]` | `(a -> a -> Ordering) -> [a] -> [a]` |


## mod, div, odd, even
| Función | Qué hace             | Ejemplo          | Tipo                        |
| ------- | -------------------- | ---------------- | --------------------------- |
| mod     | Resto de división    | `mod 5 2 == 1`   | `Integral a => a -> a -> a` |
| div     | División entera      | `div 5 2 == 2`   | `Integral a => a -> a -> a` |
| odd     | Verifica si es impar | `odd 3 == True`  | `Integral a => a -> Bool`   |
| even    | Verifica si es par   | `even 4 == True` | `Integral a => a -> Bool`   |

## (++) , head, tail, init, last, length
| Función | Qué hace                           | Ejemplo                   | Tipo                |
| ------- | ---------------------------------- | ------------------------- | ------------------- |
| (++)    | Concatena listas                   | `[1,2] ++ [3] == [1,2,3]` | `[a] -> [a] -> [a]` |
| head    | Devuelve primer elemento           | `head [1,2,3] == 1`       | `[a] -> a`          |
| tail    | Devuelve lista sin primer elemento | `tail [1,2,3] == [2,3]`   | `[a] -> [a]`        |
| init    | Lista sin último elemento          | `init [1,2,3] == [1,2]`   | `[a] -> [a]`        |
| last    | Último elemento                    | `last [1,2,3] == 3`       | `[a] -> a`          |
| length  | Cantidad de elementos              | `length [1,2,3] == 3`     | `[a] -> Int`        |

## replicate, repeat, iterate
| Función   | Qué hace                         | Ejemplo                                | Tipo                   |
| --------- | -------------------------------- | -------------------------------------- | ---------------------- |
| replicate | Lista con n copias               | `replicate 3 'a' == "aaa"`             | `Int -> a -> [a]`      |
| repeat    | Lista infinita de elemento       | `take 3 (repeat 'a') == "aaa"`         | `a -> [a]`             |
| iterate   | Lista infinita aplicando función | `take 4 (iterate (+1) 0) == [0,1,2,3]` | `(a -> a) -> a -> [a]` |

## filter, take, drop
| Función | Qué hace                   | Ejemplo                      | Tipo                        |
| ------- | -------------------------- | ---------------------------- | --------------------------- |
| filter  | Filtra según predicado     | `filter even [1,2,3] == [2]` | `(a -> Bool) -> [a] -> [a]` |
| take    | Toma primeros n elementos  | `take 2 [1,2,3] == [1,2]`    | `Int -> [a] -> [a]`         |
| drop    | Quita primeros n elementos | `drop 2 [1,2,3] == [3]`      | `Int -> [a] -> [a]`         |

##  elem, find, isNothing, isJust, fromJust, maybe, lookup
| Función   | Qué hace                           | Ejemplo                                  | Tipo                              |
| --------- | ---------------------------------- | ---------------------------------------- | --------------------------------- |
| elem      | Verifica pertenencia               | `elem 3 [1,2,3] == True`                 | `Eq a => a -> [a] -> Bool`        |
| find      | Devuelve el primer que cumple      | `find even [1,3,4] == Just 4`            | `(a -> Bool) -> [a] -> Maybe a`   |
| isNothing | Verifica si es `Nothing`           | `isNothing Nothing == True`              | `Maybe a -> Bool`                 |
| isJust    | Verifica si es `Just`              | `isJust (Just 3) == True`                | `Maybe a -> Bool`                 |
| fromJust  | Extrae valor de `Just`             | `fromJust (Just 3) == 3`                 | `Maybe a -> a`                    |
| maybe     | Desempaqueta con valor por defecto | `maybe 0 (+1) (Just 3) == 4`             | `b -> (a -> b) -> Maybe a -> b`   |
| lookup    | Busca clave en lista de pares      | `lookup 2 [(1,'a'),(2,'b')] == Just 'b'` | `Eq a => a -> [(a,b)] -> Maybe b` |

## reverse, concat, union, intersect
| Función   | Qué hace                       | Ejemplo                              | Tipo                        |
| --------- | ------------------------------ | ------------------------------------ | --------------------------- |
| reverse   | Invierte la lista              | `reverse [1,2,3] == [3,2,1]`         | `[a] -> [a]`                |
| concat    | Junta listas de listas         | `concat [[1],[2,3]] == [1,2,3]`      | `[[a]] -> [a]`              |
| union     | Unión de listas sin duplicados | `union [1,2] [2,3] == [1,2,3]`       | `Eq a => [a] -> [a] -> [a]` |
| intersect | Intersección de listas         | `intersect [1,2,3] [2,3,4] == [2,3]` | `Eq a => [a] -> [a] -> [a]` |

##  and, or, sum
| Función | Qué hace                 | Ejemplo                   | Tipo                |
| ------- | ------------------------ | ------------------------- | ------------------- |
| and     | True si todos True       | `and [True,True] == True` | `[Bool] -> Bool`    |
| or      | True si alguno True      | `or [False,True] == True` | `[Bool] -> Bool`    |
| sum     | Suma todos los elementos | `sum [1,2,3] == 6`        | `Num a => [a] -> a` |

## max, maximum, maximumBy, min, minimum, minimumBy
| Función   | Qué hace                | Ejemplo                                                  | Tipo                               |
| --------- | ----------------------- | -------------------------------------------------------- | ---------------------------------- |
| max       | Máximo de dos valores   | `max 3 5 == 5`                                           | `Ord a => a -> a -> a`             |
| maximum   | Máximo de lista         | `maximum [1,5,3] == 5`                                   | `Ord a => [a] -> a`                |
| maximumBy | Máximo según comparador | `maximumBy (comparing length) ["a","abc","ab"] == "abc"` | `(a -> a -> Ordering) -> [a] -> a` |
| min       | Mínimo de dos valores   | `min 3 5 == 3`                                           | `Ord a => a -> a -> a`             |
| minimum   | Mínimo de lista         | `minimum [1,5,3] == 1`                                   | `Ord a => [a] -> a`                |
| minimumBy | Mínimo según comparador | `minimumBy (comparing length) ["a","abc","ab"] == "a"`   | `(a -> a -> Ordering) -> [a] -> a` |

## (==), (/=), compare, comparing, not
| Función   | Qué hace                    | Ejemplo                         | Tipo                                        |
| --------- | --------------------------- | ------------------------------- | ------------------------------------------- |
| (==)      | Igualdad                    | `3 == 3 == True`                | `Eq a => a -> a -> Bool`                    |
| (/=)      | Distinto                    | `3 /= 4 == True`                | `Eq a => a -> a -> Bool`                    |
| compare   | Comparación (LT,EQ,GT)      | `compare 3 5 == LT`             | `Ord a => a -> a -> Ordering`               |
| comparing | Crea comparador por función | `sortBy (comparing length) ...` | `(Ord b) => (a -> b) -> a -> a -> Ordering` |
| not       | Negación                    | `not True == False`             | `Bool -> Bool`                              |

