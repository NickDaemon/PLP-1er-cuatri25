## A:
### I:
 - u x (y z) (λv : Bool. v y)

 - (((u x) (y z)) (λv : Bool. v y))

### II:
Para dibujar el arbol sintáctico puedo verlo como
M = ((u x) (y z)) , y N = (λv : Bool. v y) y empezar a descomponer

App
├── App
│   ├── App
│   │   ├── u
│   │   └── x
│   └── App
│       ├── y
│       └── z
└── Abs (λv : Bool. v y)
    └── App
        ├── v
        └── y

### III:
 | Variable | ¿Libre o ligada? | ¿Dónde aparece?                   |
| -------- | ---------------- | --------------------------------- |
| `u`      | Libre            | En `u x`                          |
| `x`      | Libre            | En `u x`                          |
| `y`      | Libre            | En `y z` y en `v y`               |
| `z`      | Libre            | En `y z`                          |
| `v`      | Ligada           | En `λv : Bool. v y` (solo la `v`) |


## B:

