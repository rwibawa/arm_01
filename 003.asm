# ARM Assembly Tutorial 001

.global _start
.section .text

# STDIN - 0
# STDOUT - 1
# STDERR - 2

# write a string to stdout

_start:
  mov r7, #0x4
  mov r0, #1
  ldr r1, =message
  mov r2, #13
  swi 0

  mov r7, #0x1
  mov r0, #65
  swi 0

.section .data
  message:
  .ascii "Hello, World\n"
