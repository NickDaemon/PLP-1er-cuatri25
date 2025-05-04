### Modificado
```haskell

Γ ⊢ M: τ
___________________→i2
Γ ⊢ λx: σ. M :σ → τ
```
### Derivando en el original:
```haskell

__________________t-var _______________t-true
Γ' ⊢ x:Bool → Bool      Γ' ⊢ true: Bool
____________________________________t-app
Γ, x:Bool → Bool ⊢ x true: Bool
___________________________t-abs
Γ ⊢ λx: Bool → Bool. x true: (Bool → Bool) → Bool

Γ' = Γ, x:Bool → Bool

```
### λx: Bool → Bool. x true: (Bool → Bool) → Bool
- Es derivable en el sistema original pero no es derivable en el modificado.
- Queda "trabado" en:
```haskell
__________________
Γ' ⊢ x:Bool → Bool 
```
- Ahi Γ' = Γ , y sin información sobre x , no puedo seguir derivando.