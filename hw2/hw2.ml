(* CSE307 Spring 2026 - Homework 2: ML- Interpreter *)
(* Name: *)
(* Student ID: *)

exception UndefinedSemantics

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

type value =
  | Unit
  | Int of int
  | Bool of bool
  | List of value list
  | Procedure of var * exp * env
  | RecProcedure of var * var * exp * env
  | MRecProcedure of var * var * exp *
                     var * var * exp * env
and env = (var * value) list

let rec string_of_value (v : value) : string =
  match v with
  | Unit -> "()"
  | Int n -> string_of_int n
  | Bool b -> string_of_bool b
  | List lst ->
    "[" ^ (String.concat "; " (List.map string_of_value lst)) ^ "]"
  | Procedure _ -> "<procedure>"
  | RecProcedure _ -> "<rec-procedure>"
  | MRecProcedure _ -> "<mrec-procedure>"

let lookup (x : var) (env : env) : value =
  try List.assoc x env
  with Not_found -> raise UndefinedSemantics

let extend (x : var) (v : value) (env : env) : env =
  (x, v) :: env

(* Implement the eval function *)
let rec eval (env : env) (e : exp) : value =
  failwith "TODO"

(* Run a program *)
let runml (pgm : program) : value =
  eval [] pgm
