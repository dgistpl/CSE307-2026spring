(* CSE307 Spring 2026 - Homework 1, Problem 10 *)
(* Name: *)
(* Student ID: *)

type btree2 =
  | Leaf of int
  | Left of btree2
  | Right of btree2
  | LeftRight of btree2 * btree2

(* mirror : btree2 -> btree2 *)
(* Exchange left and right subtrees all the way down. *)
let rec mirror (t : btree2) : btree2 =
  failwith "TODO"
