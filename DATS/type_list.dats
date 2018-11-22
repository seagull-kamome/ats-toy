(*
 *
*)
staload "SATS/type_list.sats"
(*

// type_list_length_nat{n:int}{xs:type_list}
//  (pr:TYPE_LIST_LENGTH(xs, n)) : [0 <= n] void =
primplement
type_list_length_nat{n}{xs}(pr) =
  case+ pr of
  | TYPE_LIST_LENGTH_NIL => ()
  | TYPE_LIST_LENGTH_CONS(pr0) =>
    sif n < 0
      then type_list_length_nat(pr0)
      else let prval () = type_list_length_nat(pr0) in end

*)
