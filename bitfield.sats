

//#include "share/atspre_define.hats"
//#include "share/atspre_staload.hats"
//staload UN = "prelude/SATS/unsafe.sats"


/* BITPACK */

datasort bitpack_layout =
  | bitpack_hole of (int)
  | bitpack_field of (int, t@ype)
  | bitpack_combine of (bitpack_layout, bitpack_layout)

stacst bitpack_layout_width_eq(bitpack_layout, int) : bool
praxi bitpack_layout_width_hole()
  : [x:int; bitpack_layout_width_eq(bitpack_hole(x), x)] void
praxi bitpack_layout_width_field()
  : [x:int; t:t@ype; bitpack_layout_width_eq(bitpack_field(x, t), x)] void
praxi bitpack_layout_width_combine()
  : [x,y:int; l,r:bitpack_layout;
     bitpack_layout_width_eq(l,x) && bitpack_layout_width_eq(r, y) && bitpack_layout_width_eq(bitpack_combine(l,r), x+y)] void



stacst bitpack_has_actualtype_1(int, int -> t@ype) : bool
praxi bitpack64_is_uint64_1() : [bitpack_has_actualtype_1(64, uint64_1)] void
praxi bitpack32_is_uint32_1() : [bitpack_has_actualtype_1(32, uint32_1)] void
praxi bitpack32_is_uint16_1() : [bitpack_has_actualtype_1(16, uint16_1)] void
praxi bitpack32_is_uint8_1() : [bitpack_has_actualtype_1(8, uint8_1)] void

/* maybe useless
stacst bitpack_has_actualtype_0(int, t@ype) : bool
praxi bitpack64_is_uint64_0() : [bitpack_has_actualtype_0(64, uint64_0)] void
praxi bitpack32_is_uint32_0() : [bitpack_has_actualtype_0(32, uint32_0)] void
praxi bitpack32_is_uint16_0() : [bitpack_has_actualtype_0(16, uint16_0)] void
praxi bitpack32_is_uint8_0() : [bitpack_has_actualtype_0(8, uint8_0)] void
*/


abst@ype bitpack_3(hw:int, ly:bitpack_layout, n:int) =
  [t:int->t@ype; bitpack_has_actualtype_1(hw, t); bitpack_layout_width_eq(ly, hw)] t(n)
typedef bitpack_2a(hw:int, ly:bitpack_layout) = [n:int] bitpack_3(hw, ly, n)
typedef bitpack_2b(hw:int, n:int) = [ly:bitpack_layout] bitpack_3(hw, ly, n)
typedef bitpack_2c(ly:bitpack_layout, n:int) = [hw:int] bitpack_3(hw, ly, n)
typedef bitpack_1a(hw:int) = [ly:bitpack_layout] bitpack_2a(hw, ly)
typedef bitpack_1b(ly:bitpack_layout) = [hw:int] bitpack_2a(hw, ly)
typedef bitpack_0 = [hw:int] bitpack_1a(hw)
stadef bitpack = bitpack_3
stadef bitpack = bitpack_2c
stadef bitpack = bitpack_2b
stadef bitpack = bitpack_2a
stadef bitpack = bitpack_1b
stadef bitpack = bitpack_1a
stadef bitpack = bitpack_0


typedef bitpack8(ly:bitpack_layout, n:int) = bitpack(8, ly, n)
typedef bitpack8(ly:bitpack_layout) = [n:int] bitpack8(ly, n)
typedef bitpack16(ly:bitpack_layout, n:int) = bitpack(16, ly, n)
typedef bitpack16(ly:bitpack_layout) = [n:int] bitpack16(ly, n)
typedef bitpack32(ly:bitpack_layout, n:int) = bitpack(32, ly, n)
typedef bitpack32(ly:bitpack_layout) = [n:int] bitpack32(ly, n)
typedef bitpack64(ly:bitpack_layout, n:int) = bitpack(64, ly, n)
typedef bitpack64(ly:bitpack_layout) = [n:int] bitpack64(ly, n)


/* int has left shifted value */
stacst int_shift_left(int, int, int) : bool
praxi zero_shift_left_with_any() : [n:int; int_shift_left(0, n, 0)] void
praxi int_shift_left_with_zero() : [n:int; int_shift_left(n, 0, n)] void
praxi int_shift_left_with_n() :
  [n,o:int; m:nat;
    int_shift_left(n, m, o);
    int_shift_left(n, m + 1, o + o)] void



stacst bitpack_layout_has_hole_mask(bitpack_layout, int) : bool
praxi bitpack_hole_mask_hole() :
  [n:pos; m:int;
   int_shift_left(1, n, m);
   bitpack_layout_has_hole_mask(bitpack_hole(n), m - 1) ] void
praxi bitpack_hole_mask_field() :
  [n:pos; t:t@ype;
   bitpack_layout_has_hole_mask(bitpack_field(n, t), 0) ] void
praxi bitpack_hole_mask_combine() :
  [l,r:bitpack_layout;
   n,m,o,rw:int;
  bitpack_layout_has_hole_mask(l, n);
  bitpack_layout_has_hole_mask(r, m);
  bitpack_layout_width_eq(r, rw);
  int_shift_left(n, rw, o);
  bitpack_layout_has_hole_mask(bitpack_combine(l, r), o + m)] void






datasort bitpack_path =
  | bitpack_path_here of (t@ype)
  | bitpack_path_left of (bitpack_path)
  | bitpack_path_right of (bitpack_path)

stacst valid_bitpack_path(bitpack_path, bitpack_layout, t@ype, int, int) : bool
praxi valid_bitpack_path_here() :
  [t:t@ype; n:int; valid_bitpack_path(bitpack_path_here(t), bitpack_field(n, t), t, n, 0)] void
praxi valid_bitpack_path_left() :
  [x:bitpack_path; l,r:bitpack_layout; m,n,o:int; t:t@ype;
    valid_bitpack_path(x, l, t, n, m);
    bitpack_layout_width_eq(r, o);
    valid_bitpack_path(bitpack_path_left(x), bitpack_combine(l, r), t, n, m + o)] void
praxi valid_bitpack_path_right() :
  [x:bitpack_path; l,r:bitpack_layout; m,n:int; t:t@ype;
    valid_bitpack_path(x, r, t, n, m);
    valid_bitpack_path(bitpack_path_left(x), bitpack_combine(l, r), t, n, m)] void



abst@ype bitpack_modifier_3(hw:int, ly:bitpack_layout, m:int, n:int) = (bitpack(hw, ly, m), bitpack(hw, ly, n))
typedef bitpack_modifier_2a(hw:int, ly:bitpack_layout) = [m,n:int] bitpack_modifier_3(hw, ly, m, n)
typedef bitpack_modifier_2b(hw:int, m:int, n:int) = [ly:bitpack_layout] bitpack_modifier_3(hw, ly, m, n)
typedef bitpack_modifier_2c(ly:bitpack_layout, m:int, n:int) = [hw:int] bitpack_modifier_3(hw, ly, m, n)
typedef bitpack_modifier_1a(hw:int) = [ly:bitpack_layout] bitpack_modifier_2a(hw, ly)
typedef bitpack_modifier_1b(ly:bitpack_layout) = [hw:int] bitpack_modifier_2a(hw, ly)
typedef bitpack_modifier_0 = [hw:int] bitpack_modifier_1a(hw)
stadef bitpack_modifier = bitpack_modifier_3
stadef bitpack_modifier = bitpack_modifier_2c
stadef bitpack_modifier = bitpack_modifier_2b
stadef bitpack_modifier = bitpack_modifier_2a
stadef bitpack_modifier = bitpack_modifier_1b
stadef bitpack_modifier = bitpack_modifier_1a
stadef bitpack_modifier = bitpack_modifier_0



fn apply_bitpack_modifier
  {hw:int;ly:bitpack_layout}
  (x:bitpack(hw, ly), y:bitpack_modifier(hw, ly)) : bitpack(hw,ly)




stacst unsigned_bitfield_limit(int, int): bool
praxi unsigned_bitfield_limit_one() : [unsigned_bitfield_limit(1, 1)] void
praxi unsigned_bitfield_limit_succ() :
  [w,n:pos; w > 1;
   unsigned_bitfield_limit(w, n);
   unsigned_bitfield_limit(w + 1, n + n + 1)] void

stacst signed_bitfield_limit(int, int, int): bool
praxi signed_bitfield_limit_one() : [signed_bitfield_limit(1, ~1, 0)] void
praxi signed_bitfield_limit_succ() :
  [w,m:pos; n:neg; w > 1;
   signed_bitfield_limit(w, n, m);
   signed_bitfield_limit(w + 1, n + n, m + m + 1)] void


abst@ype bitfield_4(t:t@ype, hw:int, w:int, n:int) =
  [ht:int->t@ype; tv:int;
   w <= hw;
   bitpack_has_actualtype_1(hw, ht);
   unsigned_bitfield_limit(w, tv);
   n >= 0; n <= tv
  ] ht(n)
typedef bitfield_3(t:t@ype, hw:int, w:int) = [n:int] bitfield_4(t, hw, w, n)
typedef bitfield_2(t:t@ype, hw:int) = [w:int] bitfield_3(t, hw, w)
typedef bitfield_1(t:t@ype) = [hw:int] bitfield_2(t, hw)
stadef bitfield = bitfield_4
stadef bitfield = bitfield_3
stadef bitfield = bitfield_3
stadef bitfield = bitfield_1


fn bitpack_modifier_of_bitfield
  {hw1,hw2,w,n,shift:int; t:t@ype;
   ly:bitpack_layout;
   path:bitpack_path;
   hw2 >= hw1;
   valid_bitpack_path(path, ly, t, w, shift)}
  (x:bitfield(t, hw1, w, n)) : [m,o:int] bitpack_modifier(hw2, ly, m, o)



/*
fn modify_bitpack
  {hw,w,shift:int;ly:bitpack_layout; t:t@ype;
   path:bitpack_path;
   valid_bitpack_path(path, ly, t, w, shift) }
  (x:bitpack(hw, ly), x:t) : bitpack(hw, ly)
*/



