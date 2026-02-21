# Problem 13: `diff : aexp * string -> aexp`

**Homework 1 - CSE307, Spring 2026**

## Description

Write a function

```
diff : aexp * string -> aexp
```

that differentiates the given algebraic expression with respect to the variable given as the second argument. The algebraic expression `aexp` is defined as follows:

```ocaml
type aexp =
  | Const of int
  | Var of string
  | Power of string * int
  | Times of aexp list
  | Sum of aexp list
```

For example, `x^2 + 2x + 1` is represented by

```ocaml
Sum [Power ("x", 2); Times [Const 2; Var "x"]; Const 1]
```

and differentiating it (w.r.t. "x") gives `2x + 2`, which can be represented by

```ocaml
Sum [Times [Const 2; Var "x"]; Const 2]
```

Note that the representation of `2x + 2` in `aexp` is not unique. For instance, the following also represents `2x + 2`:

```ocaml
Sum
  [Times [Const 2; Power ("x", 1)];
   Sum
     [Times [Const 0; Var "x"];
      Times [Const 2; Sum [Times [Const 1]; Times [Var "x"; Const 0]]]];
   Const 0]
```

## Examples

```ocaml
diff (Sum [Power ("x", 2); Times [Const 2; Var "x"]; Const 1], "x")
```
should produce a representation of `2x + 2`.
