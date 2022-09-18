# ARM Assembly Tutorial 001

.global _start
.section .text

# STDIN - 0
# STDOUT - 1
# STDERR - 2

# write a string to stdout

_start:

hello_world:
  mov r7, #0x4
  mov r0, #1
  ldr r1, =message
  mov r2, #MSG_LEN
  swi 0

# add 1 to the label
# branch to it
  ldr r0, =#hello_world_thumb
  add r0, r0, #1
  bx r0

.thumb
hello_world_thumb:
  mov r7, #0x4
  mov r0, #1
  ldr r1, =message
  mov r2, #MSG_LEN
  swi 0

# branch to exit to return to arm mode
  ldr r0, =#exit
  bx r0

.arm
exit:
  mov r7, #0x1
  mov r0, #65
  swi 0

.section .data
  message:
  .ascii "Hello, World\n"
  .equ MSG_LEN, . - message
