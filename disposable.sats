

dataviewtype disposable_vt0ype(vt@ype) =
  | {vt:vt@ype}
     make_disposable_with_disposer(vt) of
        (vt, (vt -> void))

stacst is_disposable(vt@ype) : bool
stacst is_disposable(t@ype) : bool

praxi disposable_vt0ype_is_disposable{vt:vt@ype}()
  : [is_disposable(disposable_vt0ype(vt))] void
praxi t0ype_is_disposable{t:t@ype}() : [is_disposable(t)] void

stacst disposable_elm_type(vt@ype, vt@ype) : bool
stacst disposable_elm_type(t@ype, t@ype) : bool

praxi disposable_vt0ype_is_containner{vt:vt@ype}()
  : [disposable_elm_type(disposable_vt0ype(vt), vt)] void
praxi t0ype_is_identity_disposable{t:t@ype}() : [disposable_elm_type(t, t)] void


fn{vt:vt@ype} dispose_disposable_vt0ype(x:disposable_vt0ype(vt)) : void
fn{vt:vt@ype} salvage_disposable_vt0ype(x:disposable_vt0ype(vt)) : vt

%{
#define c_noop()   do {;} while(0)
#define c_identity(x)  (x)
%}
fn{t:t@ype} dispose_t0ype(x:t) : void = "mac%c_noop"
fn{t:t@ype} salvage_t0ype(x:t) : t = "mac%c_identity"

overload dispose with dispose_disposable_vt0ype
overload dispose with dispose_t0ype
overload salvage with salvage_disposable_vt0ype
overload salvate with salvage_t0ype


