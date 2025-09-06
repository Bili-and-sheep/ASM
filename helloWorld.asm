; Hello World in x86-64 Assembly

section .data
 msg db "Hello, world!", 10 ; la chaîne + saut de ligne
 len equ $ - msg ; longueur de la chaîne

section .text
 global _start
_start:
 mov rax, 1
 mov rdi, 1
 mov rsi, msg
 mov rdx, len
 syscall

 mov rax, 60
 xor rdi, rdi
 syscall