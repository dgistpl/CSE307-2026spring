(* CSE307 Spring 2026 - Homework 1, Problem 14 *)
(* Name: *)
(* Student ID: *)

type exp14 =
  | X
  | INT of int
  | ADD of exp14 * exp14
  | SUB of exp14 * exp14
  | MUL of exp14 * exp14
  | DIV of exp14 * exp14
  | SIGMA of exp14 * exp14 * exp14

(* calculator : exp14 -> int *)
(* Evaluate an expression. SIGMA(e1, e2, e3) computes sum_{x=e1}^{e2} e3. *)
let calculator (e : exp14) : int =
  failwith "TODO"
