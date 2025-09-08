section .text
    global _start
_start:
    push 8
    push 9
    push 10
    call _start
    
     