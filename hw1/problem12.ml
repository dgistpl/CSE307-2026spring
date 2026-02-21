(* CSE307 Spring 2026 - Homework 1, Problem 12 *)
(* Name: *)
(* Student ID: *)

type formula =
  | True
  | False
  | Not of formula
  | AndAlso of formula * formula
  | OrElse of formula * formula
  | Imply of formula * formula
  | Equal of exp * exp
and exp =
  | Num of int
  | Plus of exp * exp
  | Minus of exp * exp

(* eval : formula -> bool *)
(* Evaluate a formula to its truth value. *)
let eval (f : formula) : bool =
  failwith "TODO"
