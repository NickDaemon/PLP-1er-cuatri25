## λx: Bool → Bool. x true: (Bool → Bool) → Bool
### Derivando en el modificado:
```haskell
_________________??    _______________t-true
Γ ⊢ x:Bool → Bool       Γ ⊢ true: Bool
_______________________________________t-app
            Γ ⊢ x true: Bool
_________________________________________________t-abs
Γ ⊢ λx: Bool → Bool. x true: (Bool → Bool) → Bool

```
### Derivando en el original:
```haskell

__________________t-var _______________t-true
Γ' ⊢ x:Bool → Bool      Γ' ⊢ true: Bool
_______________________________________t-app
Γ, x:Bool → Bool ⊢ x true: Bool
_________________________________________________t-abs
Γ ⊢ λx: Bool → Bool. x true: (Bool → Bool) → Bool

Γ' = Γ, x:Bool → Bool

```
### Conclusión:
- Es derivable en el sistema original pero no es derivable en el modificado.
- Queda "trabado" en:
```haskell
_________________??
Γ ⊢ x:Bool → Bool 
```
- Como x no esta en el contexto , no puedo seguir derivando.