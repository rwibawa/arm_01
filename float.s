.thumb
.global calc_float
.func calc_float

.thumb_func
calc_float:
  ldr r0, =val1
  vldr s0, [r0]         ; # load value that is pointed by r0

  ldr r0, =val2
  vldr s1, [r0]

#  vmul.f32 s2, s0, s1
#  vmov s0, s2
  vmul.f32 s0, s0, s1   ; # multiply with single precission
                        ; # return value should be in s0

  bx lr                 ; # 'return' in arm asm

val1:
  .float 4.20

val2:
  .float .69
