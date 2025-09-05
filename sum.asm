section .text
    global _start

_start:
    mov rax, 2      ; rax = 2
    mov rbx, 2      ; rbx = 2
    add rax, rbx    ; rax = rax + rbx
    
    mov rdi, rax    ; code de retour = somme
    mov rax, 60     ; syscall exit
    syscall