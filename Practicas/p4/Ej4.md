## A:
### I:
 - u x (y z) (λv : Bool. v y)

 - (((u x) (y z)) (λv : Bool. v y))

### II:
Para dibujar el arbol sintáctico planteo:
 - M N
 - M = (P R) (S Q)
 - P = u, R = x
 - S = y, Q = z
 - N = (λv : Bool. X Y)
 - X = v, Y = y


### III:
 | Variable | ¿Libre o ligada? | ¿Dónde aparece?                   |
| -------- | ---------------- | --------------------------------- |
| `u`      | Libre            | En `u x`                          |
| `x`      | Libre            | En `u x`                          |
| `y`      | Libre            | En `y z` y en `v y`               |
| `z`      | Libre            | En `y z`                          |
| `v`      | Ligada           | En `λv : Bool. v y` (solo la `v`) |


## B:

