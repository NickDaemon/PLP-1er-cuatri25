## 3.1
```
(T ⇒ Q) ∨ (P ⇒ C) ≡ True v False ≡ True
Es tautologia.
```
## 3.2
```
Analizar: φ := (T ⇒ P) ∨ (Q ⇒ C)

Separo en terminos de ¬ y v

φ := (¬T v P) v (¬Q v C)

Como T ⇒ Q es tautologia se cumple que:
V ⊨ T ⇒ Q  sii V ⊭ T  v V ⊨ Q

Como P ⇒ C es contradiccion se cumple que:
V ⊭ P ⇒ C sii V ⊨ P v V ⊭ C

Teniendo en cuenta esto asigno valores de verdad y me fijo si φ
puede tener distintas valuaciones:

Caso 1:
T = True, P = True
Q = True, C = True

φ := (¬T v P) v (¬Q v C)
φ := (¬True v True) v (¬True v True) 
φ := True v True 
φ := **True**

Caso 2:
T = True, P = False
Q = True,  C = False

φ := (¬T v P) v (¬Q v C)
φ := (¬True v False) v (¬True v False)
φ := (False v False) v (False v False)
φ := **False**

Como φ tiene distintos valores de verdad segun T,Q,P y C concluyo que es contingencia.
```
## 3.3
```
Analizar: φ := (P ⇒ Q) ∨ (C ⇒ Q)

Separo en terminos de ¬ y v

φ := (P ⇒ Q) ∨ (C ⇒ Q)
φ := (¬P v Q) ∨ (¬C v Q)
φ := ¬P v Q v ¬C v Q
φ := ¬P v ¬C v Q
P implica not C v Q

Como T ⇒ Q es tautologia se cumple que:
V ⊨ T ⇒ Q  sii V ⊭ T  v V ⊨ Q

Como P ⇒ C es contradiccion se cumple que:
V ⊭ P ⇒ C sii V ⊨ P v V ⊭ C

Caso 1:
P = True, C = True, Q = False

φ := ¬P v ¬C v Q
φ := ¬True v ¬True v False
φ := False v False v False
φ := **False**

Caso 2:
P = False, C = True, Q = False

φ := ¬P v ¬C v Q
φ := ¬False v ¬True v False
φ := True v False v False
φ := **True**

Como φ tiene distintos valores de verdad segun P,C y Q concluyo que es contingencia.
```



