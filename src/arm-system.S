#include <sys/syscall.h>

#define BINSH "/bin/sh\x00\x00\x00\x00"
#define TACC "-c\x00\x00\x00\x00\x00"

.globl main
.type main, @function

main:
    /* TODO
    // Fork, setsid, fork, exit in ARM
    li $v0, SYS_fork
    syscall
    beq $v0, 0, setsid
    slti $a0, $zero, -1
    li $v0, SYS_exit
    syscall

setsid:
    li $v0, SYS_setsid
    syscall
    li $v0, SYS_fork
    syscall
    beq $v0, 0, forkexit
    slti $a0, $zero, -1
    li $v0, SYS_exit
    syscall
    */

forkexit:
    /* TODO
    // String manipulation in ARM and setup execve call
    b get_binsh

ret1:
    sw $ra, -16($sp)
    lw $a0, -16($sp)
    b get_tacc

ret2:
    sw $ra, -12($sp)
    b get_userinput

ret3:
    add $ra, $ra, 0
    sw $ra, -8($sp)
    slti $ra, $zero, -1
    sw $ra, -4($sp)

binsh:
    sub $sp, $sp, 16
    slti $a1, $zero, -1
    add $a1, $zero, $sp
    slti $a2, $zero, -1
    li $v0, SYS_execve
    syscall

exit:
    slti $a0, $zero, -1
    li $v0, SYS_exit
    syscall

get_binsh:
    li $t0, -1
    bltzal $t0, ret1
    .string BINSH

get_tacc:
    li $t0, -1
    bltzal $t0, ret2
    .string TACC

get_userinput:
    li $t0, -1
    bltzal $t0, ret3

user_input:
    */
