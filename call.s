section .text
    global _start

print :
    mov rax, 1      ; syscall: write
    mov rdi, 1      ; file descriptor (stdout) 
    push 0x30
    mov rsi , rsp    ; buffer address
    mov rdx, 8      ; buffer size
    syscall
    pop rax
    ret
    
    
exit :
    mov rax, 60
    mov rdi, 0
    syscall
    ret
    

_start:
    call print
    call exit
