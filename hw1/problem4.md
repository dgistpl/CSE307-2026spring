# Problem 4: `drop : 'a list -> int -> 'a list`

**Homework 1 - CSE307, Spring 2026**

## Description

Write a function

```
drop : 'a list -> int -> 'a list
```

that takes a list `l` and an integer `n` to take all but the first `n` elements of `l`.

## Examples

```ocaml
drop [1;2;3;4;5] 2 = [3; 4; 5]
drop [1;2] 3 = []
drop ["C"; "Java"; "OCaml"] 2 = ["OCaml"]
```
