%define A 4
%define B 2

section .bss
outbuf  resb 2

section .text
global _start

_start:
    mov     rax, A
    add     rax, B
    add     al, '0'
    
    mov     [outbuf], al
    mov     byte [outbuf+1], 10
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, outbuf
    mov     rdx, 2
    
    syscall

    mov     rax, 60
    xor     rdi, rdi
    
    syscall
