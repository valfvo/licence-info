(* TP1 - Le noyau fonctionnel *)

(* ********** Exercice 1 ********** *)

(* ***** Q1 ***** *)
let rec reverse_list = function
  | [] -> []
  | x :: l -> (reverse_list l) @ [x];;

reverse_list [1; 2; 3; 4; 5];;

(* ***** Q2 ***** *)
let rec count x = function
  | [] -> 0
  | y :: l ->
     if y = x then 1 + count x l
     else count x l;;

count 1 [1; 2; 1; 3; 4; 1];;

(* ***** Q3 ***** *)

let rec is_sorted = function
  | [] -> true
  | [_] -> true
  | x :: y :: l -> x <= y && (is_sorted (y :: l));;

is_sorted [1; 2; 5; 3;];;
is_sorted [1; 2; 3];;

(* ***** Q4 ***** *)

let rec sorted_insert x = function
  | [] -> [x]
  | y :: l ->
     if x <= y then x :: y :: l
     else y :: (sorted_insert x l);;

sorted_insert 4 [1; 2; 3; 5];;

(* ***** Q5 ***** *)

let rec sort_list = function
  | [] -> []
  | x :: l -> sorted_insert x (sort_list l);;

sort_list [];;
sort_list [1];;
sort_list [2; 5; 6; 1; 3; 4; 2];;

(* ********** Exercice 2 ********** *)

(* ***** Q1 ***** *)

type formula =
  | Top
  | Bot
  | Var of string
  | Not of formula
  | And of formula * formula
  | Or of formula * formula
  | Imp of formula * formula
  | Equ of formula * formula;;

(* ***** Q2 ***** *)

let rec string_of_formula = function
  | Top -> "⊤"
  | Bot -> "⊥"
  | Var v -> v
  | Not f -> "¬" ^ (string_of_formula f)
  | And (f1, f2) -> "(" ^ (string_of_formula f1) ^ " ∧ " ^ (string_of_formula f2) ^ ")"
  | Or (f1, f2) -> "(" ^ (string_of_formula f1) ^ " ∨ " ^ (string_of_formula f2) ^ ")"
  | Imp (f1, f2) -> "(" ^ (string_of_formula f1) ^ " ⇒ " ^ (string_of_formula f2) ^ ")"
  | Equ (f1, f2) -> "(" ^ (string_of_formula f1) ^ " ⇔ " ^ (string_of_formula f2) ^ ")";;

let f = Imp (And (Var "A", Var "B"), Or (Not (Var "C"), Bot));;
string_of_formula f;;

(* ***** Q3 ***** *)

let simplify_and = function
  | (f, Top) | (Top, f) -> f
  | (_, Bot) | (Bot, _) -> Bot
  | (f, g) -> And (f, g)
     (* failwith ("Can not simplify And in : " ^ string_of_formula (And (f, g)));; *)

let simplify_or = function
  | (_, Top) | (Top, _) -> Top
  | (f, Bot) | (Bot, f) -> f
  | (f, g) -> Or (f, g)
     (* failwith ("Can not simplify Or in : " ^ string_of_formula (Or (f, g)));; *)

let simplify_imp = function
  | (_, Top) | (Bot, _) -> Top
  | (f, Bot) -> Not f
  | (Top, f) -> f
  | (f, g) -> Imp (f, g)
     (* failwith ("Can not simplify Imp in : " ^ string_of_formula (Imp (f, g)));; *)

let simplify_equ = function
  | (f, Top) | (Top, f) -> f
  | (f, Bot) | (Bot, f) -> Not f
  | (f, g) -> Equ (f, g)
     (* failwith ("Can not simplify Equ in : " ^ string_of_formula (Equ (f, g)));; *)

let rec simplify_formula = function
  | And (f, g) ->
     simplify_and (simplify_formula f, simplify_formula g)
  | Or (f, g) ->
     simplify_or (simplify_formula f, simplify_formula g)
  | Imp (f, g) ->
     simplify_imp (simplify_formula f, simplify_formula g)
  | Equ (f, g) ->
     simplify_equ (simplify_formula f, simplify_formula g)
  | f -> f;;

let f = And (Bot, Or (Var "A", Var "B"));;
let g = simplify_formula f;;

string_of_formula f;;
string_of_formula g;;

let h = Equ (Bot, Imp (Top, Var "C"));;
let i = simplify_formula h;;

string_of_formula h;;
string_of_formula i;;

(* ***** Q4 ***** *)

(* l : assigment of variables *)
let rec eval_formula l = function
  | Top -> true
  | Bot -> false
  | Var x ->
     (try List.assoc x l
      with Not_found -> failwith (x ^ " has no associated value."))
  | Not f -> not (eval_formula l f)
  | And (f, g) -> eval_formula l f && eval_formula l g
  | Or (f, g) -> eval_formula l f || eval_formula l g
  | Imp (f, g) -> not (eval_formula l f) || eval_formula l g
  | Equ (f, g) -> eval_formula l f = eval_formula l g;;

let f = Imp (Var "A", And (Var "A", Var "B"));;
let l = [("A", true); ("B", false)];;

string_of_formula f;;
eval_formula l f;;

(* ***** Q5 ***** *)

let string_of_assigment_aux s = function
  | (x, v) ->
     if s = "" then
       "(\"" ^ x ^ "\", " ^ string_of_bool v ^ ")"
     else
       s ^ "; (\"" ^ x ^ "\", " ^ string_of_bool v ^ ")";;

let string_of_assigment l =
    "[" ^ (List.fold_left string_of_assigment_aux "" l) ^ "]";;

(* l : assigment *)
let rec get_vars_aux l = function
  | Var x -> if not (List.mem x l) then l @ [x] else l
  | Not f -> get_vars_aux l f
  | And (f, g) | Or (f, g) | Imp (f, g) | Equ (f, g) ->
     get_vars_aux (get_vars_aux l f) g
  | _ -> l;;

let get_vars f = get_vars_aux [] f;;

(* f : formula, l : assigment, v : variables *)
let rec is_tautological_aux f l = function
    (* | [] -> print_endline (string_of_assigment l); eval_formula l f *)
    | [] -> eval_formula l f
    | x :: v ->
       is_tautological_aux f (l @ [(x, true)]) v
       && is_tautological_aux f (l @ [(x, false)]) v

let is_tautological f = is_tautological_aux f [] (get_vars f) ;;

let f = Imp (Var "A", Imp (Var "B", Var "A"));;
string_of_formula f;;
is_tautological f;;

let g = Imp (Var "A", Imp (Var "B", Var "C"));;
string_of_formula g;;
is_tautological f;;

(* ********** Exercice 3 ********** *)

(* ***** Q1 ***** *)

let sum_list l = List.fold_right (fun x y -> x + y) l 0;;
sum_list [];;
sum_list [1; 3; 5; 2];;

(* ***** Q2 ***** *)

let has_no_negative_element = List.for_all (fun x -> x >= 0);;
has_no_negative_element [];;
has_no_negative_element [1; 2; 3];;
has_no_negative_element [1; 2; 3; -4; 5];;

(* ***** Q3 ***** *)

let remove_negative_element = List.filter (fun x -> x >= 0);;
remove_negative_element [];;
remove_negative_element [1; 2; 3];;
remove_negative_element [1; 2; 3; -4; 5];;

(* ***** Q4 ***** *)

let reverse_list_two = List.fold_left (fun l x -> x :: l) [];;
reverse_list_two [];;
reverse_list_two [1; 2; 3; -4; 5; 0];;

let reverse_list_three l = List.fold_right (fun x g -> g @ [x]) l [];;
reverse_list_three [];;
reverse_list_three [1; 2; 3; -4; 5; 0];;
