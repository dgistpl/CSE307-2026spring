# Problem 6: `sigma : (int -> int) -> int -> int -> int`

**Homework 1 - CSE307, Spring 2026**

## Description

Write a higher-order function

```
sigma : (int -> int) -> int -> int -> int
```

such that `sigma f a b` computes the summation:

```
sum_{i=a}^{b} f(i)
```

## Examples

```ocaml
sigma (fun x -> x) 1 10   = 55
sigma (fun x -> x*x) 1 7  = 140
```
