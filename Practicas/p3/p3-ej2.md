```
A, B, ... :: = P | ⊥ | (A ∧ B) | (A ⇒ B) | (A ∨ B) | ¬ A
Uso induccion en la gramatica proposicional
```
## Hipotesis inductiva
Toda formula puede escribirse usando solo ¬ o ∨.

## Caso Base
```
T = P  -- > Se cumple ya que al no usar conectores puedo decir que 
            "solo use ¬ o ∨".
```
## Conjuncion
```
Quiero mostrar: T = A ∧ B puede escribirse usando solo ¬ y ∨.

Por HI: existen A', B' equivalentes a A y B respectivamente,
construidos solo con ¬ y ∨.

Entonces:
A ∧ B ≡ ¬(¬A ∨ ¬B) ≡ ¬ (¬A' v ¬B')
Pude escribir a T solo con ¬ y ∨

Demostración: A ∧ B ≡ ¬(¬A ∨ ¬B)

Queremos probar que para toda valuación V:

    V ⊨ A ∧ B   sii   V ⊨ ¬(¬A ∨ ¬B)

Dirección (⇒):

    Supongamos: V ⊨ A ∧ B
    Entonces:   V ⊨ A  y  V ⊨ B
    Luego:      V ⊭ ¬A y  V ⊭ ¬B  --> V ⊨ A v B sii V ⊨ A v V ⊨ B
                                      entonces : V ⊭ A v B sii V ⊭ ¬A y V ⊭ ¬B
    Entonces:   V ⊭ (¬A ∨ ¬B)
    Por lo tanto: V ⊨ ¬(¬A ∨ ¬B)

Dirección (⇐):

    Supongamos: V ⊨ ¬(¬A ∨ ¬B)
    Entonces:   V ⊭ (¬A ∨ ¬B)
    Entonces:   V ⊭ ¬A  y  V ⊭ ¬B
    Luego:      V ⊨ A   y  V ⊨ B
    Por lo tanto: V ⊨ A ∧ B

Conclusión:

    A ∧ B ≡ ¬(¬A ∨ ¬B)

Por lo tanto, cualquier conjunción puede escribirse usando solo ¬ y ∨.
```
## Implicacion
```
Quiero mostrar: T = A ⇒ B puede escribirse usando solo ¬ y ∨.

Por HI: existen A', B' equivalentes a A y B respectivamente,
construidos solo con ¬ y ∨.

Sabemos que semánticamente:
    V ⊨ A ⇒ B   sii   V ⊨ ¬A ∨ B

Entonces:
    A ⇒ B ≡ ¬A ∨ B
    A ⇒ B ≡ ¬A' ∨ B'     (por equivalencia de A ≡ A' y B ≡ B')

Por lo tanto, podemos construir T usando solo ¬ y ∨.

Demostracion: A ⇒ B ≡ ¬A ∨ B

Dirección (⇒):
    Supongamos  : V ⊨ A ⇒ B
    entonces    : V ⊭ A v V ⊨ B
    luego       : V ⊨ ¬A v V ⊨ B
    Por lo tanto: V ⊨ ¬A v B

Dirección (⇐):
    Supongamos  : V ⊨ ¬A v B
    entonces    : V ⊨ ¬A v V ⊨ B
    por lo tanto: V ⊨ A ⇒ B  
```
## Disyuncion
```
Quiero mostrar: T = A v B puede escribirse usando solo ¬ y ∨.
T = A ∨ B  
Por HI: ∃ A' ≡ A y ∃ B' ≡ B,  
tal que A' y B' usan solo ¬ o ∨  
Entonces: T ≡ A' ∨ B'  -- > Puedo escribir a T usando solo ¬ o ∨.
```
## Negacion:
```
Quiero mostrar: T = ¬A usando solo ¬ y ∨.
T = ¬A
Por HI: ∃ A' ≡ A , tal que A' usa solo ¬ o ∨
Entonces: T ≡ A' -- > Puedo escribir a T usando solo ¬ o ∨.
```

