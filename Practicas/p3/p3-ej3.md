## 3.1
```
(T ⇒ Q) ∨ (P ⇒ C) ≡ True v False ≡ True
Es tautologia.
```
## 3.2
```text
Analizar: φ := (T ⇒ P) ∨ (Q ⇒ C)

Queremos determinar si φ es:
    - una tautología (siempre verdadera)
    - una contradicción (siempre falsa)
    - una contingencia (a veces verdadera, a veces falsa)

Paso 1: Reescribimos usando equivalencias lógicas:

    T ⇒ P  ≡ ¬T ∨ P
    Q ⇒ C  ≡ ¬Q ∨ C

Entonces:

    φ := (¬T ∨ P) ∨ (¬Q ∨ C)
       ≡ ¬T ∨ P ∨ ¬Q ∨ C

Ahora simplificamos la expresión lógica:

    φ ≡ (¬T ∨ ¬Q) ∨ (P ∨ C)

Paso 2: Evaluamos la verdad de φ con ejemplos

Caso 1: Supongamos
    T = True, P = False,
    Q = True, C = False

    Entonces:
        T ⇒ P = False
        Q ⇒ C = False
        φ = False ∨ False = False

⇒ Existe una valuación donde φ es falsa

Caso 2: Supongamos
    T = False → ¬T = True
    Entonces ¬T ∨ cualquier cosa = True

⇒ En este caso φ es verdadera

⇒ También hay valuaciones donde φ es verdadera

Conclusión:

    φ es una CONTINGENCIA
```


## 3.3
```text
Sean:

    - T ⇒ Q es tautología
        Entonces: para toda valuación V, se cumple:
            V ⊭ T o V ⊨ Q

    - P ⇒ C es contradicción
        Entonces: para toda valuación V, se cumple:
            V ⊨ P y V ⊭ C

Queremos analizar la fórmula:

    φ := (P ⇒ Q) ∨ (C ⇒ Q)

Equivalencia semántica de la disyunción:

    V ⊨ φ  ↔  (V ⊭ P o V ⊨ Q) o (V ⊭ C o V ⊨ Q)
           ↔  V ⊭ P ∨ V ⊭ C ∨ V ⊨ Q

Elegimos una valuación válida por la hipótesis (de la contradicción):

    Supongamos V tal que:
        V ⊨ P
        V ⊭ C
        V ⊭ Q

    Entonces:
        V ⊭ P → False
        V ⊭ C → True
        V ⊨ Q → False

        V ⊨ φ ↔ False ∨ True ∨ False = True

Ahora veamos si existe una valuación que haga φ falsa:

    Supongamos V tal que:
        V ⊨ P
        V ⊨ C
        V ⊭ Q

    Entonces:
        P ⇒ Q → False (True ⇒ False)
        C ⇒ Q → False (True ⇒ False)

        φ := False ∨ False = False

⇒ Existe una valuación donde φ es verdadera y otra donde es falsa.

Conclusión:

    φ es una CONTINGENCIA
```



