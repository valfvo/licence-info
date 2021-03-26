(* TP2 - Le noyau fonctionnel *)

(* ********** Exercice 1 ********** *)

(* ***** Q1 ***** *)

(* ********** Exercice 2 ********** *)

(* ***** Q1 ***** *)

class account b =
object (self)
  val mutable balance = 0.0
  method get = balance
  method deposit a = balance <- balance +. a
  method withdraw a = balance <- balance -. a
  method print = print_float balance; print_newline()
  initializer self#deposit b
end;;

class bank =
object
  val mutable accounts = ([] : account list)
  method add a = accounts <- accounts @ [a]
  method balance = List.fold_left (fun s a -> s +. a#get) 0.0 accounts
  method print = List.iter (fun a -> a#print) accounts
  method fees = List.iter (fun a -> a#withdraw (a#get *. 0.05)) accounts
end;;

(* ***** Q2 ***** *)

class ['a] collection =
object
  val mutable l = []
  method add (e  : 'a ) = l <- l @ [e]
end;;

class bank_two =
object
  inherit [account] collection
  method balance = List.fold_left (fun s a -> s +. a#get) 0.0 l
  method print = List.iter (fun a -> a#print) l
  method fees = List.iter (fun a -> a#withdraw (a#get *. 0.05)) l
end;;

(* ********** Exercice 3 ********** *)

(* ***** Q1 ***** *)

(* class cte (name : string) =
object
  method eval (l : (string * float) list) =
    (try List.assoc name l
     with Not_found -> failwith (name ^ " has no associated value."))
  method to_string = name
end;; *)

class cte a =
object
  method eval = a
  method to_string = string_of_int a
end;;

class inv (a : inv) =
object
  method eval = - a#eval
  method to_string = "-" ^ a#to_string
end;;

class add (a : add) (b : add) =
object
  method eval = a#eval + b#eval
  method to_string = "(" ^ a#to_string ^ " + " ^ b#to_string ^ ")"
end;;

class sub (a : sub) (b : sub) =
object
  method eval = a#eval - b#eval
  method to_string = "(" ^ a#to_string ^ " - " ^ b#to_string ^ ")"
end;;

class mul (a : mul) (b : mul) =
object
  method eval = a#eval * b#eval
  method to_string = "(" ^ a#to_string ^ " * " ^ b#to_string ^ ")"
end;;

class div (a : div) (b : div) =
object
  method eval = a#eval * b#eval
  method to_string = "(" ^ a#to_string ^ " / " ^ b#to_string ^ ")"
end;;

(* ***** Q2 ***** *)

(* Les types sont équivalents. Il n'est pas nécessaire de faire une
 * super classe de type expr *)

(* ********** Exercice 4 ********** *)
