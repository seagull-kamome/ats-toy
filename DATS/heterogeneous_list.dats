(*
 *
 *)
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/heterogeneous_list.sats"
staload "SATS/type_list.sats"

primplement
lemma_param'HeterogeneousList{f, flds, n}(xs)
  = case+ xs of
    | Nil'HeterogeneousList _ => ()
    | :+ _ => ()



implement
length'HeterogeneousList{f,flds,n}(xs)
  = let
    prval () = lemma_param'HeterogeneousList(xs)
    fun go{i,j:nat; xs:TypeList} .<i>. (xs:HeterogeneousList(f, xs, i), j:int(j)) : int(i + j)
      = case+ xs of
        | Nil'HeterogeneousList _ => j
        | :+ (_, ys) => go(ys, j + 1)
    in go(xs, 0) end


