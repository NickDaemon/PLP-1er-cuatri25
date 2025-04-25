## Comentarios generales:
* Hay warnings al compilar el TP. No ignoren los warnings.
* Faltan tildes en muchas palabras.

## Ejercicio 1:
* ¿Por qué eligieron el nombre **acc**? Siguiendo la convención del resto de las variables me parece que **fVacio** sería una mejor opción. Además foldDoc es recursión estructural, no se confundan con recursión iterativa donde efectivamente tenemos un acumulador por definición. En recursión estructural no es del todo correcto pensar en un acumulador.

## Ejercicio 2:
* El comentario que pusieron:
    `d2 actua como caso base ya que vamos a "concatenarle" los doc de d1.`
  No es correcto. En todo caso van a concatenarle d2 a d1. Además, ¿qué significa "los doc de d1"? Si d1 ya es un Doc.

* (\k acc -> Linea k acc) es Linea.
* Nuevamente acc no es una buena elección de nombre.
* ¿Cómo saben que **s** y **s'** son strings no vacios y sin saltos de linea? Esto es parte de la justificación.

## Ejercicio 3:
* (\t acc -> Texto t acc) es Texto.
* ¿Cómo saben que tanto **i** como **k** son números positivos? Esto es parte de la justificación.

## Ejercicio 6:
foldr (\x rec -> f x && rec) True es all f.

## Ejercicio 8:
* Nombres de variables confusos. Venían usando **s** para el string que está en un **Texto** pero ahora lo usan para el entero que representa la indentación. Y en cambio el string de un **Texto** ahora se llama **t**.

## Ejercicio 9:
* Repiten entreLlaves (map parAdoc lista). Podrían haberle puesto un nombre adentro del where.
* Entiendo el nombre **fSimple** pero ¿por qué usaron **fRec** si el PPON no es simple? No parece ser un nombre muy semántico.
* No es recursión estructural. Revisen si no estarán accediendo a la subestructura del ppon en algún lugar.

## Ejercicio 10:
* Cuando prueban los 3 lemas no reemplazan correctamente por la ecuación **{I}**.
* En la definición de indentar tienen **(\i acc -> Linea (k+i) acc)**.
  Pero en todos lados donde usan esa ecuación pusieron: **(\k acc -> Linea (i+k) acc)**.
* Al reemplazar ecuaciones tienen que hacerlo de manera textual. Luego pueden hacer un paso de α-renombre para modificar el nombre de las variables ligadas si lo consideran necesario.
* Para dar vuelta una suma (cambiar x+y por y+x) también hay que hacer un paso y justificarlo por la conmutatividad de Int.
* Cuando prueban P(x) ⟹ P(Texto s x):
    - Volvieron a demostrar L2.
    - Pero luego sí usan L2.
    - En efecto tienen que usar L2 dos veces seguidas y listo.
    - Más grave: la conclusión está mal. La HI vale para x pero la usan    para **Texto s x**.
* Cuando prueban P(x) ⟹ P(Linea i x):
    - Mismo error que el otro caso, en vez de usar L2 dos veces lo usan una vez y lo vuelven a demostrar otra vez.
    - La conclusión también está mal por la misma razón que el otro caso.
* Los cuantificadores ∀ n,m :: Int deberían ir en la definición de la propiedad a probar. Es decir:
    - **P(x) = ∀ n,m :: Int. (n >= 0 && m >= 0) ⟹ indentar n (indentar m x) = indentar (n+m) x**

## Reentregar:
* Corregir justificaciones de los ejercicios 2, 3 y 9.
* Corregir demostración del ejercicio 10.
* El resto de los comentarios son opcionales para la reentrega. Pero por favor asimilen el feedback para el parcial.