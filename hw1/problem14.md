# Problem 14: `calculator : exp14 -> int`

**Homework 1 - CSE307, Spring 2026**

## Description

Consider the following expressions:

```ocaml
type exp14 =
  | X
  | INT of int
  | ADD of exp14 * exp14
  | SUB of exp14 * exp14
  | MUL of exp14 * exp14
  | DIV of exp14 * exp14
  | SIGMA of exp14 * exp14 * exp14
```

Implement a calculator for the expressions:

```
calculator : exp14 -> int
```

`SIGMA(e1, e2, e3)` computes the summation from `x = e1` to `e2` of `e3`, i.e., `sum_{x=e1}^{e2} e3`.

## Examples

For instance, the summation

```
sum_{x=1}^{10} (x * x - 1)
```

is represented by

```ocaml
SIGMA(INT 1, INT 10, SUB(MUL(X, X), INT 1))
```

and evaluating it should give 375.

```ocaml
calculator (SIGMA(INT 1, INT 10, SUB(MUL(X, X), INT 1))) = 375
```
