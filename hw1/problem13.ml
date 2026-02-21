(* CSE307 Spring 2026 - Homework 1, Problem 13 *)
(* Name: *)
(* Student ID: *)

type aexp =
  | Const of int
  | Var of string
  | Power of string * int
  | Times of aexp list
  | Sum of aexp list

(* diff : aexp * string -> aexp *)
(* Differentiate with respect to a given variable. *)
let diff (ae : aexp * string) : aexp =
  failwith "TODO"
