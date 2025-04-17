τ, σ :: = P | ⊥ | (τ ∧ σ) | (τ ⇒ σ) | (τ ∨ σ) | ¬ τ
Uso induccion en la gramatica proposicional

## Hipotesis inductiva
Toda formula puede escribirse usando solo ¬ o ∨.

## Caso Base
```
T = P  -- > Se cumple ya que al no usar conectores puedo decir que 
            "solo use ¬ o ∨".
```
## Disyuncion
```
Quiero mostrar: T = A v B puede escribirse usando solo ¬ y ∨.
T = A ∨ B  
Por HI: ∃ A' ≡ A y ∃ B' ≡ B,  
tal que A' y B' usan solo ¬ o ∨  
Entonces: T ≡ A' ∨ B'  -- > Puedo escribir a T usando solo ¬ o ∨.
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
```
