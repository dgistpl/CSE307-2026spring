# Problem 7: `forall : ('a -> bool) -> 'a list -> bool`

**Homework 1 - CSE307, Spring 2026**

## Description

Write a higher-order function

```
forall : ('a -> bool) -> 'a list -> bool
```

which decides if all elements of a list satisfy a predicate.

## Examples

```ocaml
forall (fun x -> x mod 2 = 0) [1;2;3] = false
forall (fun x -> x > 5) [7;8;9]       = true
```
