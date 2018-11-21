(*
 *
 *)

staload "SATS/fixfy.sats"
staload "SATS/type_list.sats"

infix 50 :+

datatype heterogeneous_list (f:t@ype -> t@ype, xs:type_list, n:int)
  = {f:t@ype -> t@ype} nil(f, nil, 0) of ()
  | {f:t@ype -> t@ype} {t:t@ype}{xs:type_list}{n:int}
    :+ (f, t :+ xs, n + 1) of (f(t), heterogeneous_list(f, xs, n) )


prfun lemma_heterogeneous_list_length_param
  {f:t@ype -> t@ype}{xs:type_list}{n:int}
  (ys:heterogeneous_list(f, xs, n)) : [n >= 0] void




