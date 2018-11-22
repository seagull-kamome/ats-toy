(*
 *
 *)

staload "SATS/fixfy.sats"
staload "SATS/type_list.sats"

infix 50 :+

datatype HeterogeneousList(f:t@ype -> t@ype, xs:TypeList, n:int)
  = {f:t@ype -> t@ype} Nil'HeterogeneousList(f, Nil'TypeList, 0)
  | {f:t@ype -> t@ype} {t:t@ype}{xs:TypeList}{n:int | n >= 0}
    :+ (f, t :+ xs, n + 1) of (f(t), HeterogeneousList(f, xs, n) )


prfun lemma_param'HeterogeneousList
  {f:t@ype -> t@ype; flds:TypeList; n:int}
  (xs:HeterogeneousList(f, flds, n)) : [0 <= n] void


fun length'HeterogeneousList
  {f:t@ype -> t@ype; flds:TypeList; n:int}
  (xs:HeterogeneousList(f, flds, n)) : int(n)


