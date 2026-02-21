(* CSE307 Spring 2026 - Homework 4: Type Checker for ML- *)
(* Name: *)
(* Student ID: *)

exception TypeError

type program = exp
and exp =
  | UNIT
  | TRUE
  | FALSE
  | CONST of int
  | VAR of var
  | ADD of exp * exp
  | SUB of exp * exp
  | MUL of exp * exp
  | DIV of exp * exp
  | EQUAL of exp * exp
  | LESS of exp * exp
  | NOT of exp
  | NIL
  | CONS of exp * exp
  | APPEND of exp * exp
  | HEAD of exp
  | TAIL of exp
  | ISNIL of exp
  | IF of exp * exp * exp
  | LET of var * exp * exp
  | LETREC of var * var * exp * exp
  | LETMREC of (var * var * exp) * (var * var * exp) * exp
  | PROC of var * exp
  | CALL of exp * exp
  | PRINT of exp
  | SEQ of exp * exp
and var = string

type typ =
    TyUnit
  | TyInt
  | TyBool
  | TyFun of typ * typ
  | TyList of typ
  | TyVar of tyvar
and tyvar = string

(* Type environment *)
type tyenv = (var * typ) list

(* Substitution: mapping from type variables to types *)
type subst = (tyvar * typ) list

(* Fresh type variable generation *)
let tyvar_counter = ref 0
let fresh_tyvar () : typ =
  tyvar_counter := !tyvar_counter + 1;
  TyVar ("t" ^ string_of_int !tyvar_counter)

(* Apply a substitution to a type *)
let rec apply_subst (s : subst) (t : typ) : typ =
  failwith "TODO"

(* Compose two substitutions *)
let compose_subst (s1 : subst) (s2 : subst) : subst =
  failwith "TODO"

(* Occurs check: does tyvar occur in typ? *)
let rec occurs (tv : tyvar) (t : typ) : bool =
  failwith "TODO"

(* Unify two types, returning a substitution *)
let rec unify (t1 : typ) (t2 : typ) : subst =
  failwith "TODO"

(* Type inference *)
(* Returns: (substitution, inferred type) *)
let rec infer (env : tyenv) (e : exp) : subst * typ =
  failwith "TODO"

(* Top-level type checker *)
let typeof (pgm : program) : typ =
  tyvar_counter := 0;
  let (s, t) = infer [] pgm in
  apply_subst s t
