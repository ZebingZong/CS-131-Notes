(*
 * Problems Set 2
 * ================
 * - User-Defined Data Types
 * - Constructors for Variants
 * - Pattern Matching on Constructors
 *)



(* ===> Shapes <=== *)

(* point is defined just to shorten syntax. *)
type point = float * float;;

(* shape is a variant type - either a Rectangle or a Circle *)
type shape =
    Rect of point * point      (* left-top and right-bottom corners *)
  | Circle of point * float;;  (* point is the center, float is radius *)

(* Calculate the area of a shape *)
let area (s: shape) :float =
  match s with
    Rect((x1,y1), (x2,y2)) -> let area = (x1 -. x2) *. (y1 -. y2) in
                                if area < 0.0 then -area else area
  | Circle((x1,y1), r)     -> let PI = 3.1415 in
                                PI *. r *. r

(* Calculate the perimeter of a shape *)
let perimeter (s: shape) :float =
  match s with
    Rect((x1,y1), (x2,y2)) ->
      let dx = (if x1 > x2 then x1 -. x2 else x2 -. x1) in
        let dy = (if y1 > y2 then y1 -. y2 else y2 -. y1) in
          2.0 *. (dx +. dy)
  | Circle((x1,y1), r)     ->
      let PI = 3.1415 in
        2.0 *. PI *. r



(* ===> Peano Arithmetic <=== *)

(* In Peano Arithmetic, we have 2 symbols - Zero and Succ which we use to
 * represent all numbers. Succ a constructor representing the successor
 * relation. So, Succ(Zero) is the peano equivalent of decimal 1. Similarly
 * Succ(Succ(Succ(Zero))) is equivalent to 3 and so on. *)

(* A Peano number can either be Zero or Succ of another Peano number *)
type peano = Zero | Succ of peano

(* Convert a Peano number to equivalent decimal number *)
let rec pToI (p: peano) :int =
  match p with
    Zero    -> 0
  | Succ(q) -> 1 + (pToI q)

(* Convert a Peano number to equivalent decimal number *)
let rec iToP (i: int) :peano =
  if i = 0 then Zero
           else Succ(iToP(i-1))

(* Add 2 peano numbers and produce their sum as a peano number *)
let rec add ((p1, p2) :peano * peano) :peano =
  match p1 with
    Zero    -> p2
  | Succ(q) -> add (q, Succ(p2))

(* Multiply 2 peano numbers and produce their sum as a peano number *)
let rec multiply ((p1, p2) :peano * peano) :peano =
  match p1 with
    Zero    -> Zero
  | Succ(q) -> add (p2, multiply (q, p2))
