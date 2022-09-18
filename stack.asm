# ARM Stacks

.global _start
.section .text

_start:
  bl hello_world        ; # branch and link
  bl exit               ; # to do a function call

hello_world:
  push {r4-r11, lr}     ; # Preserve all non-volatile registers
                        ; # Preserve lr (line #8)
  mov fp, sp
  sub sp, sp, #0x40      ; # Add 64 bytes memory to work with

# load a value to r1, then store it in a memory location
  ldr r1, =#0x1337
  str r1, [fp, #-0x10]

  mov r7, #0x4
  mov r0, #1
  ldr r1, =message
  mov r2, #MSG_LEN
  swi 0

  mov sp, fp            ; # set stack pointer back
  pop {r4-r11, pc}      ; # set link register (lr) to program counter (pc)
                        ; # in order to return code control to the caller

exit:
  push {fp, lr}         ; # we don't use r4-r11 registers
  
  mov r7, #0x1
  mov r0, #65
  swi 0

  pop {fp, pc}          ; return

.section .data
  message:
  .ascii "Hello, World\n"
  .equ MSG_LEN, . - message
