# Problem 11: `natadd : nat -> nat -> nat` and `natmul : nat -> nat -> nat`

**Homework 1 - CSE307, Spring 2026**

## Description

Natural numbers are defined inductively:

```
  ---        n
   0       -----
           n + 1
```

In OCaml, the inductive definition can be defined by the following data type:

```ocaml
type nat = ZERO | SUCC of nat
```

For instance, `SUCC ZERO` denotes 1 and `SUCC (SUCC ZERO)` denotes 2. Write two functions that add and multiply natural numbers:

```
natadd : nat -> nat -> nat
natmul : nat -> nat -> nat
```

## Examples

```ocaml
# let two = SUCC (SUCC ZERO);;
val two : nat = SUCC (SUCC ZERO)
# let three = SUCC (SUCC (SUCC ZERO));;
val three : nat = SUCC (SUCC (SUCC ZERO))
# natmul two three;;
- : nat = SUCC (SUCC (SUCC (SUCC (SUCC (SUCC ZERO)))))
# natadd two three;;
- : nat = SUCC (SUCC (SUCC (SUCC (SUCC ZERO))))
```
