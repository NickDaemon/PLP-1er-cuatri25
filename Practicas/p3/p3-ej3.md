## 3.1
```
(T ⇒ Q) ∨ (P ⇒ C) ≡ True v False ≡ True
Es tautologia.
```
## 3.2
```
¬ ⇒ ∧ 
Queremos analizar la fórmula:

$$
(T \Rightarrow P) \lor (Q \Rightarrow C)
$$

La reescribimos usando sólo ¬ y ∨:

$$
(\neg T \lor P) \lor (\neg Q \lor C)
\equiv \neg T \lor P \lor \neg Q \lor C
$$

Vamos a probar diferentes valuaciones para ver si es una tautología, contradicción o contingencia.

---

**Caso 1:**

- T = True, P = False  
- Q = True, C = False

Evaluamos:

- \( T \Rightarrow P \equiv \text{True} \Rightarrow \text{False} \equiv \text{False} \)
- \( Q \Rightarrow C \equiv \text{True} \Rightarrow \text{False} \equiv \text{False} \)

Entonces:

$$
(T \Rightarrow P) \lor (Q \Rightarrow C) \equiv \text{False} \lor \text{False} \equiv \text{False}
$$

---

**Caso 2:**

- T = False, Q = False (P y C lo que sea)

Entonces:

- \( T \Rightarrow P \equiv \text{False} \Rightarrow \_ \equiv \text{True} \)
- \( Q \Rightarrow C \equiv \text{False} \Rightarrow \_ \equiv \text{True} \)

Entonces:

$$
(T \Rightarrow P) \lor (Q \Rightarrow C) \equiv \text{True} \lor \text{True} \equiv \text{True}
$$

---

Como hay valuaciones que la hacen **verdadera** y otras que la hacen **falsa**, concluimos que:

> **Es una contingencia.**

```
## 3.3
```
```