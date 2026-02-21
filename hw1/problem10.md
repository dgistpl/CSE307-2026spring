# Problem 10: `mirror : btree2 -> btree2`

**Homework 1 - CSE307, Spring 2026**

## Description

Consider the inductive definition of binary trees:

```
  n ∈ Z        t             t           t1    t2
  -----     -------       -------      -----------
    n       (t, nil)      (nil, t)      (t1, t2)
```

which can be defined in OCaml as follows:

```ocaml
type btree2 =
  | Leaf of int
  | Left of btree2
  | Right of btree2
  | LeftRight of btree2 * btree2
```

For example, binary tree `((1, 2), nil)` is represented by

```ocaml
Left (LeftRight (Leaf 1, Leaf 2))
```

Write a function that exchanges the left and right subtrees all the way down. For example, mirroring the tree `((1, 2), nil)` produces `(nil, (2, 1))`; that is,

```
mirror : btree2 -> btree2
```

## Examples

```ocaml
mirror (Left (LeftRight (Leaf 1, Leaf 2)))
= Right (LeftRight (Leaf 2, Leaf 1))
```
