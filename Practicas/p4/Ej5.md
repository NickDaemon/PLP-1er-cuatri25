## Ejercicio 5:
- M = `If` true `Then` zero `Else` false

| Propiedad                 | Cumple                                     |
| --------------------------| -------------------------------------------
| Es bien formado           | ✅ (sintácticamente válido)                  |
| No es tipable             | ❌ porque las ramas tienen distintos tipos   |
| No tiene variables libres | ❌ fv(M) = ∅                                 |

```haskell 
                                     ___________T-Nat
                                     ⊢ zero: Nat
____________T-True ___________T-Nat  __________________T-succ
⊢ true: Bool       ⊢ zero: Nat       ⊢ succ(zero): Nat
__________________________________________(T-if)
⊢ if true then zero else succ(zero) : Nat
```