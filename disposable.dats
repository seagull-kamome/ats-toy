
staload "disposable.sats"

implement{vt} dispose_disposable_vt0ype(x) =
  let
    val ~make_disposable_with_disposer(xx, f) = x
   in f(xx)
  end


implement{vt} salvage_disposable_vt0ype(x) =
  let
    val ~make_disposable_with_disposer(xx, _) = x
   in xx
  end

