# Homework 3: B Language Interpreter

**CSE307, Spring 2026**
**Instructor: Minseok Jeon**

## Overview

In this assignment, you will design and implement an **imperative** language called **B**, which is a subset of the C programming language. B features mutable variables, while loops, records (structs), and procedures with both **call-by-value** and **call-by-reference** semantics.

## Instructions

- Edit the file `hw3.ml` in this folder.
- Implement the function `runb : exp -> value`.
- Whenever the semantics is undefined, raise the exception `UndefinedSemantics`.
- Test your solutions in `utop`:
  ```
  #use "hw3/hw3.ml";;
  ```

## Language Syntax

```
e -> unit                                         unit
   | x := e                                      assignment
   | e ; e                                       sequence
   | if e then e else e                           branch
   | while e do e                                 while loop
   | write e                                      output
   | let x := e in e                              variable binding
   | let proc f(x1, x2, ..., xn) = e in e        procedure binding
   | f(e1, e2, ..., en)                           call by value
   | f<x1, x2, ..., xn>                          call by reference
   | n                                            integer
   | true | false                                 boolean
   | {} | {x1:=e1, x2:=e2, ..., xn:=en}          record (struct)
   | e.x                                          record lookup
   | e.x := e                                     record assignment
   | x                                            identifier
   | e + e | e - e | e * e | e / e                arithmetic
   | e < e | e = e | not e                        boolean operation
```

## Semantic Domains

- **Values** (`Val`): integers, booleans, unit, records
- **Environment** (`Env`): maps identifiers to memory addresses (`Addr`) or procedure values (`Procedure`)
- **Memory** (`Mem`): maps addresses to values
- **Records** (`Record`): finite maps from identifiers to memory addresses
- Procedures are **not** first-class values (they are stored only in the environment, not in memory)

A procedure is a tuple of `(Id × Id × ... × Id) × Expression × Env` (parameter names, body, defining environment).

## Key Semantics

- **Assignment** (`x := e`): evaluates `e` to value `v`, stores `v` at the memory location of `x`, returns `v`
- **Record construction** (`{x1:=e1, ..., xn:=en}`): allocates fresh memory locations for each field, returns unit (`·`)
- **Record lookup** (`e.x`): evaluates `e` to a record, reads from memory at the record's field `x`
- **Record assignment** (`e1.x := e2`): evaluates `e1` to a record, evaluates `e2` to a value, stores the value at the record field's memory location
- **Equality** (`=`): works on integers, booleans, and unit (returns `true` if equal); returns `false` otherwise (including for records)
- **While loop** (`while e1 do e2`): when condition is false, returns unit; when true, evaluates body, then loops again
- **Call by value**: evaluates arguments to values, allocates **fresh** memory locations, binds them in the callee's (defining) environment
- **Call by reference**: passes the caller's memory locations **directly** to the callee (no new allocation)
- **Write** (`write e`): evaluates `e` to an integer `n`, prints `n`, and **returns `n`** (not unit)
- **Sequence** (`e1; e2`): evaluates both, returns the value of `e2`

## Examples

### 1. Factorial with while loop

```
let ret := 1 in
let n := 5 in
while (0 < n) do (
  ret := ret * n;
  n := n - 1
);
ret
```

**OCaml representation:**
```ocaml
LETV ("ret", NUM 1,
  LETV ("n", NUM 5,
    SEQ (
      WHILE (LESS (NUM 0, VAR "n"),
        SEQ (
          ASSIGN ("ret", MUL (VAR "ret", VAR "n")),
          ASSIGN ("n", SUB (VAR "n", NUM 1))
        )
      ),
      VAR "ret")))
```
**Result:** `Num 120`

### 2. Call by reference

```
let proc f(x1, x2) =
    x1 := 3; x2 := 3
in
let x1 := 1 in
let x2 := 1 in
f <x1, x2>;
x1 + x2
```

**OCaml representation:**
```ocaml
LETF ("f", ["x1"; "x2"],
  SEQ (
    ASSIGN ("x1", NUM 3),
    ASSIGN ("x2", NUM 3)
  ),
  LETV ("x1", NUM 1,
    LETV ("x2", NUM 1,
      SEQ (
        CALLR ("f", ["x1"; "x2"]),
        ADD (VAR "x1", VAR "x2")))))
```
**Result:** `Num 6`

### 3. Records with call by value

```
let f := {x := 10, y := 13} in
let proc swap(a, b) =
    let temp := a in
    a := b; b := temp
in
swap(f.x, f.y);
f.x
```

**OCaml representation:**
```ocaml
LETV ("f", RECORD ([("x", NUM 10); ("y", NUM 13)]),
  LETF ("swap", ["a"; "b"],
    LETV ("temp", VAR "a",
      SEQ (
        ASSIGN ("a", VAR "b"),
        ASSIGN ("b", VAR "temp"))),
    SEQ (
      CALLV ("swap", [FIELD (VAR "f", "x"); FIELD (VAR "f", "y")]),
      FIELD (VAR "f", "x")
    )
  )
)
```
**Result:** `Num 10` (call-by-value does not modify the record fields)
