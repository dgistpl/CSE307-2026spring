(* CSE307 Spring 2026 - Homework 3: B Language Interpreter *)
(* Name: *)
(* Student ID: *)

exception UndefinedSemantics

type exp =
  | NUM of int | TRUE | FALSE | UNIT
  | VAR of id
  | ADD of exp * exp
  | SUB of exp * exp
  | MUL of exp * exp
  | DIV of exp * exp
  | EQUAL of exp * exp
  | LESS of exp * exp
  | NOT of exp
  | SEQ of exp * exp              (* sequence *)
  | IF of exp * exp * exp         (* if-then-else *)
  | WHILE of exp * exp            (* while loop *)
  | LETV of id * exp * exp        (* variable binding *)
  | LETF of id * id list * exp * exp  (* procedure binding *)
  | CALLV of id * exp list        (* call by value *)
  | CALLR of id * id list         (* call by reference *)
  | RECORD of (id * exp) list     (* record construction *)
  | FIELD of exp * id             (* access record field *)
  | ASSIGN of id * exp            (* assign to variable *)
  | ASSIGNF of exp * id * exp     (* assign to record field *)
  | WRITE of exp
and id = string

type loc = int
type value =
  | Num of int
  | Bool of bool
  | Unit
  | Record of record
and record = (id * loc) list

type memory = (loc * value) list
type env = binding list
and binding = LocBind of id * loc | ProcBind of id * proc
and proc = id list * exp * env

(* Helper: get a fresh memory location *)
let counter = ref 0
let new_loc () =
  counter := !counter + 1;
  !counter

(* Helper: lookup in environment *)
let rec lookup_loc (x : id) (env : env) : loc =
  match env with
  | [] -> raise UndefinedSemantics
  | LocBind (y, l) :: rest -> if x = y then l else lookup_loc x rest
  | ProcBind _ :: rest -> lookup_loc x rest

let rec lookup_proc (f : id) (env : env) : proc =
  match env with
  | [] -> raise UndefinedSemantics
  | ProcBind (g, p) :: rest -> if f = g then p else lookup_proc f rest
  | LocBind _ :: rest -> lookup_proc f rest

(* Helper: lookup in memory *)
let rec lookup_mem (l : loc) (mem : memory) : value =
  match mem with
  | [] -> raise UndefinedSemantics
  | (l', v) :: rest -> if l = l' then v else lookup_mem l rest

(* Helper: update memory *)
let update_mem (l : loc) (v : value) (mem : memory) : memory =
  (l, v) :: List.filter (fun (l', _) -> l <> l') mem

(* Implement the eval function *)
(* eval : env -> memory -> exp -> value * memory *)
let rec eval (env : env) (mem : memory) (e : exp) : value * memory =
  failwith "TODO"

(* Run a program *)
let runb (pgm : exp) : value =
  counter := 0;
  let (v, _) = eval [] [] pgm in
  v
