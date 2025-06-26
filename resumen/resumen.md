##### Inferencia:
- erase(M) es el término que resulta de borrar las anotaciones de tipo de M.
    - ej : erase((λx : Bool. x) True) = (λx. x) True.

- Un término U sin anotaciones de tipo es tipable sii existen:
    - un contexto de tipado Γ
    - un término con anotaciones de tipos M
    - un tipo τ
- Tales que erase(M) = U y Γ ⊢ M : τ .

- Los tipos se forman usando incognitas y constructores:
    - τ ::= Xn | C (τ1 , . . . , τn ) 
- La **unificación** es el problema de resolver sistemas de ecuaciones
entre tipos con incógnitas.
- Una **sustitución** es una función **S** que a cada incógnita le asocia un
tipo.
- Un **problema de unificación** es un conjunto finito E de
ecuaciones entre tipos que pueden involucrar incógnitas:
    - E = {τ1 =? σ1 , τ2 =? σ2 , . . . , τn =? σn }
    - En general, la solución a un problema de unificación no es única.
- S es un **unificador** de E si para cada (τ =? σ) ∈ E se tiene que S(τ) = S(σ).
- Una sustitución **S**A es más general que una sustitución **S**B si
existe una sustitución **S**C tal que:
    - SB = SC o SA, es decir es la composición.
- Algoritmo de **Martelli–Montanari**:
    - Mientras E != ∅ , se aplica sucesivamente alguna regla de reducción.
    - Si E llega al vacío, tiene solución, **S**.
        - Además S es un unificador de E y es el más general de todos.
        - Notamos mgu(E) al unificador más general de E , si existe.
    - Si E llega a una falla, no tiene solución.

##### LPO
- Un lenguaje de primer orden L está dado por:
    - Un conjunto de sı́mbolos de función F = {f, g, h, . . .}.
    - Un conjunto de sı́mbolos de predicado P = {P, Q, R, . . .}.
    - Cada simbolo de predicado o función vienen con una aridad asociada >= 0.

- Dos fórmulas que sólo difieren en los nombres de las variables
ligadas se consideran iguales.
    - ej: ∀X . ∃Y . P(X , Y ) ≡ ∀Y . ∃X . P(Y , X ) ≡ ∀A. ∃B. P(A, B)
- Notamos σ{X := t} a la sustitución de las ocurrencias libres de X
en la fórmula σ por el término t, evitando la captura de variables.

- En deducción natural ampliado a LPO, la regla ∀i exige que X no este en fv(Γ).
    - Esto garantiza que X es verdaderamente arbitrario y no condicionado por las hipótesis
    - Evita que intentes generalizar algo que sólo vale para un X particular mencionado en las hipótesis.
    - Preserva la corrección lógica de la regla: ∀ introduce una verdad para todos los X, no sólo para los que satisfacen tus hipótesis.

- La regla ∃e significa:
    - “Si existe un X tal que φ, entonces, sin importar qué testigo sea, si suponiendo ese testigo arbitrario puedo demostrar τ, entonces τ es cierto”.
    - Para que el testigo sea arbitrario, necesitamos que:
        - No esté mencionado en las hipótesis (Γ).
        - No aparezca en la conclusión (τ).
    - Si esto no ocurriese podría estar condicionado y no ser verdaderamente un testigo libre

##### Prolog
- Los programas se escriben en un subconjunto de la lógica de primer orden.
- Es declarativo: se especifican hechos, reglas de inferencia y objetivos, sin
indicar cómo se obtiene este último a partir de los primeros.
- Se computa basandose en cláusulas de Horn y resolución SLD.
- Mundo cerrado: sólo se puede suponer lo que se declaró explı́citamente,
todo lo que no pueda deducirse a partir del programa se supone falso.
- Tiene un solo tipo: los términos.
- Sintaxis de prolog:
    - **Variables**: X, Y, Z, etc. Son valores que todavia no fueron ligados (Siempre comienzan en máyuscula).
    - **Números**: 10, 15.6
    - **Átomos**: zombie, ’hola␣mundo’, constantes , textos, nombres de términos compuestos (Comienzan en minúscula).
    - **Términos compuestos**: es_par(término), también llamado **estructura**.Consiste en un nombre (átomo) seguido de n
    argumentos, cada uno de los cuales es un término. Decimos que n es la
    aridad del término compuesto.
    - **Término**: Variable, número, átomo o término compuesto.
    - **Cláusula**: es una lı́nea del programa. Termina con punto. Puede ser:
        - Hecho: **es_par(0)**.
        - Regla de inferencia: **es_par(suc(N)):- es_par(N)** 
    - **Predicado**: colección de cláusulas.
    - **Objetivo (goal)**: es el predicado que se consulta al motor de Prolog. Por ejemplo:
        - ?- es_par(3).
- Dado un programa **P** y un Goal **G** , se desea saber si **G** es consecuencia de **P**
- Para esto prolog usa resolución SLD.
- Resuelve el goal empezando en **G1** de izquierda a derecha haciendo DFS (depth first search).
- Ej: Si el goal a resolver es ?- es_par(N), es_primo(N), prolog comienza la resolución con es_par(N).
- Para cada **Gi** prolog busca unificarlo con la cabeza de de alguna cláusula del programa, siempre de arriba hacia abajo.
- Como no hay "elección" podriamos decir que es deterministico.
- Si logra llegar a la clausula vacía devuelve true, y devuelve false si la resolución termina con una cláusula que no unifica con ninguna regla del programa.
- **Reversibilidad**:
    - Un predicado define una relación entre elementos. No hay parámetros de
    “entrada” ni de “salida”.
    - Conceptualmente, cualquier argumento podrı́a cumplir ambos roles dependiendo
    de cómo se consulte.
    - **+X**: X esta instanciado, **-X**: X no esta instanciado, **?X**: X puede estar o no instanciado (Es reversible).
    - Se debe tener en cuenta que el usuario no puede suponer más cosas de las que
    se especificaron. En caso de llamar a un predicado con argumentos instanciados
    de otra manera, el resultado puede no ser el esperado.
- El motor de operaciones aritméticas de prolog es independiente del motor lógico (**Es extra-lógico**)
    - **Expresiones aritméticas**: (Deben estar instanciadas, de lo contrario da error)
        - Números, variables ya instanciadas en expresiones aritméticas, E1+E2, E1-E2,      E1*E2, E1/E2, etc, siendo E1 y E2 expresiones aritméticas.
    - **Operadores aritméticos**:
        - E1 < E2, E1 =< E2, E1 >= E2, E1 =:= E2, E1 =\= E2: evalúa
        ambas expresiones aritméticas y realiza la comparación indicada.
        - **X is E**: tiene éxito sı́ y sólo si X unifica con el resultado de evaluar la
        expresión aritmética E.(Es importante que E no contenga variables sin instanciar al momento de la evaluación, X puede estar instanciado o no).
- **Generate and Test**
    1. Generar todas las posibles soluciones de cierto problema.
    2. Testear cada una de las soluciones y filtrar las que fallen.
    - **pred(X1,...,Xn) :- generate(X1, ...,Xm), test(X1, ...,Xm).**
        - Esta division de tareas implica que:
            - generate(...) deberá instanciar ciertas variables.
            - test(...) deberá verificar si los valores intanciados pertenecen a
             la solución, pudiendo para ello asumir que ya está instanciada.
- Meta-predicado **not**
    - **not(p(X1, ..., Xn))** tiene éxito si **no existe** instanciación posible
    para las variables **no instanciadas** en {X1...Xn} que haga que P
    tenga éxito.
    - El not **no deja instanciadas** las variables libres luego de su ejecución.


##### Resolución 
- **Resolución General**:
    - Entrada: una fórmula σ de la lógica de primer orden.
    - Salida: Un booleano que indica si σ es válida.
        - **Si σ es válida, el método siempre termina.**
        - **Sino es válida, el método puede no terminar.**
    - **Método de resolución de primer orden** (Procedimiento de semi-decisión).
        1. Escribir ¬σ como un conjunto C de cláusulas.
        2. Buscar una refutación de C.
            - **Si existe alguna refutación, el método encuentra alguna.**
            - **Si no existe una refutación, el método puede “colgarse”.**
    - **Refutación**
        - Para refutar C usamos el algoritmo de resolución para lógica de primer orden.
        - Si llegamos a la cláusula vacía, tenemos que  C ⊢ ⊥, y esto nos dice que existe una manera de elegir las cláusulas tal que el algoritmo de refutación termina.
        - **Si C ⊬ ⊥, no hay garantı́a de terminación.**

- **Resolución SLD**
    - Variante de resolución general, un tradeoff , tiene menos generalidad a cambio de mayor eficiencia.
    - Menor generalidad por que solo se puede aplicar sobre **Cláusulas de Horn**
    - Mayor eficiencia por que se reducen las opciones de búsqueda/selección.
- Una derivación SLD comienza con n ≥ 0 cláusulas de definición y una cláusula objetivo:
    - D1 ... Dn G1
- En cada paso:
    - Se elige una cláusula definición Dj con 1 ≤ j ≤ n.
    - Se aplica la regla de resolución SLD sobre Dj y Gi .
    - La resolvente es una nueva cláusula objetivo Gi+1 .
    - **Esto implica que se llega a un resultado linealmente.**
- El método de resolución es completo para cláusulas de Horn.
- Más precisamente, si D1 , . . . , Dn son cláusulas de definición y G una cláusula objetivo:
    - Si {D1 , . . . , Dn , G } es insatisfactible, existe una refutación SLD.
- **Resolución en prolog:**
    - Un programa en Prolog es una lista de cláusulas de definición.
    - Una consulta en Prolog es una cláusula objetivo.
    - Prolog busca sucesivamente todas las refutaciones haciendo DFS.
    - La exploración depth-first (DFS) es **incompleta**. Puede provocar que Prolog nunca encuentre refutaciones posibles.
    - Al unificar, Prolog no usa la regla occurs-check. Por ejemplo, X unifica con f(X). Esto es **incorrecto**.
    - Puede provocar que Prolog encuentre una “refutación” **incorrecta**.

##### POO
- Los programas están conformados por componentes, llamadas
objetos, que interactúan intercambiando mensajes.
- Un objeto puede enviar un mensaje a otro. Un mensaje
representa una solicitud al objeto receptor, para que lleve a
cabo una de sus operaciones.
- La **interfaz** de un objeto es el conjunto de mensajes que es
capaz de responder.
    - Supongamos que tenés un objeto que representa un número (5).
    - Ese objeto puede responder a mensajes como:
        - 5 + 3          "Devuelve 8"
        - 5 printString  "Devuelve '5'"
        - 5 isZero       "Devuelve false"
    - Entonces, su interfaz incluye los **mensajes**: + , printString, isZero
- Un **método** es el procedimiento que usa un objeto para
responder un mensaje. Es decir, es la implementación efectiva
de la operación solicitada por el mensaje.
    - Ej Cuando escribis: 5 factorial  **"Envía el mensaje 'factorial' al número 5"**
    - **Mensaje**: 'factorial'
    - El objeto 5 (una instancia de la clase SmallInteger) recibe ese mensaje.
    - Smalltalk busca en la clase SmallInteger el método llamado factorial.
    - Encuentra el código (el método) que sabe cómo calcular el factorial y lo ejecuta.
- La forma en la que un objeto lleva a cabo una operación puede
depender de **colaboradores externos** ası́ como de su estado
interno, dado por un conjunto de **colaboradores internos** .
    - **colaboradores externos**: 
        - También llamados parámetros o argumentos del mensaje recibido.
    - **colaboradores internos**: 
        - Son los **atributos** o **variables de instancia** del objeto.
        - Representan su **estado**.
        - Se definen en la clase y viven dentro del objeto mientras exista.
    - Cuando un método se ejecuta, puede usar un argumento (colaborador externo) para modificar el estado del objeto (colaboradores internos).
    - Analogía con una calculadora: 
        - Su memoria interna (el valor que guarda) es un colaborador interno.
        - Los números que le ingresás son colaboradores externos.
- **Encapsulamiento**
    - **Principio de encapsulamiento**
        - Sólo se puede interactuar con un objeto a través de su interfaz.
        - El estado interno de un objeto es inaccesible desde el exterior.
    - **Consecuencias**
        - Un conjunto de enteros se puede representar con una lista enlazada o con un árbol binario balanceado, sin que el usuario pueda notar una diferencia de comportamiento.
        - **Duck Typing**: Un objeto se puede intercambiar por otro que
        implemente la misma interfaz.
            - No importa de qué clase es un objeto, solo importa si sabe responder a los mensajes enviados.
            - Ej Si tengo un objeto 5 y otro objeto soyCinco , si ambos responden al mensaje "alCuadradoDoy25" , entonces los puedo considerar el mismo objeto.
- **Características de SmallTalk**:
    - **Envı́o de mensajes sincrónico**:
        - Cuando un objeto recibe un mensaje, el procesamiento **se detiene** hasta que el objeto responda.
        - Si el envío fuera asincrónico un mensaje se podría procesar en segundo plano mientras se continua con mensajes posteriores.
    - **Envı́o de mensajes con respuesta**:
        - En Smalltalk, cuando le enviás un mensaje a un objeto, ese envío siempre devuelve un resultado.
        - El valor del retorno puede ser: otro objeto, un valor simple (número, booleano, etc), o nil si no hay nada que devolver.
    - **Objetos mutables**
        - Sus colaboradores internos se pueden modificar durante la ejecución.
            - Si bien el estado interno (atributos) está privado (no accesible directamente), cada clase define métodos públicos para:
                - Leer valores (**getters**).
                - Modificar valores (**setters**).
    - **Clasificación**:
        - En Smalltalk, una clasificación es simplemente una clase.
        - Define:
            - Qué **atributos** tienen sus objetos.
            - Qué **métodos** pueden responder esos objetos.
    - **Herencia simple**:
        - Cada clase tiene una única superclase de la cual hereda atributos y métodos.
        - Esto quiere decir que la jerarquía de clases es un árbol, sin múltiples padres (no hay herencia múltiple).
- **Clases e instancias**
    - Todo objeto es **instancia** de alguna **clase.**
        - Ejemplo. (1 @ 2) es una instancia de la clase Point.
    - Todas las instancias de una clase tienen los mismos atributos.
        - Ejemplo. Todas las instancias de Point tienen atributos x e y.
    - Todas las instancias de una clase usan el mismo método para
      responder un mismo mensaje.
        - Ejemplo. Los mensajes (1 @ 2) rho y (3 @ 4) rho se
        resuelven con un método implementado en la clase Point.
    - Cada clase es subclase de alguna otra clase.
    - Una clase hereda todos los métodos de su superclase.
    - Una clase puede elegir reemplazar (**override**) un método definido en la
    superclase por otro más especı́fico.
    - Hay clases que están destinadas a abstraer el comportamiento de
    sus subclases, pero no tienen instancias 
    - Estas se llaman clases **abstractas**.
    - Ej la clase **Number**
        - Define operaciones básicas para números.
        - Pero no vas a crear un objeto que sea simplemente un **Number**.   
        - En cambio, crearás objetos de subclases como SmallInteger, Float, etc.
        - Number  (abstracta)
            - ├── SmallInteger  (concreta, instanciable)
            - └── Float         (concreta, instanciable)
            