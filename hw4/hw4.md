# Homework 4: Type Checker for ML-

**CSE307, Spring 2026**
**Instructor: Minseok Jeon**

## Overview

In this assignment, you will implement a **sound type checker** for the ML- language from Homework 2. The type checker uses type inference to determine the type of a given program. If the program is well-typed, `typeof` returns its type; if ill-typed, it raises `TypeError`.

## Instructions

- Edit the file `hw4.ml` in this folder.
- Implement the function `typeof : exp -> typ`.
- When the program is ill-typed, raise the exception `TypeError`.
- Test your solutions in `utop`:
  ```
  #use "hw4/hw4.ml";;
  ```

## Language Syntax

The language is the same as ML- from Homework 2:

```
P -> E
E -> ()                                        unit
   | true | false                              booleans
   | n                                         integers
   | x                                         variables
   | E + E | E - E | E * E | E / E             arithmetic
   | E = E | E < E                             comparison
   | not E                                     negation
   | nil                                       empty list
   | E :: E                                    list cons
   | E @ E                                     list append
   | head E                                    list head
   | tail E                                    list tail
   | isnil E                                   checking empty list
   | if E then E else E                        if
   | let x = E in E                            let
   | letrec f(x) = E in E                      recursion
   | letrec f(x1) = E1 and g(x2) = E2 in E    mutual recursion
   | proc x E                                  function definition
   | E E                                       function application
   | print E                                   print
   | E;E                                       sequence
```

## Type System

Types are defined as:

```ocaml
type typ =
    TyUnit                    (* unit type *)
  | TyInt                     (* integer type *)
  | TyBool                    (* boolean type *)
  | TyFun of typ * typ        (* function type: t1 -> t2 *)
  | TyList of typ             (* list type: t list *)
  | TyVar of tyvar            (* type variable for inference *)
and tyvar = string
```

## Typing Rules Summary

- `()` has type `TyUnit`
- `true`, `false` have type `TyBool`
- `n` (integer) has type `TyInt`
- Arithmetic operations (`+`, `-`, `*`, `/`): both operands must be `TyInt`, result is `TyInt`
- Comparison (`=`): both operands must have the same type (int or bool), result is `TyBool`
- Comparison (`<`): both operands must be `TyInt`, result is `TyBool`
- `not E`: operand must be `TyBool`, result is `TyBool`
- `nil`: has type `TyList(a)` for a fresh type variable `a`
- `E1 :: E2`: if E1 has type `t` and E2 has type `t list`, result is `t list`
- `E1 @ E2`: both must be `t list`, result is `t list`
- `head E`: if E has type `t list`, result is `t`
- `tail E`: if E has type `t list`, result is `t list`
- `isnil E`: if E has type `t list`, result is `TyBool`
- `if E1 then E2 else E3`: E1 must be `TyBool`, E2 and E3 must have the same type
- `let x = E1 in E2`: type of E2 with x bound to the type of E1
- `letrec f(x) = E1 in E2`: f has type `a -> b` where a, b are fresh; E1 must have type b under x:a, f:a->b
- `proc x E`: creates a function type `a -> t` where a is fresh and E has type t under x:a
- `E1 E2` (application): E1 must have type `t1 -> t2`, E2 must have type `t1`, result is `t2`
- `print E`: any type for E, result is `TyUnit`
- `E1; E2`: result is the type of E2

## Hints

- Use **unification** to solve type constraints.
- Generate fresh type variables (e.g., `TyVar "t1"`, `TyVar "t2"`, ...) when needed.
- Apply substitutions during unification and propagate them correctly.
- The soundness of the type checker means: if `typeof` returns a type, then the program will not get stuck during evaluation (no `UndefinedSemantics` exception from HW2, except for non-termination).
