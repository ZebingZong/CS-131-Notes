(*
 * Problems Set 2
 * ================
 * - More on user defined types
 *)



(* ===> Trees <=== *)

(* We want to implement a generic tree structure - each node could hold a value
 * of any type; and each node could have as many nodes as needed *)

(*
 * A tree node is a tuple of value and a list of nodes
 *)
type 'a tree = Node of ('a * 'a tree list);;

(*
 * An example int tree
 *)
let mytree = Node(1, [Node(2, []);
                      Node(3, [Node(4, [Node(5, [])]);
                               Node(6, []);
                               Node(7, [Node(8, []);
                                        Node(9, [Node(10, [])])])])]);;


(*
 * Mirror image of a tree
 *)
let rec reflect_tree (Node(v, children) :'a tree) :'a tree =
  Node(v, List.rev (List.map reflect_tree children))
;;

reflect_tree mytree = Node(1, [Node(3, [Node(7, [Node(9, [Node(10,[])]);
                                                 Node(8, [])]);
                                        Node(6, []);
                                        Node(4, [Node(5, [])])]);
                               Node(2, [])]);;


(*
 * Pick only left-most child of each node
 *)
let rec getLeftMost (Node(_, tl) :'a tree) :'a list =
  match tl with
    [] -> []
  | Node(v, l)::t-> v::(List.fold_left (fun p y -> p @ (getLeftMost y)) [] tl)
;;

getLeftMost mytree = [2; 4; 5; 8; 10];;
getLeftMost (reflect_tree mytree) = [3; 7; 9; 10; 5];;
