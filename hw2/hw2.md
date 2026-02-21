# Homework 2: ML- Interpreter

**CSE307, Spring 2026**
**Instructor: Minseok Jeon**

## Overview

In this assignment, you will design and implement a programming language called **ML-** (ML minus). ML- is a small yet Turing-complete functional language that supports built-in lists and (mutually) recursive procedures.

## Instructions

- Edit the file `hw2.ml` in this folder.
- Implement the function `runml : program -> value`.
- Whenever the semantics is undefined, raise the exception `UndefinedSemantics`.
- Test your solutions in `utop`:
  ```
  #use "hw2/hw2.ml";;
  ```

## Language Syntax

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

## Values

The set of values includes:
- **Unit** (`·`)
- **Integers** (`Z`)
- **Booleans** (`Bool`)
- **Lists** (`List`) - ordered sequences of values
- **Procedures** (`Procedure = Var × E × Env`)
- **Recursive Procedures** (`RecProcedure = Var × Var × E × Env`)
- **Mutually Recursive Procedures** (`MRecProcedure = (Var × Var × E) × (Var × Var × E) × Env`)

Environments map program variables to values: `Env = Var -> Val`

## Semantics Highlights

- Arithmetic operations are defined only on integers.
- Division by zero is undefined.
- Equality (`=`) works on integers and booleans only; it is undefined for lists and functions.
- The `<` operator works only on integers.
- `not` works only on booleans.
- Lists: `nil` evaluates to the empty list `[]`. `E1 :: E2` prepends a value to a list. `E1 @ E2` concatenates two lists.
- `head` and `tail` are undefined on empty lists.
- `isnil` returns `true` on empty lists, `false` on non-empty lists.
- `print E` prints the value of E and produces a unit value.
- `E1; E2` evaluates both but returns only the value of E2.
- ML- uses **static (lexical) scoping**.

## Examples

### 1. Lexical scoping

```
let x = 1
in let f = proc (y) (x + y)
   in let x = 2
      in let g = proc (y) (x + y)
         in (f 1) + (g 1)
```

**OCaml representation:**
```ocaml
LET ("x", CONST 1,
  LET ("f", PROC ("y", ADD (VAR "x", VAR "y")),
    LET ("x", CONST 2,
      LET ("g", PROC ("y", ADD (VAR "x", VAR "y")),
        ADD (CALL (VAR "f", CONST 1), CALL (VAR "g", CONST 1))))))
```
**Result:** `Int 5`

### 2. Recursion

```
letrec double(x) = if (x = 0) then 0 else (double (x-1)) + 2
in (double 6)
```

**OCaml representation:**
```ocaml
LETREC ("double", "x",
  IF (EQUAL (VAR "x", CONST 0), CONST 0,
    ADD (CALL (VAR "double", SUB (VAR "x", CONST 1)), CONST 2)),
  CALL (VAR "double", CONST 6))
```
**Result:** `Int 12`

### 3. Mutual recursion

```
letrec even(x) = if (x = 0) then true else odd(x-1)
       odd(x) = if (x = 0) then false else even(x-1)
in (odd 13)
```

**OCaml representation:**
```ocaml
LETMREC
  (("even", "x",
    IF (EQUAL (VAR "x", CONST 0), TRUE,
      CALL (VAR "odd", SUB (VAR "x", CONST 1)))),
   ("odd", "x",
    IF (EQUAL (VAR "x", CONST 0), FALSE,
      CALL (VAR "even", SUB (VAR "x", CONST 1)))),
   CALL (VAR "odd", CONST 13))
```
**Result:** `Bool true`

### 4. Factorial with print

```
letrec factorial(x) = if (x = 0) then 1 else factorial(x-1) * x
in letrec loop(n) = if (n = 0) then () else (print (factorial n); loop (n-1))
in (loop 10)
```

**OCaml representation:**
```ocaml
LETREC ("factorial", "x",
  IF (EQUAL (VAR "x", CONST 0), CONST 1,
    MUL (CALL (VAR "factorial", SUB (VAR "x", CONST 1)), VAR "x")),
  LETREC ("loop", "n",
    IF (EQUAL (VAR "n", CONST 0), UNIT,
      SEQ (PRINT (CALL (VAR "factorial", VAR "n")),
        CALL (VAR "loop", SUB (VAR "n", CONST 1)))),
    CALL (VAR "loop", CONST 10)))
```
**Result:** `Unit` (after printing 3628800, 362880, 40320, 5040, 720, 120, 24, 6, 2, 1)

### 5. List construction

```
letrec range(n) = if (n = 1) then (1 :: nil) else n :: (range (n-1))
in (range 10)
```

**OCaml representation:**
```ocaml
LETREC ("range", "n",
  IF (EQUAL (VAR "n", CONST 1), CONS (CONST 1, NIL),
    CONS (VAR "n", CALL (VAR "range", SUB (VAR "n", CONST 1)))),
  CALL (VAR "range", CONST 10))
```
**Result:** `List [Int 10; Int 9; Int 8; Int 7; Int 6; Int 5; Int 4; Int 3; Int 2; Int 1]`

### 6. List reversal

```
letrec reverse(l) = if (isnil l) then nil
                     else (reverse (tail l)) @ ((head l) :: nil)
in (reverse (1 :: 2 :: 3 :: nil))
```

**OCaml representation:**
```ocaml
LETREC ("reverse", "l",
  IF (ISNIL (VAR "l"), NIL,
    APPEND (CALL (VAR "reverse", TAIL (VAR "l")), CONS (HEAD (VAR "l"), NIL))),
  CALL (VAR "reverse", CONS (CONST 1, CONS (CONST 2, CONS (CONST 3, NIL)))))
```
**Result:** `List [Int 3; Int 2; Int 1]`

### 7. Z-combinator (fixed-point combinator)

An interesting fact in programming languages is that any recursive function can be defined in terms of non-recursive functions (i.e., `letrec` is syntactic sugar in ML-). Consider the following function:

```
let fix = proc (f) ((proc (x) f (proc (y) ((x x) y)))
                     (proc (x) f (proc (y) ((x x) y))))
```

which is called the fixed-point combinator (or Z-combinator). Note that `fix` is a non-recursive function. Any recursive function definition of the form `letrec f(x) = <body of f> in ...` can be defined as `let f = fix (proc (f) (proc (x) (<body of f>))) in ...`.

For example, the factorial program:
```
let fix = proc (f) ((proc (x) f (proc (y) ((x x) y)))
                     (proc (x) f (proc (y) ((x x) y))))
in let f = fix (proc (f) (proc (x) (if (x = 0) then 1 else f(x-1) * x)))
in (f 10)
```

**OCaml representation:**
```ocaml
LET ("fix",
  PROC ("f",
    CALL
      (PROC ("x",
        CALL (VAR "f", PROC ("y", CALL (CALL (VAR "x", VAR "x"), VAR "y")))),
       PROC ("x",
        CALL (VAR "f", PROC ("y", CALL (CALL (VAR "x", VAR "x"), VAR "y")))))),
  LET ("f",
    CALL (VAR "fix",
      PROC ("f",
        PROC ("x",
          IF (EQUAL (VAR "x", CONST 0), CONST 1,
            MUL (CALL (VAR "f", SUB (VAR "x", CONST 1)), VAR "x"))))),
    CALL (VAR "f", CONST 10)))
```
**Result:** `Int 3628800`

Similarly, the `range` function using fix:
```
let fix = proc (f) ((proc (x) f (proc (y) ((x x) y)))
                     (proc (x) f (proc (y) ((x x) y))))
in let f = fix (proc (range)
                  (proc (n)
                    (if (n = 1) then (1 :: nil)
                     else n :: (range (n-1)))))
   in (f 10)
```

**OCaml representation:**
```ocaml
LET ("fix",
  PROC ("f",
    CALL
      (PROC ("x",
        CALL (VAR "f", PROC ("y", CALL (CALL (VAR "x", VAR "x"), VAR "y")))),
       PROC ("x",
        CALL (VAR "f", PROC ("y", CALL (CALL (VAR "x", VAR "x"), VAR "y")))))),
  LET ("f",
    CALL (VAR "fix",
      PROC ("range",
        PROC ("n",
          IF (EQUAL (VAR "n", CONST 1), CONS (CONST 1, NIL),
            CONS (VAR "n", CALL (VAR "range", SUB (VAR "n", CONST 1))))))),
    CALL (VAR "f", CONST 10)))
```
**Result:** `List [Int 10; Int 9; Int 8; Int 7; Int 6; Int 5; Int 4; Int 3; Int 2; Int 1]`
