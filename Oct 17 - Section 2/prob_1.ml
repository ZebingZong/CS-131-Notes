(*
 * Problems Set 1
 * ================
 * - Lambda Functions
 * - Higher Order Functions
 * - Functions in List Module
 *)



(* We need zip, range functions from the earlier discussion *)
#use "../Oct 10 - Section 1/prob_1.ml";;



(*
 * Check if the given number is prime
 *)
let isPrime (n :int) :bool =
  let rec isPrimeHelper (k :int) (i: int) :bool =
    match k with
      1 -> false
    | 2 -> true
    | _ when i = k -> true
    | _ when (k mod i = 0) -> false
    | _ -> isPrimeHelper k (i + 1)
  in isPrimeHelper n 2
;;

isPrime 10 = false;;
isPrime 11 = true;;



(*
 * Get all prime numbers upto n
 *)
let primesGet (n :int) :int list =
  List.filter isPrime (range 1 n 1);;

primesGet 1 = [];;
primesGet 12 = [2;3;5;7;11];;



(*
 * Return the divisors of the given numbers
 *)
let divisors (l :int list) :(int * int list) list =
  List.map (fun x -> (x, List.filter (fun k -> x mod k = 0) (range 1 x 1))) l
;;

divisors [1;3] = [(1,[1]); (3,[1;3])];;
divisors [7;10;16] = [(7,[1;7]); (10,[1;2;5;10]); (16,[1;2;4;8;16])];;


(*
 * Integer sqrt - not supposed to write this, assume that it's provided
 *)
let isqrt (i :int) :int = int_of_float (sqrt (float_of_int i));;

isqrt 4 = 2;;
isqrt 89 = 9;;

(*
 * An efficient divisors function - assume that isqrt is provided
 *
 * My solution was not so elegant. The list I was producing was not sorted.
 * Thanks to the guy (I'm sorry, I don't remember the name) in my section;
 * who suggested this solution.
 *)
let divisors2 (l :int list) :(int * int list) list =
  List.map (fun x -> (x, List.fold_left (fun p e ->
                                           if x mod e = 0
                                           then e::(if e = (x/e)
                                                    then p else p@[x/e])
                                           else p)
                                        []
                                        (range (isqrt x) 1 (-1)))) l
;;

divisors2 [1;3] = [(1,[1]); (3,[1;3])];;
divisors2 [7;10;16] = [(7,[1;7]); (10,[1;2;5;10]); (16,[1;2;4;8;16])];;



(*
 * Test if a list of numbers are primes, using their divisors
 *)
let testPrimes (ilist :int list) :(int * bool) list =
  List.map (fun (x, y) -> (x, List.length y = 2 &&
                              List.hd y ==1 &&
                              List.tl y = [x]))
           (divisors ilist);;

testPrimes [1;2;9;13] = [(1, false); (2, true); (9, false); (13, true)];;



(*
 * Implement List.mapi function - which is a map that passes list elements
 * with indices to a function
 *)
let my_mapi (f :int -> 'a -> 'b) (l :'a list) :'b list =
  let rec aux (f :int -> 'a -> 'b) (idx :int) (t :'a list) :'b list =
    match t with
      [] -> []
      | x::xs -> (f idx x)::(aux f (idx+1) xs)
  in aux f 0 l
;;

my_mapi (fun i x -> i) [4;5;6;7] = List.mapi (fun i x -> i) [4;5;6;7];;
my_mapi (fun i x -> i*x) [1;2;3;4]= List.mapi (fun i x -> i*x) [1;2;3;4];;

(*
 * A single line implementation using zip and List.map
 *)
let rec my_mapi2 (f :int -> 'a -> 'b) (l : 'a list) :'b list =
  List.map (fun (a,b) -> f a b) (zip (range 0 ((List.length l) - 1) 1) l);;

my_mapi2 (fun i x -> i) [4;5;6;7] = List.mapi (fun i x -> i) [4;5;6;7];;
my_mapi2 (fun i x -> i*x) [1;2;3;4]= List.mapi (fun i x -> i*x) [1;2;3;4];;



(*
 * Implement the slice function for list - which takes a range and produces
 * the elements whose indices fall in the range
 *)
let slice (l :'a list) (from :int) (till :int) :'a list =
  List.flatten (
    List.mapi (fun i x -> if i >= from && i <= till
                          then [x]
                          else [])
              l);;

slice ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"] 2 6 = ["c";"d";"e";"f";"g"];;



(*
 * Fold is more general than map.
 *
 * Implement tail-recursive List.map using List.fold_left.
 *)

let my_map (f :'a -> 'b) (l :'a list) :'b list =
  List.fold_left (fun p e -> (f e)::p) [] (List.rev l)
;;

my_map (fun x -> 2 * x) [1;2;3;4;5] = [2;4;6;8;10];;
my_map (fun (p,q) -> q) [(1,"a");(2,"b");(3,"c");(4,"d")] = ["a";"b";"c";"d"];;
