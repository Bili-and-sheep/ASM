section .text
    global _start

_start:
    mov rax, 3
    add rax, 4

    add rax, 30h
    push rax

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall