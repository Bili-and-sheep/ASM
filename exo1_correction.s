section .text
    global _start

_start:
    mov rax, 4
    add rax, 2

    add rax, 30h.  ;30h = 0 en ascii , on ajoute 30h pour convertir le nombre en ascii, ex : 6 + 30h = 36h = 6 en ascii
    push rax

    

