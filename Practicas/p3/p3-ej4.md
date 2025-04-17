## 4
```
Probar que:  
Si φ es una tautología, entonces contiene al menos un ¬ o un ⇒

Supongamos lo contrario:
    φ es una tautología
    φ no contiene ¬ ni ⇒

Entonces:
    φ está construida solo con:
        - letras proposicionales (P, Q, R, ...)
        - conectivos ∧ y ∨

Tomar una valuación V tal que:
    para toda letra proposicional p en φ:
        V(p) := False

Evaluar φ bajo V:
    - toda conjunción (∧) será False
    - toda disyunción (∨) también será False (porque todo es False)

Entonces:
    V ⊭ φ   → contradicción con el hecho de que φ es una tautología

Por lo tanto:
    φ debe contener al menos un ¬ o un ⇒ para poder ser tautologia.
```