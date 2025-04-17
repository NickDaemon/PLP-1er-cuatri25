τ, σ :: = P | ⊥ | (τ ∧ σ) | (τ ⇒ σ) | (τ ∨ σ) | ¬ τ

```
Uso induccion en la gramatica proposicional

HI: Toda formula puede escribirse usando solo ¬ o ∨
Caso base:
T = P  -- > Se cumple ya que al no usar conectores puedo decir que 
            "use ¬ o ∨".

Caso inductivo: 
Disyuncion:
T = A ∨ B  
Por HI: ∃ A' ≡ A y ∃ B' ≡ B,  
tal que A' y B' usan solo ¬ o ∨  
Entonces: T ≡ A' ∨ B'  -- > Se cumple la disyuncion.
```