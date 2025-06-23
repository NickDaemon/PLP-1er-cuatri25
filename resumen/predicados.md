- **sort(+Lista, ?ListaOrdenada)**
    - ListaOrdenada es la versión ordenada de Lista, sin duplicados.
    - La ordenación es estándar: de menor a mayor (alfanumérico si son átomos, numérico si son números, etc.).
    - Los elementos duplicados se eliminan

- ?- sort([3, 1, 2, 2], L).  **L = [1, 2, 3]**.

- ?- sort([3, 1, 2, 2], [1,2,3]): **true**.

- ?- sort([b, a, c], L): **L = [a, b, c]**.

- ?- sort([a, 1, [x], foo(1), "str"], L): **L = [1, a, "str", [x], foo(1)].**
- (Primero los números, luego los átomos, strings, listas y términos compuestos).

- **msort(+Lista, ?ListaOrdenada)**
    - idem a sort pero esta version deja duplicados.

- ?- msort([3,1,2,2], LOrd): **LOrd = [1,2,2,3]**.

- ?- msort([3,1,2,2], [1,2,2,3]): **true**.

- ?- msort([3,1,2,2], [1,2,3]): **false.  # falta un 2**

- **nth1(?N, +Lista, ?Elem)**
    - Relaciona el elemento Elem con el elemento en la posición N (empezando a contar desde 1) de **Lista**.

- **N y Lista instanciados, obtiene Elem**
    - ?- nth1(2, [a,b,c], X): **X = b**.

- **Lista y Elem instanciados, busca N**
    - ?- nth1(N, [a,b,c], b): **N = 2**.

- **Lista y N instanciados, verifica Elem**
    - ?- nth1(3, [a,b,c], c): **true.**

- **nth0(?N, +Lista, ?Elem)**
    - idem a nth1 pero ahora cuenta las posiciones desde 0.

- ?- nth1(0, [a,b,c], X): **X = a.**

- **is_list(+X)**
    - Verifica si X es una lista.
- **list_to_set(+Lista, ?ConjuntoSinDuplicados)**
    - Convierte una lista que puede tener elementos repetidos en una lista (conjunto) que mantiene el orden de la primera aparición de cada elemento pero sin duplicados.

- ?- list_to_set([a,b,a,c,b], S): **S = [a,b,c]**.

- ?- list_to_set([1,2,3,2,1,4], S): **S = [1,2,3,4].**


- **union(+Conjunto1, +Conjunto2, ?Union)**
    - Construye la unión de dos listas (conjuntos) sin duplicados, preservando el orden de los elementos: primero los de Conjunto1 y luego los de Conjunto2 que no estén en Conjunto1.

- ?- union([a,b,c], [b,c,d,e], U): **U = [a,b,c,d,e]**.

- ?- union([1,2], [2,3,4], U): **U = [1,2,3,4].**

- **intersection(+Conjunto1, +Conjunto2, -Interseccion)**
    - Calcula la intersección entre dos listas (conjuntos), es decir, los elementos que están en ambos, manteniendo el orden en que aparecen en Conjunto1.

- ?- intersection([a,b,c,d], [b,d,e], I): **I = [b,d].**

- ?- intersection([1,2,3], [3,4,5], I): **I = [3].**

- **subset(+SubConjunto, +Conjunto)**
    - Verifica si todos los elementos de SubConjunto están contenidos en Conjunto. No construye una lista, solo verifica la pertenencia.

- ?- subset([a,b], [a,b,c,d]): **true.**

- ?- subset([a,e], [a,b,c,d]): **false.**

- **subtract(+Lista, +Sustractor, ?Resultado)**
    - Quita de Lista todos los elementos que aparecen en Sustractor, produciendo en Resultado la lista sin esos elementos.

- ?- subtract([a,b,c,d], [b,d], R): **R = [a,c].**

- ?- subtract([1,2,3,4], [2,4,6], R): **R = [1,3].**

- **select(?Elem, ?Lista, ?Resto)**
    - Extrae un elemento Elem de la lista Lista, unificando Resto con la lista resultante de quitar ese elemento una vez. También funciona para insertar un elemento en una lista.

- ?- select(b, [a,b,c], R): **R = [a,c].**

- ?- select(X, [a,b,c], [a,c]): **X = b.**

- ?- select(a, L, [b,c]): **L = [a,b,c].**

- **delete(+Lista, +Elem, -Resultado)**
    - Elimina todas las ocurrencias de Elem en Lista, devolviendo en Resultado la lista sin esos elementos.

- ?- delete([a,b,c,b,d], b, R): **R = [a,c,d].**

- ?- delete([1,2,3,2,4], 2, R): **R = [1,3,4].**
   
- **number(?X)**
    - Verifica si X es un número (entero, flotante, racional, etc). También puede generar números en algunos contextos.
  
- ?- number(42): **true.**

- ?- number(hello): **false.**

- ?- number(X): **X = 0 ; X = 1; ...**

  
- **numlist(+Inicio, +Fin, ?Lista)**
    - Genera una lista con los números enteros desde Inicio hasta Fin (inclusive). Si Inicio > Fin, la lista es vacía.
  
- ?- numlist(1, 5, L): **L = [1,2,3,4,5]**.

- ?- numlist(3, 3, L): **L = [3].**

- ?- numlist(5, 2, L): **L = [].**

  
- **sum_list(+Lista, ?Suma)**
    - Calcula la suma de todos los números en la lista Lista, unificando el resultado en Suma. (Lista debe ser una lista de números)
  
- ?- sum_list([1,2,3,4], S): **S = 10.**

- ?- sum_list([], S): **S = 0.**

  
- **flatten(+ListaAnidada, -ListaPlana)**
    - Convierte una lista que puede contener sublistas anidadas en una lista plana, es decir, sin sublistas, con todos los elementos en una sola lista.
 
- ?- flatten([a, [b, [c, d], e], f], L): **L = [a, b, c, d, e, f].**

- ?- flatten([], L): **L = [].**

 
### Operaciones extralógicas:

- **abs(X, Y)**  
  Calcula el valor absoluto de **X** y unifica el resultado con **Y**.  
  *Debe estar **X** instanciado a un número.*

- **max(X, Y, Max)**  
  Unifica **Max** con el mayor valor entre **X** y **Y**.  
  **X** y **Y** deben estar instanciados a números.

- **min(X, Y, Min)**  
  Unifica **Min** con el menor valor entre **X** y **Y**.  
  **X** y **Y** deben estar instanciados a números.

- **mod(X, Y, Resto)**  
  Calcula el resto de la división entera de **X** por **Y**, unificando con **Resto**.  
  **X** y **Y** deben estar instanciados a enteros, **Y** ≠ 0.

- **gcd(X, Y, GCD)**  
  Calcula el máximo común divisor de **X** e **Y**, unificando con **GCD**.  
  **X** y **Y** deben estar instanciados a enteros.*

- **var(X)**  
  Verifica que **X** sea una variable lógica sin instanciar (variable libre).  
  ***X** debe estar libre.

- **nonvar(X)**  
  Verifica que **X** esté instanciado (no sea variable libre).  

- **ground(X)**  
  Verifica que **X** esté completamente instanciado (sin variables libres anidadas).  



