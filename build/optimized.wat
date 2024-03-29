(module
 (type $i32_i32_i32_=>_none (func (param i32 i32 i32)))
 (type $i32_i32_=>_none (func (param i32 i32)))
 (type $none_=>_f64 (func (result f64)))
 (type $i64_=>_i64 (func (param i64) (result i64)))
 (type $i32_=>_i32 (func (param i32) (result i32)))
 (import "env" "memory" (memory $0 0))
 (import "env" "seed" (func $~lib/builtins/seed (result f64)))
 (global $~lib/math/random_seeded (mut i32) (i32.const 0))
 (global $~lib/math/random_state0_64 (mut i64) (i64.const 0))
 (global $~lib/math/random_state1_64 (mut i64) (i64.const 0))
 (global $~lib/math/random_state0_32 (mut i32) (i32.const 0))
 (export "invert" (func $assembly/index/invert))
 (export "grayscale" (func $assembly/index/grayscale))
 (export "basicMonochrome" (func $assembly/index/basicMonochrome))
 (export "randomMonochrome" (func $assembly/index/randomMonochrome))
 (export "incBrightness" (func $assembly/index/incBrightness))
 (export "decBrightness" (func $assembly/index/decBrightness))
 (export "saturation" (func $assembly/index/saturation))
 (export "mirror" (func $assembly/index/mirror))
 (export "memory" (memory $0))
 (func $assembly/index/invert (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $2
   i32.gt_s
   if
    local.get $2
    i32.load8_u offset=1
    local.set $3
    local.get $2
    i32.load8_u offset=2
    local.set $4
    local.get $2
    i32.const 255
    local.get $2
    i32.load8_u
    i32.sub
    i32.store8
    local.get $2
    i32.const 255
    local.get $3
    i32.sub
    i32.store8 offset=1
    local.get $2
    i32.const 255
    local.get $4
    i32.sub
    i32.store8 offset=2
    local.get $2
    i32.const 4
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/grayscale (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $2
   i32.gt_s
   if
    local.get $2
    local.get $2
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.2126
    f64.mul
    local.get $2
    i32.load8_u offset=1
    f64.convert_i32_u
    f64.const 0.7152
    f64.mul
    f64.add
    local.get $2
    i32.load8_u offset=2
    f64.convert_i32_u
    f64.const 0.0722
    f64.mul
    f64.add
    i32.trunc_sat_f64_u
    local.tee $3
    i32.store8
    local.get $2
    local.get $3
    i32.store8 offset=1
    local.get $2
    local.get $3
    i32.store8 offset=2
    local.get $2
    i32.const 4
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/basicMonochrome (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $3
   i32.gt_s
   if
    local.get $3
    i32.const 0
    i32.const 255
    local.get $2
    f64.convert_i32_u
    local.get $3
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.2126
    f64.mul
    local.get $3
    i32.load8_u offset=1
    f64.convert_i32_u
    f64.const 0.7152
    f64.mul
    f64.add
    local.get $3
    i32.load8_u offset=2
    f64.convert_i32_u
    f64.const 0.0722
    f64.mul
    f64.add
    f64.gt
    select
    local.tee $4
    i32.store8
    local.get $3
    local.get $4
    i32.store8 offset=1
    local.get $3
    local.get $4
    i32.store8 offset=2
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $~lib/math/murmurHash3 (param $0 i64) (result i64)
  local.get $0
  i64.const 33
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -49064778989728563
  i64.mul
  local.tee $0
  i64.const 33
  i64.shr_u
  local.get $0
  i64.xor
  i64.const -4265267296055464877
  i64.mul
  local.tee $0
  i64.const 33
  i64.shr_u
  local.get $0
  i64.xor
 )
 (func $~lib/math/splitMix32 (param $0 i32) (result i32)
  local.get $0
  i32.const 1831565813
  i32.add
  local.tee $0
  i32.const 1
  i32.or
  local.get $0
  i32.const 15
  i32.shr_u
  local.get $0
  i32.xor
  i32.mul
  local.tee $0
  i32.const 61
  i32.or
  local.get $0
  i32.const 7
  i32.shr_u
  local.get $0
  i32.xor
  i32.mul
  local.get $0
  i32.add
  local.get $0
  i32.xor
  local.tee $0
  i32.const 14
  i32.shr_u
  local.get $0
  i32.xor
 )
 (func $assembly/index/randomMonochrome (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 f64)
  (local $7 i64)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $4
   i32.gt_s
   if
    local.get $4
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.2126
    f64.mul
    local.get $4
    i32.load8_u offset=1
    f64.convert_i32_u
    f64.const 0.7152
    f64.mul
    f64.add
    local.get $4
    i32.load8_u offset=2
    f64.convert_i32_u
    f64.const 0.0722
    f64.mul
    f64.add
    local.set $6
    global.get $~lib/math/random_seeded
    i32.eqz
    if
     call $~lib/builtins/seed
     i64.reinterpret_f64
     local.tee $3
     i64.eqz
     if
      i64.const -7046029254386353131
      local.set $3
     end
     local.get $3
     call $~lib/math/murmurHash3
     global.set $~lib/math/random_state0_64
     global.get $~lib/math/random_state0_64
     i64.const -1
     i64.xor
     call $~lib/math/murmurHash3
     global.set $~lib/math/random_state1_64
     local.get $3
     i32.wrap_i64
     call $~lib/math/splitMix32
     global.set $~lib/math/random_state0_32
     global.get $~lib/math/random_state0_32
     call $~lib/math/splitMix32
     drop
     i32.const 1
     global.set $~lib/math/random_seeded
    end
    global.get $~lib/math/random_state0_64
    local.set $7
    global.get $~lib/math/random_state1_64
    local.tee $3
    global.set $~lib/math/random_state0_64
    local.get $7
    i64.const 23
    i64.shl
    local.get $7
    i64.xor
    local.tee $7
    local.get $7
    i64.const 17
    i64.shr_u
    i64.xor
    local.get $3
    i64.xor
    local.get $3
    i64.const 26
    i64.shr_u
    i64.xor
    global.set $~lib/math/random_state1_64
    local.get $4
    i32.const 0
    i32.const 255
    local.get $3
    i64.const 12
    i64.shr_u
    i64.const 4607182418800017408
    i64.or
    f64.reinterpret_i64
    f64.const 1
    f64.sub
    f64.const 255
    local.get $2
    i32.const 1
    i32.shl
    f64.convert_i32_u
    f64.sub
    f64.mul
    local.get $2
    f64.convert_i32_u
    f64.add
    local.get $6
    f64.gt
    select
    local.tee $5
    i32.store8
    local.get $4
    local.get $5
    i32.store8 offset=1
    local.get $4
    local.get $5
    i32.store8 offset=2
    local.get $4
    i32.const 4
    i32.add
    local.set $4
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/incBrightness (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $3
   i32.gt_s
   if
    local.get $3
    i32.load8_u offset=1
    local.set $6
    local.get $3
    i32.load8_u offset=2
    local.set $4
    local.get $3
    i32.const 255
    local.get $2
    local.get $3
    i32.load8_u
    i32.add
    local.tee $5
    local.get $5
    i32.const 255
    i32.gt_s
    select
    i32.store8
    local.get $3
    i32.const 255
    local.get $2
    local.get $6
    i32.add
    local.tee $5
    local.get $5
    i32.const 255
    i32.gt_s
    select
    i32.store8 offset=1
    local.get $3
    i32.const 255
    local.get $2
    local.get $4
    i32.add
    local.tee $4
    local.get $4
    i32.const 255
    i32.gt_s
    select
    i32.store8 offset=2
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/decBrightness (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $3
   i32.gt_s
   if
    local.get $3
    i32.load8_u offset=1
    local.set $6
    local.get $3
    i32.load8_u offset=2
    local.set $4
    local.get $3
    i32.const 0
    local.get $3
    i32.load8_u
    local.get $2
    i32.sub
    local.tee $5
    local.get $5
    i32.const 0
    i32.lt_s
    select
    i32.store8
    local.get $3
    i32.const 0
    local.get $6
    local.get $2
    i32.sub
    local.tee $5
    local.get $5
    i32.const 0
    i32.lt_s
    select
    i32.store8 offset=1
    local.get $3
    i32.const 0
    local.get $4
    local.get $2
    i32.sub
    local.tee $4
    local.get $4
    i32.const 0
    i32.lt_s
    select
    i32.store8 offset=2
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/saturation (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 f64)
  (local $15 f64)
  (local $16 f64)
  (local $17 f64)
  (local $18 f64)
  loop $for-loop|0
   local.get $0
   local.get $1
   i32.mul
   i32.const 2
   i32.shl
   local.get $6
   i32.gt_s
   if
    local.get $6
    i32.const 2
    i32.add
    local.tee $3
    i32.load8_u
    local.set $9
    i32.const -1
    local.set $4
    i32.const -1
    local.set $5
    i32.const -1
    local.set $13
    i32.const -1
    local.set $10
    i32.const -1
    local.set $8
    local.get $6
    i32.const 1
    i32.add
    local.tee $7
    i32.load8_u
    local.tee $11
    local.get $6
    i32.load8_u
    local.tee $12
    i32.lt_u
    if
     local.get $9
     local.get $12
     i32.lt_u
     if (result i32)
      local.get $6
      local.set $10
      local.get $12
      local.set $8
      local.get $9
      local.get $11
      i32.gt_u
      if (result i32)
       local.get $3
       local.set $5
       local.get $7
       local.set $4
       local.get $9
       local.set $3
       local.get $11
      else
       local.get $7
       local.set $5
       local.get $3
       local.set $4
       local.get $11
       local.set $3
       local.get $9
      end
     else
      local.get $3
      local.set $10
      local.get $9
      local.set $8
      local.get $6
      local.set $5
      local.get $7
      local.set $4
      local.get $12
      local.set $3
      local.get $11
     end
     local.set $7
     local.get $3
     local.set $13
    else
     local.get $11
     local.get $12
     i32.gt_u
     if
      local.get $9
      local.get $11
      i32.lt_u
      if (result i32)
       local.get $7
       local.set $10
       local.get $11
       local.set $8
       local.get $9
       local.get $12
       i32.gt_u
       if (result i32)
        local.get $3
        local.set $5
        local.get $6
        local.set $4
        local.get $9
        local.set $3
        local.get $12
       else
        local.get $6
        local.set $5
        local.get $3
        local.set $4
        local.get $12
        local.set $3
        local.get $9
       end
      else
       local.get $3
       local.set $10
       local.get $9
       local.set $8
       local.get $7
       local.set $5
       local.get $6
       local.set $4
       local.get $11
       local.set $3
       local.get $12
      end
      local.set $7
      local.get $3
      local.set $13
     else
      i32.const -1
      local.set $7
     end
    end
    local.get $7
    local.get $8
    i32.ne
    if
     f64.const 255
     local.get $12
     f64.convert_i32_u
     local.get $11
     f64.convert_i32_u
     f64.max
     local.get $9
     f64.convert_i32_u
     f64.max
     local.get $12
     f64.convert_i32_u
     local.get $11
     f64.convert_i32_u
     f64.min
     local.get $9
     f64.convert_i32_u
     f64.min
     f64.add
     f64.const 0.5
     f64.mul
     f64.const 255
     f64.div
     f64.const 255
     f64.mul
     local.tee $14
     f64.sub
     local.get $14
     f64.min
     local.tee $15
     f64.ceil
     local.tee $16
     local.get $16
     f64.const 1
     f64.sub
     local.get $15
     local.get $16
     f64.const 0.5
     f64.sub
     f64.ge
     select
     local.set $15
     local.get $2
     i32.const 1
     i32.eq
     if (result i32)
      local.get $14
      local.get $13
      f64.convert_i32_s
      f64.sub
      local.get $14
      local.get $8
      f64.convert_i32_s
      f64.sub
      f64.div
      local.set $16
      local.get $8
      f64.convert_i32_s
      local.get $15
      f64.const 150
      f64.div
      f64.const 255
      local.get $8
      f64.convert_i32_s
      f64.sub
      local.get $7
      f64.convert_i32_s
      f64.min
      f64.min
      local.tee $15
      f64.add
      local.tee $17
      f64.ceil
      local.tee $18
      local.get $18
      f64.const 1
      f64.sub
      local.get $17
      local.get $18
      f64.const 0.5
      f64.sub
      f64.ge
      select
      i32.trunc_sat_f64_s
      local.set $8
      local.get $7
      f64.convert_i32_s
      local.get $15
      f64.sub
      local.tee $15
      f64.ceil
      local.tee $17
      local.get $17
      f64.const 1
      f64.sub
      local.get $15
      local.get $17
      f64.const 0.5
      f64.sub
      f64.ge
      select
      i32.trunc_sat_f64_s
      local.set $7
      local.get $14
      local.get $8
      f64.convert_i32_s
      local.get $14
      f64.sub
      local.get $16
      f64.mul
      f64.add
      local.tee $14
      f64.ceil
      local.tee $15
      local.get $15
      f64.const 1
      f64.sub
      local.get $14
      local.get $15
      f64.const 0.5
      f64.sub
      f64.ge
      select
      i32.trunc_sat_f64_s
     else
      local.get $2
      i32.const -1
      i32.eq
      if (result i32)
       local.get $14
       local.get $13
       f64.convert_i32_s
       f64.sub
       local.get $14
       local.get $8
       f64.convert_i32_s
       f64.sub
       f64.div
       local.set $16
       local.get $8
       f64.convert_i32_s
       local.get $15
       f64.const 150
       f64.div
       local.get $14
       local.get $7
       f64.convert_i32_s
       f64.sub
       f64.min
       local.tee $15
       f64.sub
       local.tee $17
       f64.ceil
       local.tee $18
       local.get $18
       f64.const 1
       f64.sub
       local.get $17
       local.get $18
       f64.const 0.5
       f64.sub
       f64.ge
       select
       i32.trunc_sat_f64_s
       local.set $8
       local.get $7
       f64.convert_i32_s
       local.get $15
       f64.add
       local.tee $15
       f64.ceil
       local.tee $17
       local.get $17
       f64.const 1
       f64.sub
       local.get $15
       local.get $17
       f64.const 0.5
       f64.sub
       f64.ge
       select
       i32.trunc_sat_f64_s
       local.set $7
       local.get $14
       local.get $8
       f64.convert_i32_s
       local.get $14
       f64.sub
       local.get $16
       f64.mul
       f64.add
       local.tee $14
       f64.ceil
       local.tee $15
       local.get $15
       f64.const 1
       f64.sub
       local.get $14
       local.get $15
       f64.const 0.5
       f64.sub
       f64.ge
       select
       i32.trunc_sat_f64_s
      else
       local.get $13
      end
     end
     local.set $3
     local.get $10
     local.get $8
     i32.store8
     local.get $5
     local.get $3
     i32.store8
     local.get $4
     local.get $7
     i32.store8
    end
    local.get $6
    i32.const 4
    i32.add
    local.set $6
    br $for-loop|0
   end
  end
 )
 (func $assembly/index/mirror (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  loop $for-loop|0
   local.get $1
   local.get $4
   i32.gt_s
   if
    i32.const 0
    local.set $2
    local.get $0
    i32.const 1
    i32.sub
    local.set $3
    loop $for-loop|1
     local.get $2
     local.get $3
     i32.lt_s
     if
      local.get $2
      local.get $0
      local.get $4
      i32.mul
      local.tee $6
      i32.add
      i32.const 2
      i32.shl
      local.tee $7
      i32.load
      local.set $5
      local.get $7
      local.get $3
      local.get $6
      i32.add
      i32.const 2
      i32.shl
      local.tee $6
      i32.load
      i32.store
      local.get $6
      local.get $5
      i32.store
      local.get $2
      i32.const 1
      i32.add
      local.set $2
      local.get $3
      i32.const 1
      i32.sub
      local.set $3
      br $for-loop|1
     end
    end
    local.get $4
    i32.const 1
    i32.add
    local.set $4
    br $for-loop|0
   end
  end
 )
)
