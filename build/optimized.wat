(module
 (type $i32_i32_i32_=>_none (func (param i32 i32 i32)))
 (type $i32_i32_=>_none (func (param i32 i32)))
 (type $i32_i32_i32_i32_=>_none (func (param i32 i32 i32 i32)))
 (type $i32_=>_i32 (func (param i32) (result i32)))
 (type $i64_=>_i64 (func (param i64) (result i64)))
 (type $none_=>_f64 (func (result f64)))
 (import "env" "memory" (memory $0 1))
 (data (i32.const 1036) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\18\00\00\00~\00l\00i\00b\00/\00m\00a\00t\00h\00.\00t\00s\00\00\00\00\00")
 (import "env" "seed" (func $~lib/builtins/seed (result f64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/math/random_seeded (mut i32) (i32.const 0))
 (global $~lib/math/random_state0_64 (mut i64) (i64.const 0))
 (global $~lib/math/random_state1_64 (mut i64) (i64.const 0))
 (global $~lib/math/random_state0_32 (mut i32) (i32.const 0))
 (global $~lib/math/random_state1_32 (mut i32) (i32.const 0))
 (export "invert" (func $assembly/index/invert))
 (export "grayscale" (func $assembly/index/grayscale))
 (export "basicMonochrome" (func $assembly/index/basicMonochrome))
 (export "randomMonochrome" (func $assembly/index/randomMonochrome))
 (export "incBrightness" (func $assembly/index/incBrightness))
 (export "decBrightness" (func $assembly/index/decBrightness))
 (export "saturation" (func $assembly/index/saturation))
 (export "memory" (memory $0))
 (func $assembly/index/invert (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $0
  loop $for-loop|0
   local.get $0
   local.get $2
   i32.gt_s
   if
    local.get $2
    i32.const 1
    i32.add
    i32.load8_u
    local.set $1
    local.get $2
    i32.const 2
    i32.add
    i32.load8_u
    local.set $3
    local.get $2
    i32.const 255
    local.get $2
    i32.load8_u
    i32.sub
    i32.store8
    local.get $2
    i32.const 255
    local.get $1
    i32.sub
    i32.store8 offset=1
    local.get $2
    i32.const 255
    local.get $3
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
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $1
  loop $for-loop|0
   local.get $1
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
    i32.const 1
    i32.add
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.7152
    f64.mul
    f64.add
    local.get $2
    i32.const 2
    i32.add
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.0722
    f64.mul
    f64.add
    i32.trunc_f64_u
    local.tee $0
    i32.store8
    local.get $2
    local.get $0
    i32.store8 offset=1
    local.get $2
    local.get $0
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
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $1
  loop $for-loop|0
   local.get $1
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
    i32.const 1
    i32.add
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.7152
    f64.mul
    f64.add
    local.get $3
    i32.const 2
    i32.add
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.0722
    f64.mul
    f64.add
    f64.gt
    select
    local.tee $0
    i32.store8
    local.get $3
    local.get $0
    i32.store8 offset=1
    local.get $3
    local.get $0
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
  local.get $0
  i64.const 33
  i64.shr_u
  i64.xor
  i64.const -49064778989728563
  i64.mul
  local.tee $0
  local.get $0
  i64.const 33
  i64.shr_u
  i64.xor
  i64.const -4265267296055464877
  i64.mul
  local.tee $0
  local.get $0
  i64.const 33
  i64.shr_u
  i64.xor
 )
 (func $~lib/math/splitMix32 (param $0 i32) (result i32)
  local.get $0
  i32.const 1831565813
  i32.add
  local.tee $0
  local.get $0
  i32.const 15
  i32.shr_u
  i32.xor
  local.get $0
  i32.const 1
  i32.or
  i32.mul
  local.tee $0
  local.get $0
  local.get $0
  i32.const 61
  i32.or
  local.get $0
  local.get $0
  i32.const 7
  i32.shr_u
  i32.xor
  i32.mul
  i32.add
  i32.xor
  local.tee $0
  local.get $0
  i32.const 14
  i32.shr_u
  i32.xor
 )
 (func $assembly/index/randomMonochrome (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 f64)
  (local $6 i64)
  (local $7 i64)
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $1
  loop $for-loop|0
   local.get $1
   local.get $4
   i32.gt_s
   if
    local.get $4
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.2126
    f64.mul
    local.get $4
    i32.const 1
    i32.add
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.7152
    f64.mul
    f64.add
    local.get $4
    local.tee $3
    i32.const 2
    i32.add
    i32.load8_u
    f64.convert_i32_u
    f64.const 0.0722
    f64.mul
    f64.add
    local.set $5
    global.get $~lib/math/random_seeded
    i32.eqz
    if
     call $~lib/builtins/seed
     i64.reinterpret_f64
     local.set $7
     i32.const 1
     global.set $~lib/math/random_seeded
     local.get $7
     call $~lib/math/murmurHash3
     global.set $~lib/math/random_state0_64
     global.get $~lib/math/random_state0_64
     i64.const -1
     i64.xor
     call $~lib/math/murmurHash3
     global.set $~lib/math/random_state1_64
     local.get $7
     i32.wrap_i64
     call $~lib/math/splitMix32
     global.set $~lib/math/random_state0_32
     global.get $~lib/math/random_state0_32
     call $~lib/math/splitMix32
     global.set $~lib/math/random_state1_32
     global.get $~lib/math/random_state1_32
     i32.const 0
     i32.ne
     i32.const 0
     global.get $~lib/math/random_state0_32
     i32.const 0
     global.get $~lib/math/random_state1_64
     i64.const 0
     i64.ne
     i32.const 0
     global.get $~lib/math/random_state0_64
     i64.const 0
     i64.ne
     select
     select
     select
     i32.eqz
     if
      i32.const 0
      i32.const 1056
      i32.const 1399
      i32.const 5
      call $~lib/builtins/abort
      unreachable
     end
    end
    global.get $~lib/math/random_state0_64
    local.set $6
    global.get $~lib/math/random_state1_64
    local.tee $7
    global.set $~lib/math/random_state0_64
    local.get $7
    local.get $6
    local.get $6
    i64.const 23
    i64.shl
    i64.xor
    local.tee $6
    local.get $6
    i64.const 17
    i64.shr_u
    i64.xor
    i64.xor
    local.get $7
    i64.const 26
    i64.shr_u
    i64.xor
    global.set $~lib/math/random_state1_64
    local.get $3
    i32.const 0
    i32.const 255
    local.get $5
    local.get $7
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
    f64.lt
    select
    local.tee $0
    i32.store8
    local.get $4
    local.get $0
    i32.store8 offset=1
    local.get $3
    local.get $0
    i32.store8 offset=2
    local.get $3
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
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $0
  loop $for-loop|0
   local.get $0
   local.get $3
   i32.gt_s
   if
    local.get $3
    i32.const 1
    i32.add
    i32.load8_u
    local.set $1
    local.get $3
    i32.const 2
    i32.add
    i32.load8_u
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
    local.get $1
    local.get $2
    i32.add
    local.tee $1
    local.get $1
    i32.const 255
    i32.gt_s
    select
    i32.store8 offset=1
    local.get $3
    i32.const 255
    local.get $2
    local.get $4
    i32.add
    local.tee $1
    local.get $1
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
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $0
  loop $for-loop|0
   local.get $0
   local.get $3
   i32.gt_s
   if
    local.get $3
    i32.const 1
    i32.add
    i32.load8_u
    local.set $1
    local.get $3
    i32.const 2
    i32.add
    i32.load8_u
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
    local.get $1
    local.get $2
    i32.sub
    local.tee $1
    local.get $1
    i32.const 0
    i32.lt_s
    select
    i32.store8 offset=1
    local.get $3
    i32.const 0
    local.get $4
    local.get $2
    i32.sub
    local.tee $1
    local.get $1
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
  (local $13 f64)
  (local $14 f64)
  (local $15 f64)
  (local $16 f64)
  (local $17 i32)
  local.get $0
  local.get $1
  i32.mul
  i32.const 2
  i32.shl
  local.set $17
  loop $for-loop|0
   local.get $12
   local.get $17
   i32.lt_s
   if
    local.get $12
    i32.const 2
    i32.add
    local.tee $0
    i32.load8_u
    local.set $4
    local.get $12
    local.set $10
    i32.const -1
    local.set $6
    i32.const -1
    local.set $3
    i32.const -1
    local.set $5
    i32.const -1
    local.set $11
    i32.const -1
    local.set $9
    local.get $12
    i32.load8_u
    local.tee $7
    local.get $12
    i32.const 1
    i32.add
    local.tee $1
    i32.load8_u
    local.tee $8
    i32.gt_u
    if (result i32)
     local.get $4
     local.get $7
     i32.lt_u
     if (result i32)
      local.get $10
      local.set $11
      local.get $7
      local.set $9
      local.get $4
      local.get $8
      i32.gt_u
      if (result i32)
       local.get $4
       local.set $5
       local.get $1
       local.set $6
       local.get $8
       local.set $3
       local.get $0
      else
       local.get $8
       local.set $5
       local.get $0
       local.set $6
       local.get $4
       local.set $3
       local.get $1
      end
     else
      local.get $0
      local.set $11
      local.get $4
      local.set $9
      local.get $7
      local.set $5
      local.get $1
      local.set $6
      local.get $8
      local.set $3
      local.get $10
     end
    else
     local.get $7
     local.get $8
     i32.lt_u
     if (result i32)
      local.get $4
      local.get $8
      i32.lt_u
      if (result i32)
       local.get $1
       local.set $11
       local.get $8
       local.set $9
       local.get $4
       local.get $7
       i32.gt_u
       if (result i32)
        local.get $4
        local.set $5
        local.get $10
        local.set $6
        local.get $7
        local.set $3
        local.get $0
       else
        local.get $7
        local.set $5
        local.get $0
        local.set $6
        local.get $4
        local.set $3
        local.get $10
       end
      else
       local.get $0
       local.set $11
       local.get $4
       local.set $9
       local.get $8
       local.set $5
       local.get $10
       local.set $6
       local.get $7
       local.set $3
       local.get $1
      end
     else
      i32.const -1
     end
    end
    local.set $0
    local.get $3
    local.get $9
    i32.ne
    if
     f64.const 255
     local.get $7
     f64.convert_i32_u
     local.get $8
     f64.convert_i32_u
     f64.max
     local.get $4
     f64.convert_i32_u
     f64.max
     local.get $7
     f64.convert_i32_u
     local.get $8
     f64.convert_i32_u
     f64.min
     local.get $4
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
     local.tee $13
     f64.const 0.5
     f64.add
     f64.floor
     local.get $13
     f64.copysign
     local.set $13
     local.get $2
     i32.const 1
     i32.eq
     if (result i32)
      local.get $14
      local.get $5
      f64.convert_i32_s
      f64.sub
      local.get $14
      local.get $9
      f64.convert_i32_s
      f64.sub
      f64.div
      local.set $16
      local.get $9
      f64.convert_i32_s
      local.get $13
      f64.const 150
      f64.div
      f64.const 255
      local.get $9
      f64.convert_i32_s
      f64.sub
      local.get $3
      f64.convert_i32_s
      f64.min
      f64.min
      local.tee $13
      f64.add
      local.set $15
      local.get $3
      f64.convert_i32_s
      local.get $13
      f64.sub
      local.tee $13
      f64.const 0.5
      f64.add
      f64.floor
      local.get $13
      f64.copysign
      i32.trunc_f64_s
      local.set $3
      local.get $14
      local.get $15
      f64.const 0.5
      f64.add
      f64.floor
      local.get $15
      f64.copysign
      i32.trunc_f64_s
      local.tee $9
      f64.convert_i32_s
      local.get $14
      f64.sub
      local.get $16
      f64.mul
      f64.add
      local.tee $13
      f64.const 0.5
      f64.add
      f64.floor
      local.get $13
      f64.copysign
      i32.trunc_f64_s
     else
      local.get $2
      i32.const -1
      i32.eq
      if (result i32)
       local.get $14
       local.get $5
       f64.convert_i32_s
       f64.sub
       local.get $14
       local.get $9
       f64.convert_i32_s
       f64.sub
       f64.div
       local.set $16
       local.get $9
       f64.convert_i32_s
       local.get $13
       f64.const 150
       f64.div
       local.get $14
       local.get $3
       f64.convert_i32_s
       f64.sub
       f64.min
       local.tee $13
       f64.sub
       local.set $15
       local.get $3
       f64.convert_i32_s
       local.get $13
       f64.add
       local.tee $13
       f64.const 0.5
       f64.add
       f64.floor
       local.get $13
       f64.copysign
       i32.trunc_f64_s
       local.set $3
       local.get $14
       local.get $15
       f64.const 0.5
       f64.add
       f64.floor
       local.get $15
       f64.copysign
       i32.trunc_f64_s
       local.tee $9
       f64.convert_i32_s
       local.get $14
       f64.sub
       local.get $16
       f64.mul
       f64.add
       local.tee $13
       f64.const 0.5
       f64.add
       f64.floor
       local.get $13
       f64.copysign
       i32.trunc_f64_s
      else
       local.get $5
      end
     end
     local.set $5
     local.get $11
     local.get $9
     i32.store8
     local.get $0
     local.get $5
     i32.store8
     local.get $6
     local.get $3
     i32.store8
    end
    local.get $12
    i32.const 4
    i32.add
    local.set $12
    br $for-loop|0
   end
  end
 )
)
