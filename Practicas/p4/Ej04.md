## A:
### I:
 - u x (y z) (λv : Bool. v y)

 - (((u x) (y z)) (λv : Bool. v y))

### II:
Arbol sintáctico:
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
### I:
- (λx : Bool → Nat → Bool. λy : Bool → Nat. λz : Bool. x z (y z)) u v w
- (((λx: Bool → (Nat → Bool). (λy: Bool → Nat. (λz: Bool. (x z) (y z)))) u) v) w

### II:
Arbol sintáctico:
- M w
- M = N v
- N = O u
- O = λx: Bool → (Nat → Bool). P
- P = λy: Bool → Nat. Q
- Q = λz: Bool. R
- R = S T
- S = x z
- T = y z

| Variable | ¿Libre o ligada? | ¿Dónde aparece?       |
| -------- | ---------------- | --------------------- |
| `u`      | Libre            | En `O u`              |
| `v`      | Libre            | En `N = O v`          |
| `w`      | Libre            | En `M = N w`          |
| `x`      | Ligada           | En `λx` (cuerpo: `Q`) |
| `y`      | Ligada           | En `λy` (cuerpo: `R`) |
| `z`      | Ligada           | En `λz` (cuerpo: `S`) |

## C:
### I:
- w (λx : Bool → Nat → Bool. λy : Bool → Nat. λz : Bool. x z (y z)) u v
- (((w (λx : Bool → (Nat → Bool). (λy : Bool → Nat. (λz : Bool. (x z) (y z))))) u) v)

### II:
Arbol sintáctico:

- M = ((N u) v)
- N = w O
- O = λx: Bool → (Nat → Bool). P
- P = λy: Bool → Nat. Q
- Q = λz: Bool. R
- R = (x z) (y z)

### III:
| Variable | ¿Libre o ligada? | ¿Dónde aparece?              |
| -------- | ---------------- | ---------------------------- |
| `w`      | Libre            | En la aplicación más externa |
| `x`      | Ligada           | En `O`                       |
| `y`      | Ligada           | En `P`                       |
| `z`      | Ligada           | En `Q`                       |
| `u`      | Libre            | En la aplicación intermedia  |
| `v`      | Libre            | En la aplicación más externa |


## IV:
- A = (λx : Bool → Nat → Bool. λy : Bool → Nat. λz : Bool. x z (y z)) u
- B = (((λx: Bool → (Nat → Bool). (λy: Bool → Nat. (λz: Bool. (x z) (y z)))) u) v) w
- C = (((w (λx : Bool → (Nat → Bool). (λy : Bool → Nat. (λz : Bool. (x z) (y z))))) u) v)
 - A aparece como subtermino solo en B.