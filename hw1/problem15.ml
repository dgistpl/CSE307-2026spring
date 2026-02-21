(* CSE307 Spring 2026 - Homework 1, Problem 15 *)
(* Name: *)
(* Student ID: *)

type exp15 =
  | V of var15
  | P of var15 * exp15
  | C of exp15 * exp15
and var15 = string

(* check : exp15 -> bool *)
(* Check if a program is well-formed (no free variables). *)
let check (e : exp15) : bool =
  failwith "TODO"
