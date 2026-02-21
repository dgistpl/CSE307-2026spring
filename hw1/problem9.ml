(* CSE307 Spring 2026 - Homework 1, Problem 9 *)
(* Name: *)
(* Student ID: *)

type btree =
  | Empty
  | Node of int * btree * btree

(* mem : int -> btree -> bool *)
(* Check whether a given integer is in the tree. *)
let rec mem (n : int) (t : btree) : bool =
  failwith "TODO"
