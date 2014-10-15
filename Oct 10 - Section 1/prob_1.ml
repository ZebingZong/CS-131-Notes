(*
 * Problems Set 1
 * ================
 * - Lists
 * - Tuples
 * - Pattern Matching
 *)



(*
 * Return every second element in a list
 *)
let rec everySecond (l :'a list) :'a list =
  match l with
    []           -> []
  | [_]          -> []
  | _::sec::rest -> sec::(everySecond rest)
;;

everySecond [1;2;3;5] = [2;5];;
everySecond ["a";"b";"c";"d";"e"] = ["b";"d"];;



(*
 * Return second element of every tuple
 *)
let rec secondGet (pl :('a * 'b) list) :'b list =
  match pl with
    []          -> []
  | (_,y)::tail -> y::(secondGet tail)
;;

secondGet [(1,2);(3,4);(5,6)] = [2;4;6];;
secondGet [(1,"x");(3,"y");(5,"z")] = ["x";"y";"z"];;



(*
 * Delete all occurrences of an element from a list, if it exists
 *)
let rec deleteElement (l :'a list) (e :'a) :'a list =
  match l with
    []    -> []
  | x::xs -> if x = e then deleteElement xs e
                      else x::(deleteElement xs e)
;;

deleteElement [1;2;3;1] 1 = [2;3];;
deleteElement ["z";"q";"r";"q";"p"; "q"] "q" = ["z";"r";"p"];;



(*
 * Check if a list l contains an element e
 *)
let rec contains (e :'a) (l :'a list) :bool =
  match l with
    []    -> false
  | x::xs -> if e = x then true
                      else contains e xs
;;

contains 2 [1;2;3] = true;;
contains 1 [2;3] = false;;



(*
 * Check if a list contains all elements of another list
 *)
let rec containsList (l1 :'a list) (l2: 'a list) :bool=
  match l1 with
    []    -> true
  | y::ys -> (contains y l2) && (containsList ys l2)
;;

containsList [1;2;3] [2;1;3;3;1;2] = true;;
containsList [1;3] [2;3;2;4] = false;;



(* Return a range of integers in steps *)
let rec range (from :int) (till :int) (step :int) :int list =
  if from > till then []
                 else from :: (range (from+step) till step )
;;

range 1 10 2 = [1;3;5;7;9];;
range 2 10 2 = [2;4;6;8;10];;



(*
 * Check if l1 is a prefix of l2
 *)
let rec prefixOf (l1 :'a list) (l2 :'a list) :bool =
  match l1 with
    []    -> true
  | x::xs -> match l2 with
             []    -> false
           | y::ys -> if x = y then prefixOf xs ys else false
;;


prefixOf [1;2;3] [1;2;3;4;6] = true;;
prefixOf [1;2] [3;4] = false;;



(*
 * Convert a list to indexed tuples
 *)
let indexedList (l :'a list) :(int * 'a) list =
  let rec aux idx = function
      []    -> []
    | x::xs -> (idx,x) :: ( aux (idx+1) xs )
  in aux 1 l
;;

indexedList ["a"; "b"; "c"] = [(1, "a"); (2, "b"); (3, "c")];;
