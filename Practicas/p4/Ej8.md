### A:
```haskell
_________t-zero
⊢ zero: σ
________________t-succ
⊢ succ(zero) : σ

σ = Nat

```
### B:
```haskell
___________t-zero
⊢ zero: Nat
_________________t-succ
⊢ succ(zero): Nat
________________________t-isZero
⊢ isZero(succ(zero)) : σ

σ = Bool
```
### C:
```haskell
__________t-true __________t-false  ___________t-false    _________t-zero
⊢ true: Bool     ⊢ false: Bool      ⊢ false: Bool         ⊢ zero: σ
______________________________________t-if ________t-zero ______________t-succ
⊢ (if true then false else false): Bool    ⊢ zero: σ      ⊢ succ(zero): σ
___________________________________________________________________t-if
⊢ if (if true then false else false) then zero else succ(zero) : σ

σ = Nat

```