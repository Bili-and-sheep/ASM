; Hello World in x86-64 Assembly

section .text
    global _start

_start:
    mov rax, 68656C6C6F212121h
    push rax
    mov rax, 1      ; rax = 2
    mov rbx, 1      ; rbx = 2
    mov rsi, rsp    ; rax = rax + rbx
    
   
    mov rdx, 8     
    
    syscall

    mov rax, 60
    mov rdi, 0

    syscall
