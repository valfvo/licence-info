(* TP3 - Objets avancés *)

(* ********** Exercice 1 ********** *)

(* ***** Q1 ***** *)

class min (init : int) =
object (self)
  val x = init
  method get = x
  method min y = if self#get < y then self#get else y
end;;

class min_max (init : int) =
object (self)
  inherit min init
  method max y = if self#min y = y then self#get else y
end;;

class other =
object
  method get = 1
  method min n = n - 1
  method max n = n + 1
end;;

class ['a] cell (init : 'a) =
object
  val mutable cont = init
  method get = cont
  method set n = cont <- n
end;;

let natural (o: min) = o#min(0) = 0;;
(* type: min -> bool *)

let negative (o: #min) = o#min(0) = o#get;;
(* type: #min -> bool *)

let positive o = o#get > 0;;
(* type: int -> bool *)

let m = new min 1;;
let mm = new min_max 2;;
let o = new other;;
let c = new cell 1;;

(* ***** Q2 ***** *)

natural m;;    (* return true *)
(* natural mm;;   (* error: mm is not of type min but min_max *) *)
(* natural o;;    (* error: o is not of type min but other *) *)
natural (o :> min);;  (* return false *)
(* natural c;;    (* error *) *)
negative m;;   (* return false *)
negative mm;;  (* return false *)
negative o;;   (* return false *)
(* negative c;;   (* error *) *)
positive m;;   (* return true *)
positive mm;;  (* return true *)
positive o;;   (* return true *)
positive c;;   (* return true *)

(* ********** Exercice 2 ********** *)

(* ***** Q1 ***** *)

class virtual ['a] add_magma =
object
  method virtual add : 'a -> 'a -> 'a
end;;

class virtual ['a] mul_magma =
object
  method virtual mul : 'a -> 'a -> 'a
end;;

(* ***** Q2 ***** *)

class virtual ['a] add_monoid =
object
  inherit ['a] add_magma
  method virtual add_identity : 'a
end;;

class virtual ['a] mul_monoid =
object
  inherit ['a] mul_magma
  method virtual mul_identity : 'a
end;;

(* ***** Q3 ***** *)

class virtual ['a] add_group =
object
  inherit ['a] add_monoid
  method virtual add_inverse : 'a -> 'a
end;;

(* ***** Q4 ***** *)

class virtual ['a] ring =
object
  inherit ['a] add_group
  inherit ['a] mul_monoid
end;;

(* ***** Q5 ***** *)

class int_ring =
object
  inherit [int] ring
  method add x y = x + y
  method add_identity = 0
  method add_inverse x = -x
  method mul x y = x * y
  method mul_identity = 1
end;;

(* ***** Q6 ***** *)

class ['a, 'b] polynomial (p : ('a * int) list) (r : 'b) =
object (self)
  constraint 'b = 'a ring
  method private eval_monomial (c, p) x =
    if p = 0 then c
    else r#mul x (self#eval_monomial (c, (p - 1)) x)
  method eval x =
    List.fold_left (fun s m -> r#add s (self#eval_monomial m x)) r#add_identity p
end;;

(* ***** Q7 ***** *)

class int_polynomial (p : (int * int) list) =
object
  inherit [int, int_ring] polynomial p (new int_ring)
end;;

(* ***** Q8 ***** *)

let p = new int_polynomial [(1, 2); (-5, 1); (6, 0)];;
p#eval (-3);;

(* ***** Q9 ***** *)
