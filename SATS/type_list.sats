(*
 *
 *)


infixr 50 :+
infix 50 :*
infix 60 :>

(* ************************************************************************ *)
datasort TypeList = Nil'TypeList | :+ of (t@ype, TypeList)



// list(t@ype)
stacst type_list_len(TypeList) : int
praxi TypeList_has_length() : [
  x:t@ype;
  xs:TypeList;
  type_list_len(Nil'TypeList) == 0;
  type_list_len(x :+ xs) == type_list_len(xs) + 1
  ] void

dataprop TYPE_LIST_LENGTH(TypeList, int)
  = TYPE_LIST_LENGTH_NIL(Nil'TypeList, 0)
  | {t:t@ype}{xs:TypeList}{n:int | 0 <= n}
    TYPE_LIST_LENGTH_CONS(t :+ xs, n + 1) of [0 <= (n + 1)] TYPE_LIST_LENGTH(xs, n)

prfun type_list_length_nat{n:int}{xs:TypeList}
  (pr:TYPE_LIST_LENGTH(xs, n)) : [0 <= n] void


stacst fmap'TypeList(t@ype -> t@ype, TypeList) : TypeList
praxi fmap'TypeList_implement() : [
  f:t@ype -> t@ype;
  x:t@ype;
  xs:TypeList;
  fmap'TypeList(f, Nil'TypeList) == Nil'TypeList;
  fmap'TypeList(f, x :+ xs) == f(x) :+ fmap'TypeList(f, xs)
  ] void

stadef fmap'TypeList(f:t@ype -> t@ype):TypeList -> TypeList =
  lam xs => fmap'TypeList(f, xs)


dataprop MEMBERSHIP(TypeList, t@ype)
  = {x:t@ype}{xs:TypeList}   HERE(x :+ xs, x)
  | {x,y:t@ype}{xs:TypeList} THERE(x :+ xs, y) of MEMBERSHIP(xs, y)




(* ************************************************************************ *)

datasort Product = :* of (t@ype -> t@ype, TypeList)

stacst reduce'Product(Product) : TypeList
praxi reduce'Product_implement() : [
  f:t@ype -> t@ype; x:t@ype; xs:TypeList;
  reduce'Product(f :* Nil'TypeList) == Nil'TypeList;
  reduce'Product(f :* (x :+ xs)) == f(x) :+ reduce'Product(f :* xs)
  ] void




(* ************************************************************************ *)

datasort Assoc = :> of (string, t@ype)
 and AssocList = Nil'AssocList | :+ of (Assoc, AssocList)


(* // TODO: HOW?
stacst key'Assoc(Assoc):string
stacst value'Assoc(Assoc):t@ype
praxi assoc_impl() : [
  k:string; t:t@ype;
  key'Assoc(k :> t) == k;
  value'Assoc(k :> t) == t
  ] void
*)


stacst associated(string, t@ype, AssocList) : bool
praxi associated_impl() : [
  k:string; t:t@ype; x:Assoc; xs:AssocList;
  associated(k, t, k :> t :+ Nil'AssocList);
  associated(k, t, x :+ xs) == associated(k, t, xs)
  ] void

dataprop ASSOCIATED(string, t@ype, AssocList)
  = {k:string; t:t@ype; xs:AssocList} HERE(k, t, (k :> t) :+ xs)
  | {k:string; t,t0:t@ype; x:Assoc; xs:AssocList}
    THERE(k, t, x :+ xs) of ASSOCIATED(k, t, xs)




