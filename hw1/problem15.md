# Problem 15: `check : exp15 -> bool`

**Homework 1 - CSE307, Spring 2026**

## Description

Consider the following language:

```ocaml
type exp15 =
  | V of var
  | P of var * exp15
  | C of exp15 * exp15
and var = string
```

In this language, a program is simply a variable, a procedure, or a procedure call. Write a checker function

```
check : exp15 -> bool
```

that checks if a given program is well-formed. A program is said to be *well-formed* if and only if the program does not contain free variables; i.e., every variable name is bound by some procedure that encompasses the variable.

## Examples (well-formed)

```ocaml
check (P ("a", V "a"))                              = true
check (P ("a", P ("a", V "a")))                     = true
check (P ("a", P ("b", C (V "a", V "b"))))          = true
check (P ("a", C (V "a", P ("b", V "a"))))          = true
```

## Examples (ill-formed)

```ocaml
check (P ("a", V "b"))                              = false
check (P ("a", C (V "a", P ("b", V "c"))))          = false
check (P ("a", P ("b", C (V "a", V "c"))))          = false
```
