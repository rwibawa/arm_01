# ARM Assembly Tutorial 001

.global _start
.section .text

# STDIN - 0
# STDOUT - 1
# STDERR - 2

# write a string to stdout

_start:
# NR 4, syscall: write
  mov r7, #0x4
  mov r0, #1        ; # file descriptor (fd=1): STDOUT
  ldr r1, =message  ; # pointer to the buffer
  mov r2, #MSG_LEN  ; # buffer count
  swi 0

# NR 1, syscall: exit
  mov r7, #0x1
  mov r0, #65       ; # return code
  swi 0

.section .data
  message:
  .ascii "Hello, World\n"
  .equ MSG_LEN, . - message
