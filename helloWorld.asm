; Hello World in x86-64 Assembly

section .text
    global _start

_start:
    mov rax, 21212168656C6C6F0A ; 'hello\n' in hex
    push rax
    mov rax, 1      ; rax = 2
    mov rbx, 1      ; rbx = 2
    mov rsi, rsp    ; rax = rax + rbx
    
   
    mov rdx, 8     
    
    syscall

    mov rax, 60
    mov rdi, 0

    syscall
