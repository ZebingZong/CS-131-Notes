Lists
======

Cons (::) examples:

- `1::2::[]`
- `[1]::[[2]]`
- `[1;2]::[[]]`
- `‘a :: ‘a list`
- Adds in front of list


Relation between ::, ; and []:

- `1::2::3::[]` = `[1; 2; 3]`
- `::` has an element on left and list on right
- `::` is right associative
- `1::2::3::[]` = `1::(2::(3::[]))`
- `1::2` is invalid. Not even a list.
- `1::2::[3; 4]` is valid and has type int list
- `[‘a; ‘a; ... ; ‘a]` = `‘a :: ‘a :: ... :: ‘a :: []`


Append (@) examples:

- `[1; 2] @ [3; 4]` = `[1; 2; 3; 4]`
- `[1; 2]::[3; 4]` is invalid
- `‘a list @ ‘a list`
- Appends lists back to back



Pattern Matching
=================

- `h;t` is invalid syntax
- `[h;t]` matches a 2 element list only
- `[h::t]`  matches a list of lists, with at least 1 element in outer list
- `h::t` matches a list with at least one element
- `h@t` is invalid syntax
- `_` matches anything
- `_::t`    matches the top-most (i.e. the first) ::
- `h::m::t` h and m are first 2 elements, t is the rest
- `(x,y)::t` first element matched to tuple directly



User Defined Types
===================

- Type names should be small case
- Constructors should start with CAP
- Constructors are not always necessary
- A new type can be defined just to shorten the name
  -- E.g. type point = float * float
- Variant types MUST have constructors
  -- E.g. type intOrString = I of int | S of string
- Without a constructor, OCaml “infers” the type in terms of base types
- Constructors can be nullary (no arguments required)
