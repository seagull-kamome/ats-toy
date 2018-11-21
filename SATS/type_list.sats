(*
 *
 *)


(* ************************************************************************ *)
infix 50 :+
datasort type_list = nil | :+ of (t@ype, type_list)

stacst type_list_len(type_list) : int
praxi length_of_type_list() : [
  x:t@ype;
  xs:type_list;
  type_list_len(nil) == 0;
  type_list_len(x :+ xs) == type_list_len(xs) + 1
  ] void

dataprop TYPE_LIST_LENGTH(type_list, int)
  = TYPE_LIST_LENGTH_NIL(nil, 0)
  | {t:t@ype}{xs:type_list}{n:int}
    TYPE_LIST_LENGTH_CONS(t :+ xs, n + 1) of TYPE_LIST_LENGTH(xs, n)

praxi type_list_length_nat{n:int}{xs:type_list}
  (pr:TYPE_LIST_LENGTH(xs, n)) : [0 <= n] void



stacst type_list_map(f:t@ype -> t@ype, xs:type_list) : type_list
praxi type_list_map_implement() : [
  f:t@ype -> t@ype;
  xs:type_list;

  ] void




(* ************************************************************************ *)

infix 50 :*
datasort type_list_product = :* of (t@ype -> t@ype, type_list)




