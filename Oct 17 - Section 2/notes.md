Type Annotation
================
- Better errors: Instead of “inferred” types, you see “expected” types
- Easier programming: the arguments and return values are annotated, so when
  calling these functions, it’s easy to look up the types in signature!

```ocaml
type point = float * float;;

let x_annot ((x1,y1) :point) :float = x1;;
let x (x1,y1) = x1;; (* x in this example can return any type, but it was
                        intended to return type float in the original design*)

# x 3.0;;
Error: This expression has type float but
       an expression was expected of type 'a * 'b

# x_annot 3.0;;
Error: This expression has type float but
       an expression was expected of type point = float * float


# x ("a", 3);;
- : string = "a"

# x_annot ("a", 3);;
Error: This expression has type string but
       an expression was expected of type float

```



List Module
============

`fold_left` vs `fold_right`:

- `fold_left` is tail-recursive. Elements are folded from left to right, so
   no calls are blocked.
- `fold_right` is not tail-recursive. _folding_ on previous elements is blocked
   till all subsequent elements have been _folded_
- `fold_left` is typically faster than `fold_right`

Consider a tail-recursive `range` function like:

```ocaml
let range i j =
  let rec aux n acc =
    if n < i then acc else aux (n-1) (n :: acc)
  in aux j [];;
```

Now, if we try:

```ocaml
# List.fold_left (+) 0 (range 1 10000000);;
- : int = 50000005000000

# List.fold_right (+) (range 1 10000000) 0;;
Stack overflow during evaluation (looping recursion?).
```

- The order or arguments for the folding function also differs. `fold_left`
  takes the previous value first and then list element. But `fold_right` takes
  the list element first and then the previous value

```ocaml
# List.fold_left (-) 0 [1;2;3;4];;
- : int = -10

# List.fold_right (-) [1;2;3;4] 0;;
- : int = -2
```
