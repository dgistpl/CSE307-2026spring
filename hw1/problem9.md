# Problem 9: `mem : int -> btree -> bool`

**Homework 1 - CSE307, Spring 2026**

## Description

Binary trees can be defined as follows:

```ocaml
type btree =
    Empty
  | Node of int * btree * btree
```

For example, the following `t1` and `t2`

```ocaml
let t1 = Node (1, Empty, Empty)
let t2 = Node (1, Node (2, Empty, Empty), Node (3, Empty, Empty))
```

are binary trees. Write the function

```
mem : int -> btree -> bool
```

that checks whether a given integer is in the tree or not.

## Examples

```ocaml
mem 1 t1 = true
mem 4 t2 = false
```
