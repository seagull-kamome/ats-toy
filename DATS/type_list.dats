(*
 *
*)
staload "SATS/type_list.sats"

(*
primplement
type_list_length_nat{n:int}{xs:type_list}
  (pr:TYPE_LIST_LENGTH(xs, n)) : [0 <= n] void =
  case+ pr of
  | TYPE_LIST_LENGTH_NIL => ()
  | TYPE_LIST_LENGTH_CONS(pr0) => type_list_length_nat(pr0)
*)

