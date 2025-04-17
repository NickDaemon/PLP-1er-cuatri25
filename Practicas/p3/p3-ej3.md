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
V ⊭ P ⇒ C sii V ⊨ P ∧ V ⊭ C

Teniendo en cuenta esto asigno valores de verdad y me fijo si φ
puede tener distintas valuaciones:

Caso 1:
P = True,  C = False
T = True,  Q = True 

φ := (¬T v P) v (¬Q v C)
φ := (¬True v True) v (¬True v False) 
φ := True v False
φ := True

Caso 2:
P = True,  C = False
T = False, Q = False

φ := (¬T v P) v (¬Q v C)
φ := (¬False v True) v (¬False v True)
φ := (True v True) v (True v True)
φ := True

Caso 3:
P = True,  C = False
T = False, Q = True

φ := (¬T v P) v (¬Q v C)
φ := (¬False v True) v (¬True v False)
φ := (True v True) v (False v False)
φ := True v False
φ := True

Como φ es True para todos los casos , concluyo que es tautologia
```
## 3.3
```
Analizar: φ := (P ⇒ Q) ∨ (C ⇒ Q)

Separo en terminos de ¬ y v

φ := (P ⇒ Q) ∨ (C ⇒ Q)
φ := (¬P v Q) ∨ (¬C v Q)
φ := ¬P v Q v ¬C v Q
φ := ¬P v ¬C v Q


Como T ⇒ Q es tautologia se cumple que:
V ⊨ T ⇒ Q  sii V ⊭ T v V ⊨ Q

Como P ⇒ C es contradiccion se cumple que:
V ⊭ P ⇒ C sii V ⊨ P ∧ V ⊭ C

Caso 1:
P = True, C = False, Q = False

φ := ¬P v ¬C v Q
φ := ¬True v ¬False v False
φ := False v False v False
φ := False

Caso 2:
P = True, C = True, Q = True

φ := ¬P v ¬C v Q
φ := ¬True v ¬True v False
φ := False v False v True
φ := True

Como φ tiene distintos valores de verdad segun P,C y Q concluyo que es contingencia.
```



