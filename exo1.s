%define A 2
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
    mov     rax, 1            ; SYS_write
    mov     rdi, 1            ; fd = stdout
    mov     rsi, outbuf       ; buffer
    mov     rdx, 2            ; longueur = 2 (chiffre + '\n')
    
    syscall

    mov     rax, 60           ; SYS_exit
    xor     rdi, rdi          ; code de retour = 0
    
    syscall
