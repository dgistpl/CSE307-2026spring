# Problem 12: `eval : formula -> bool`

**Homework 1 - CSE307, Spring 2026**

## Description

Consider the following propositional formula:

```ocaml
type formula =
  | True
  | False
  | Not of formula
  | AndAlso of formula * formula
  | OrElse of formula * formula
  | Imply of formula * formula
  | Equal of exp * exp
and exp =
  | Num of int
  | Plus of exp * exp
  | Minus of exp * exp
```

Write the function

```
eval : formula -> bool
```

that computes the truth value of a given formula.

## Examples

```ocaml
eval (Imply (Imply (True, False), True)) = true
eval (Equal (Num 1, Plus (Num 1, Num 2))) = false
```
